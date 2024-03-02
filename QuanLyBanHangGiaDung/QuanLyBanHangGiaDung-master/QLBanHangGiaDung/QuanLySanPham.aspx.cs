using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLBanHangThietBiCongNghe
{
    public partial class QuanLySanPham : System.Web.UI.Page
    {

        public static int idCurrentProduct;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                // Load Hết SP
                LoadSP();
                // Load Loại Hàng Lên Commbobox
                LoadLoaiHang();

                if (Request.QueryString["action"] == "delete")
                {
                    int masp = Int32.Parse(Request.QueryString["masp"]);
                    DeleteSP(masp);
                }
                if (Request.QueryString["action"] == "edit")
                {
                    int masp = Int32.Parse(Request.QueryString["masp"]);
                    HienCTSP(masp);
                }
                
            }
        }
        protected void LoadSP()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getAllProduct";
            cmd.Parameters.AddWithValue("@giatu", 0);
            cmd.Parameters.AddWithValue("@giaden", 0);
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpDanhSachSP.DataSource = dt;
            rpDanhSachSP.DataBind();

            radioStatus.Visible = false;
        }
        protected void LoadLoaiHang()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getListProduct";
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            
            ddlLoaiHang.DataSource = dt;
            ddlLoaiHang.DataTextField = "sTypeName";
            ddlLoaiHang.DataValueField = "PK_iType";
            ddlLoaiHang.DataBind();
            ddlLoaiHang.Items.Insert(0, new ListItem("-- Chọn loại sản phẩm --", "0"));
        }
        protected void HienCTSP(int masp)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getProductID";
            cmd.Parameters.AddWithValue("@masp", masp);
            cmd.Connection = cnn;
            SqlDataReader rd = cmd.ExecuteReader();
            if(rd.HasRows)
            {
                while (rd.Read())
                {
                    idCurrentProduct = rd.GetInt32(0);
                    inputTenMH.Value = rd.GetString(1);
                    inputDVT.Value = rd.GetString(2);
                    inputGiaBan.Value = rd.GetDouble(3).ToString();
                    inputGiamGia.Value = rd.GetDouble(8).ToString();
                    inputMoTa.Value = rd.GetString(5);
                    ddlLoaiHang.SelectedValue = rd.GetInt32(4).ToString();
                    if (rd.GetBoolean(6))
                    {
                        dangban.Checked = true; 
                    } 
                    else
                    {
                        ngungkinhdoanh.Checked = true;
                    } 
                    ImgSP.ImageUrl = "images/"+rd.GetString(9);
                }
                rd.Close();
            }

            thongbaosanpham.Visible = false;

            btnCapNhat.Text = "Cập nhật";
            btnCapNhat.CommandName = "update";
            radioStatus.Visible = true;
        }

        // ấn thêm hoặc cập nhậ nó cahjy vào đây
        protected void clickButtonAddUpdate(object sender, EventArgs e)
        {
            
            string name = inputTenMH.Value;
            string unit = inputDVT.Value;
            string price = inputGiaBan.Value;
            string type = ddlLoaiHang.SelectedValue;
            string des = inputMoTa.Value;
            string pro = inputGiamGia.Value;
            string image = "";
            int status = dangban.Checked ? 1 : 0;
            if (ImgSP.ImageUrl != "")
            {
                // Khi chạy thì giá trị của ImageURl Images/teenanhr.jpg
                // hàm này chỉ lấy tên ảnh
                image = ImgSP.ImageUrl.Substring(6);
            }

            if (name == "" || unit == "" || price == "" || type == "" || des == "" || pro == "" || image == "")
            {
                // thông báo lên k đc để trống
                thongbaosanpham.Text = "Thêm đầy đủ thông tin";
            }
            
            else
            {
                Button btn = (Button)sender;
                switch (btn.CommandName)
                {
                    case "add":
                        CreateSP(name, unit, price, type, des, pro, image);
                        break;
                    case "update":
                        UpdateSP(name, unit, price, type, des, pro, image, status);
                        break;
                }
            }
            thongbaosanpham.Visible = true;

        }

        protected void CreateSP(string name, string unit, string price, string type, string des, string pro, string image)
        {

            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "createProduct";
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@unit", unit);
            cmd.Parameters.AddWithValue("@price", price);
            cmd.Parameters.AddWithValue("@type", type);
            cmd.Parameters.AddWithValue("@description", des);
            cmd.Parameters.AddWithValue("@promotion", pro);
            cmd.Parameters.AddWithValue("@image", image);
            cmd.Connection = cnn;
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                thongbaosanpham.Text = "Thêm thành công";
                clear();
                LoadSP();
            }
            else
            {
                thongbaosanpham.Text = "Thêm thất bại";
            }

        }

        protected void UpdateSP(string name, string unit, string price, string type, string des, string pro, string image, int status)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "updateProduct";
            cmd.Parameters.AddWithValue("@idproduct", idCurrentProduct);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@unit", unit);
            cmd.Parameters.AddWithValue("@price", price);
            cmd.Parameters.AddWithValue("@type", type);
            cmd.Parameters.AddWithValue("@description", des);
            cmd.Parameters.AddWithValue("@promotion", pro);
            cmd.Parameters.AddWithValue("@image", image);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Connection = cnn;
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                thongbaosanpham.Text = "Update thành công";
                clear();
                LoadSP();
            }
            else
            {
                thongbaosanpham.Text = "Update thất bại";
            }
        }

        protected void DeleteSP(int masp)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "deleteProduct";
            cmd.Parameters.AddWithValue("@idproduct", masp);
            cmd.Connection = cnn;
            int i = cmd.ExecuteNonQuery();
            if (i > 0)
            {
                thongbaosanpham.Text = "Đã ngừng kinh doanh sản phẩm";
                clear();
                LoadSP();
            }
            else
            {
                thongbaosanpham.Text = "Có lỗi xảy ra vui lòng thử lại";
            }

            thongbaosanpham.Visible = true;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clear();
        }

        protected void clear()
        {
            inputTenMH.Value = "";
            inputDVT.Value = "";
            inputGiaBan.Value = "";
            ddlLoaiHang.SelectedIndex = 0;
            inputMoTa.Value = "";
            inputGiamGia.Value = "";
            ImgSP.ImageUrl = "";
            radioStatus.Visible = false;
            thongbaosanpham.Visible = false;
            btnCapNhat.Text = "Thêm";
            btnCapNhat.CommandName = "add";
        }
        
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (Page.IsValid && inputAnh1.HasFile && CheckFileType(inputAnh1.FileName))
            {
                string fileName = "images/"+DateTime.Now.ToString("ddMMyyyy_hhmmss_tt_") + inputAnh1.FileName;
                string filePath = MapPath(fileName);
                inputAnh1.SaveAs(filePath);
                ImgSP.ImageUrl = fileName;
            }
        }
        // Check file ảnh 
        bool CheckFileType(string fileName)
        {

            string ext = Path.GetExtension(fileName);
            switch (ext.ToLower())
            {
                case ".gif":
                    return true;
                case ".png":
                    return true;
                case ".jpg":
                    return true;
                case ".jpeg":
                    return true;
                default:
                    return false;
            }
        }

    }
}