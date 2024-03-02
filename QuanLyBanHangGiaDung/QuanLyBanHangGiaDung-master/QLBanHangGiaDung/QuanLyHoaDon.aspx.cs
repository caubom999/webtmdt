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
    public partial class QuanLyHoaDon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                if (Request.QueryString["action"] == "lock")
                {
                    int mahd = Int32.Parse(Request.QueryString["mahd"]);
                    Huydon(mahd);
                }
                if (Request.QueryString["action"] == "unlock")
                {
                    int mahd = Int32.Parse(Request.QueryString["mahd"]);
                    Daduyet(mahd);
                }
                LoadBill();
            }
        }
        protected void Daduyet(int mahd)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "unlockuser2";
            cmd.Parameters.AddWithValue("@mahd", mahd);
            cmd.Connection = cnn;
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                thongbaohd.Text = "Duyệt đơn hàng thành công!";
                LoadBill();
            }
            else
            {
                thongbaohd.Text = "Duyệt đơn hàng thất bại";
                LoadBill();
            }
        }
        protected void Huydon(int mahd)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "lockuser2";
            cmd.Parameters.AddWithValue("@mahd", mahd);
            cmd.Connection = cnn;
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                thongbaohd.Text = "Hủy đơn hàng thành công!";
                LoadBill();
            }
            else
            {
                thongbaohd.Text = "Hủy đơn hàng thất bại";
                LoadBill();
            }
        }
        protected  void LoadBill()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "chitiethoadonnew1";
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpDanhSachSP.DataSource = dt;
            rpDanhSachSP.DataBind();
        }
    }
}