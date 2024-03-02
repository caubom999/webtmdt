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
    public partial class DonHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Form["type"] != null)
                {
                    btnhuydon();
                }
                LoadBill();
            }
        }
        protected void LoadBill()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "chitietdonhang1";
            cmd.Parameters.AddWithValue("@makh", Session["userid"]);
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpDanhSachHD.DataSource = dt;
            rpDanhSachHD.DataBind();
        }
        protected void btnhuydon()
        {
            string idbill = HttpUtility.HtmlEncode(Request.Form["idbill"]);
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "huydonhang3";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idbill", idbill);
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