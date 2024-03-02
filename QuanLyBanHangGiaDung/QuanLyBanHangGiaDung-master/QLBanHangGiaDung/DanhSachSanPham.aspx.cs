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
    public partial class DanhSachSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // ...

            if (Request.QueryString["sort"] != null)
            {
                string sortOrder = Request.QueryString["sort"];

                if (sortOrder.Equals("ASC", StringComparison.OrdinalIgnoreCase))
                {
                    // Sort the product list in ascending order
                    SortProductsByPriceAscending();
                }
                else if (sortOrder.Equals("DESC", StringComparison.OrdinalIgnoreCase))
                {
                    // Sort the product list in descending order
                    SortProductsByPriceDescending();
                }
            }


            // ...

            //if (!IsPostBack)
            //{
            // Hiện danh sách sản phẩm
            LoadTypeProduct();
                // Hiện tất cả sản phẩm
                LoadAllProduct(0, 0);
                // Nếu tham số truyền vào là 0,0 thì hiện tất cả sản phẩm
                // Nếu ấn vào từng loại
                
                if (Request.QueryString["maloai"] != null)
                {
                    // Lấy mã loại
                    int ma = Int32.Parse(Request.QueryString["maloai"]);
                    // Nếu người dùng nhấn vào lọc
                    if (Request.Form["filter"] != null)
                    {
                        float giatu = float.Parse(txtgiatu.Value);
                        float giaden = float.Parse(txtgiaden.Value);
                        // Nếu có nhập giá từ và giá đén
                        if (giatu > 0 && giaden > 0)
                        {
                           // Hiện thị sản phẩm theo loại kèm theo khoảng giá
                            LoadProductByType(ma, giatu, giaden);
                        }
                    }

                    // Nếu người dùng vào 1 loại cố định và nhấn tìm kiếm
                    // Kiểm tra xem cái ô tìm kiếm có rỗng hay không
                    else if (Request.Form["search"] != null)
                    {
                        // Tìm kiếm thì tìm kiếm theo từ khóa
                        String keySearch = keysearch.Value;
                        // Hàm tìm kiếm theo từ khóa
                        LoadProductSearch(keySearch);
                    }
                    else
                    {   
                        // Hiện theo loại
                        LoadProductByType(ma, 0, 0);
                    }
                }
                // Không ấn vào loại gì cứ thế tìm kiếm
                else
                {
                    // Kiểm tra xem có lọc không
                    if (Request.Form["filter"] != null)
                    {
                        try
                        {
                            float giatu = float.Parse(txtgiatu.Value);
                            float giaden = float.Parse(txtgiaden.Value);
                            if (giatu > 0 && giaden > 0)
                            {
                                LoadAllProduct(giatu, giaden);
                            }
                        }
                        catch(Exception ex)
                        {

                        }
                    }
                   
                    if (Request.Form["search"] != null)
                    {
                        String keySearch = keysearch.Value;
                   
                        if (keySearch.Trim() != "")
                        {
                            
                            LoadProductSearch(keySearch);
                        }
                        else
                        {
                            // Hiển thị tất cả lên
                            LoadAllProduct(0, 0);
                        }
                    }
                }
            }
        //}
        protected void LoadProductByType(int ma,float giatu,float giaden)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getProductByIDType";
            cmd.Parameters.AddWithValue("@ma", ma);
            cmd.Parameters.AddWithValue("@giatu",giatu);
            cmd.Parameters.AddWithValue("@giaden", giaden);
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpProduct.DataSource = dt;
            rpProduct.DataBind();
        }
        protected void LoadProductSearch(String keySearch)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getProductSearch";       
            cmd.Parameters.AddWithValue("@keySearch", keySearch);
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpProduct.DataSource = dt;
            rpProduct.DataBind();
        }
        protected void LoadAllProduct(float giatu,float giaden)
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getAllProduct";
            cmd.Parameters.AddWithValue("@giatu", giatu);
            cmd.Parameters.AddWithValue("@giaden", giaden);
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpProduct.DataSource = dt;
            rpProduct.DataBind();
        }

        protected void LoadTypeProduct()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getListProduct";
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpDanhMucSP.DataSource = dt;
            rpDanhMucSP.DataBind();
        }
        protected void SortProductsByPriceAscending()
        {
            // Establish a SqlConnection using the Connect method from the SqlConnectionData class
            SqlConnection cnn = model.SqlConnectionData.Connect();

            // Create a new SqlCommand
            SqlCommand cmd = new SqlCommand();

            // Set the command type to StoredProcedure
            cmd.CommandType = CommandType.StoredProcedure;

            // Set the command text to the name of your stored procedure
            cmd.CommandText = "xapxepgia";

            // Set the SqlConnection for the SqlCommand
            cmd.Connection = cnn;

            // Create a new SqlDataAdapter using the SqlCommand
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            // Create a new DataTable to store the result of the stored procedure
            DataTable dt = new DataTable();

            // Fill the DataTable with the data from the stored procedure
            da.Fill(dt);

            // Set the DataTable as the DataSource for a Repeater control (rpProduct)
            rpProduct.DataSource = dt;

            // Bind the data to the Repeater control
            rpProduct.DataBind();
        }


        protected void SortProductsByPriceDescending()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "xapxepgia";
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpProduct.DataSource = dt;
            rpProduct.DataBind();
        }
    }
}