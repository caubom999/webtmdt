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
    public partial class QuanLyPhanHoi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadListComment();
                if(Request.QueryString["maphanhoi"] != null)
                {
                    int maphanhoi = Int32.Parse(Request.QueryString["maphanhoi"]);
                    XoaPhanHoi(maphanhoi);
                }
            }
        }
        protected void LoadListComment()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getComment";
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpDanhSachPhanHoi.DataSource = dt;
            rpDanhSachPhanHoi.DataBind();
        }
        protected void XoaPhanHoi(int maphanhoi)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "XoaPhanHoi";
            cmd.Parameters.AddWithValue("@ma",maphanhoi);
            cmd.Connection = cnn;
            int i = cmd.ExecuteNonQuery();
            if(i > 0)
            {
                thongbaophanhoi.Text = "Xóa thành công";
                LoadListComment();
            }
            else
            {
                thongbaophanhoi.Text = "Xóa thất bại";
                LoadListComment();
            }
        }
    }
}