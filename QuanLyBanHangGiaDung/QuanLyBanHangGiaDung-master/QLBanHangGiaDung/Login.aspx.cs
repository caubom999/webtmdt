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
    public partial class Login1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Hàm gọi khi logout ..Link đăng xuất có dạng Login?action=logout;
            if(Request.QueryString["action"] == "logout")
            {
                Session.Abandon();
                Response.Redirect("Login.aspx");
            }
        }
        // Nhấn login check tk
        public void submitLogin(object sender, EventArgs e)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "checkLogin";
            cmd.Parameters.AddWithValue("@tendangnhap", login.Value);
            cmd.Parameters.AddWithValue("@password", password.Value);
            cmd.Connection = cnn;
           

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                Session.Add("userid", dt.Rows[0].Field<int>("FK_iUserID"));
                Session.Add("username", dt.Rows[0].Field<String>("sName"));
                setPermission();
            }

        }
        // Kiểm tra quyền
        private void setPermission()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getUser";
            cmd.Parameters.AddWithValue("@idUser", Session["userid"]);
            cmd.Connection = cnn;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                Session.Add("userPermission", dt.Rows[0].Field<int>("FK_sPermissionID"));
                // Nếu bằng 1 chuyển qua người dùng
                int ok = dt.Rows[0].Field<int>("FK_sPermissionID");
                if (dt.Rows[0].Field<int>("FK_sPermissionID") == 0)
                    Response.Redirect("TrangChu.aspx");
                else
                    Response.Redirect("HomeAdmin.aspx");
            }
        }
    }
}