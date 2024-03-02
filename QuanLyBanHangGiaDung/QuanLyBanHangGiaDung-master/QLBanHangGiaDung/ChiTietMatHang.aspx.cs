using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLBanHangThietBiCongNghe
{
    public partial class ChiTietMatHang : System.Web.UI.Page
    {
        public int maloai;
        public string nameUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["masp"] != null)
            {
                int masp = Int32.Parse(Request.QueryString["masp"]);
                // Gọi thông số của sản phẩm
                LoadChiTietSP(masp);
                // Hiển thị tất cả bình luận
                LoadFeedback(masp);
                if (Request.Form["noidungph"] != null)
                {
                    // Nếu có sự kiện nhấn nút bình luận
                    AddFeedback();
                }              
            }
            else
            {
                // Nếu không có mã hàng cụ thể thì chuyển đến trang Danh sách sản phẩm
                Response.Redirect("DanhSachSanPham.aspx");
                Response.End(); 
            }

            if (!IsPostBack)
            {
                nameUser = Session["username"].ToString(); 
            }
        }
        protected void LoadChiTietSP(int masp)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getProductID";
            cmd.Parameters.AddWithValue("@masp", masp);
            cmd.Connection = cnn;
            SqlDataReader rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                // Gán từ điều khiển bằng dữ liệu truy được 
                tieudesanpham.Text = rd.GetString(1);
                dongia.Text = rd.GetDouble(3).ToString();
                giamgia.Text = rd.GetDouble(8).ToString() + "%";
                lbMotasanpham.Text = rd.GetString(5);
                ImageProduct.ImageUrl = "~/images/" + rd.GetString(9).ToString();
                maloai = rd.GetInt32(4);
            }
            rd.Close();
            LoadProductRelation(maloai);
        }
        // Hiển thị những mặt hàng liên quan.. Lấy 3 mặt hàng theo cùng loại 
        protected void LoadProductRelation(int ma)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getProductRelation";
            cmd.Parameters.AddWithValue("@maloai", ma);
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpSanPhamLienQuan.DataSource = dt;
            rpSanPhamLienQuan.DataBind();
        }
        public void LoadFeedback(int ma)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getAllFeedback";
            cmd.Parameters.AddWithValue("maph", ma);
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpPhanHoi.DataSource = dt;
            rpPhanHoi.DataBind();
        }
        protected void AddFeedback()
        {
            int i = 0;
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getFeedback";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@malsp", Int32.Parse(Request.QueryString["masp"]));
            cmd.Parameters.AddWithValue("@makh", Session["userid"]);
            cmd.Parameters.AddWithValue("@ph", Request.Form["noidungph"]);
            cmd.Parameters.AddWithValue("@date", DateTime.Now);
            i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                string result = String.Format("<hr/><p> Người phản hồi: {0}</p><p> Thời gian đăng: {1}</p><p> Nội dung phản hồi: {2}</p>", Session["username"], DateTime.Now, Request.Form["noidungph"]);
                Response.Write(result);
                Response.End();
            }
            else
            {
                Response.End();
            }
        }
    }

}