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
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void submitSignup(object sender, EventArgs e)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "createUser";
            
            cmd.Parameters.AddWithValue("@ten", name.Value.Trim());
            cmd.Parameters.AddWithValue("@sdt", phonenumber.Value);
            cmd.Parameters.AddWithValue("@tendangnhap", username.Value);
            cmd.Parameters.AddWithValue("@password", password.Value);
            cmd.Parameters.AddWithValue("@permission", 1);
            cmd.Connection = cnn;
            cmd.ExecuteNonQuery();
            // Hàm này kiểm tra quyền và tài khoản mật khẩu khi đăng nhập 
            setSesion();
        }

        protected void setSesion()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "checkLogin";
            cmd.Parameters.AddWithValue("@tendangnhap", username.Value);
            cmd.Parameters.AddWithValue("@password", password.Value);
            cmd.Connection = cnn;

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            // Nếu có tài khoản có đúng tài khoản và mật như 2 tham số truyền vào bên trên
            if (dt.Rows.Count > 0)
            {
                // gán session 
                Session.Add("userid", dt.Rows[0].Field<int>("PK_iCustomerID"));
                Session.Add("username", dt.Rows[0].Field<String>("sName"));
                Session.Add("userPermission", 2);
                /// Chuyển về trang chủ login luôn
                Response.Redirect("TrangChu.aspx");
            }
        }
    }
}