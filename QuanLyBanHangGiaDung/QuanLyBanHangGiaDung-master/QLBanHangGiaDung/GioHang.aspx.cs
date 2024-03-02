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
    public partial class GioHang : System.Web.UI.Page
    {

        public int numberOfProduct = 0;
        public int totalPrice = 0;
        public static int totalPricePass = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadCarts();
                if (Request.Form["type"] != null)
                {
                    updateCart();
                }
                

            }
        }
        // Hiện tất cả sản phẩm đã thêm vào trong giỏ hàng
        
        protected void LoadCarts()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getProductInCart";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idcustomer", Session["userid"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dlGioHang.DataSource = dt;
            dlGioHang.DataBind();
        }
        // Nhấn xác nhận đơn hàng thì chuyển đến trang hóa Đơn
        protected void Button1_OnClick(object Source, EventArgs e)
        {
            Response.Redirect("HoaDon.aspx?total="+ totalPricePass);
            //Response.Redirect("Bạn đã đặt hàng thành công !");
        }

        protected void updateCart()
        {

            switch (HttpUtility.HtmlEncode(Request.Form["type"]))
            {
                case "load":
                    calculate();
                    break;
                case "delete":
                    deleteCart();
                    break;
                case "update":
                    updateAmount();
                    break;
                case "check":
                    int idcart = Int32.Parse(HttpUtility.HtmlEncode(Request.Form["idcart"]));
                    int check = Int32.Parse(HttpUtility.HtmlEncode(Request.Form["value"]));

                    updateCheck(idcart, check);

                    calculate();
                    break;
                case "sync":
                    checkSync();
                    break;
            }
            

        }

        protected void deleteCart()
        {
            string idcart = HttpUtility.HtmlEncode(Request.Form["idcart"]);
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "deleteCart";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idcart", idcart);
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

        protected void updateAmount()
        {
            string idcart = HttpUtility.HtmlEncode(Request.Form["idcart"]);
            string amount = HttpUtility.HtmlEncode(Request.Form["amount"]);
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "updateCart";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idcart", idcart);
            cmd.Parameters.AddWithValue("@amount", amount);
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

        protected void updateCheck(int idcart, int check)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "checkCart";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idcart", idcart);
            cmd.Parameters.AddWithValue("@check", check);
            cmd.ExecuteNonQuery();
        }
        // Hàm kiểm tra xem sản phẩm hiện tại có được check hay không
        protected void checkSync()
        {
            string idcart = HttpUtility.HtmlEncode(Request.Form["idcart"]);
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "checkCartCheck";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idcart", idcart);
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                calculate();
            }
            else
            {
                Response.Write("no");
                Response.End();
            }
        }
        // Hàm này lấy trong db ra tính xem mặt hàng này có sl là bao nhiêu
        // Những mặt hàng nào đc check
        // Hiển thị lên giao diện
        protected void calculate()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            // Lấy ra những mặt hàng trong db đc check
            cmd.CommandText = "getCheckedProductInCart";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idcustomer", Session["userid"]);
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {
                    int price = int.Parse(rdr[3].ToString());
                    int promotion = int.Parse(rdr[8].ToString());
                    int amount = int.Parse(rdr[11].ToString());
                    numberOfProduct++;
                    totalPrice += (price * (100 - promotion) / 100) * amount;
                }
            }
            totalPricePass = totalPrice;
            // trả về chuỗi dạng soluong-tongtien vd: 3-1000000
            Response.Write(numberOfProduct + "-" + totalPrice);
            Response.End();
        }

    }
}