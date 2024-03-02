using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace QLBanHangThietBiCongNghe
{
    public partial class TrangChu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //checkSession();
            if(!Page.IsPostBack)
            {
                // Load Sẩn phẩm mới vs SP Nổi bật
                LoadProductNew();
                LoadProductHot();

                if (Request.Form["idproduct"] != null)
                {
                    // Kiểm tra session xem đã login chưa
                    checkSession();
                    // Khi nhấn vào nút thêm vào giỏ hàng
                    addCart();
                }
                else
                {
                   
                }
            }
        }
        protected void checkSession()
        {
            if(Session["userid"] == null || Session["userid"] == "")
            {
                Response.Redirect("Login.aspx");
                Response.End();
            }
        }
        protected void btnAddcart_Click(object sender, EventArgs e)
        {
          //  ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + "a" + "');", true);
        }
        protected void LoadProductNew()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getProductbcall";
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpSpMoi.DataSource = dt;
            rpSpMoi.DataBind();
        }
        protected void LoadProductHot()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getProductHot12";
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpSpNoiBat.DataSource = dt;
            rpSpNoiBat.DataBind();
        }

        protected void addCart()
        {
            // Nhận thông tin User đặt hàng từ biến Session Session["userid"]
            int iduser = Int32.Parse(Session["userid"].ToString());
            // Lấy mã mặt hàng từ biến POST : Request.Form["idproduct"]
            int idproduct = Int32.Parse(Request.Form["idproduct"]);
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "createCart";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idproduct", idproduct);
            cmd.Parameters.AddWithValue("@idcustomer", iduser);
            // Mặc định khi nhấn thêm vào giỏ hàn @amout sẽ là 1, 
            // trong db có trigger tự động lấy hàng theo idproduct và idcustomer này cộng thêm 1 
            cmd.Parameters.AddWithValue("@amount", 1);
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                Response.Write("success");
                Response.End();
            }
            else
            {
                Response.Write("fail");
                Response.End();
            }
        }

    }
}