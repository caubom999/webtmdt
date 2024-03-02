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
    public partial class ThongTinCaNhan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                LoadInfo();
            }
        }
       
        protected void LoadInfo()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getInfo";
            cmd.Parameters.AddWithValue("@matk",Int32.Parse(Session["userid"].ToString()));
            cmd.Connection = cnn;
            SqlDataReader rd = cmd.ExecuteReader();
            if(rd.HasRows)
            {
                while(rd.Read())
                {
                    inputhoten.Value = rd.IsDBNull(6) ? "" : rd.GetString(6);
                    inputDiaChi.Value = rd.IsDBNull(7) ? "" : rd.GetString(7);
                    inputsdt.Value = rd.IsDBNull(8) ? "" : rd.GetString(8);
                    inputNgaySinh.Value = rd.IsDBNull(9) ? "" : rd.GetDateTime(9).ToString("dd/MM/yyyy");
                    lbTrangThai.Text = (rd.GetBoolean(10) == true) ? "Kích hoạt" : "Tạm khóa";
                }
                rd.Close();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "updateInfo";
            cmd.Parameters.AddWithValue("@matk", Int32.Parse(Session["userid"].ToString()));
            cmd.Parameters.AddWithValue("@hoten", inputhoten.Value);
            cmd.Parameters.AddWithValue("@diachi", inputDiaChi.Value);
            cmd.Parameters.AddWithValue("@ngaysinh", inputNgaySinh.Value);
            cmd.Parameters.AddWithValue("@sdt", inputsdt.Value);
            cmd.Connection = cnn;
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                lbThongBaoKetQua.Text = "Cập nhật thông tin thành công";
            }
            else
            {
                lbThongBaoKetQua.Text = "Có lỗi trong quá trình cập nhật thông tin";
            }
        }
    }
}