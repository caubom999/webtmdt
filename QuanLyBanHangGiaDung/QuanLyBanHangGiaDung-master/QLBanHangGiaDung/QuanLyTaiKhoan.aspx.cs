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
    public partial class QuanLyTaiKhoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTaiKhoan();
                if(Request.QueryString["action"] == "lock")
                {
                    int matk = Int32.Parse(Request.QueryString["matk"]);
                    KhoaTaiKhoan(matk);
                }
                if (Request.QueryString["action"] == "unlock")
                {
                    int matk = Int32.Parse(Request.QueryString["matk"]);
                    MoKhoaTaiKhoan(matk);
                }
            }
        }
        protected void MoKhoaTaiKhoan(int matk)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "unlockuser";
            cmd.Parameters.AddWithValue("@matk", matk);
            cmd.Connection = cnn;
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                thongbaotaikhoan.Text = "Mở khóa thành công ok";
                LoadTaiKhoan();
            }
            else
            {
                thongbaotaikhoan.Text = "Mở thất bại";
                LoadTaiKhoan();
            }
        }
        protected void KhoaTaiKhoan(int matk)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "lockuser";
            cmd.Parameters.AddWithValue("@matk",matk);
            cmd.Connection = cnn;
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                thongbaotaikhoan.Text = "Khóa thành công ok";
                LoadTaiKhoan();
            }
            else
            {
                thongbaotaikhoan.Text = "Khóa thất bại";
                LoadTaiKhoan();
            }
        }
        protected void LoadTaiKhoan()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getAllUser";
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpListAccount.DataSource = dt;
            rpListAccount.DataBind();
        }
    }
}