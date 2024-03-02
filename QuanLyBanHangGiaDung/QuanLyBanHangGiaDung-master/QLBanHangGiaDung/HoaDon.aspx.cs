using QLBanHangThietBiCongNghe.model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using VNPAY_CS_ASPX.Models;

namespace QLBanHangThietBiCongNghe
{
    public partial class HoaDon : System.Web.UI.Page
    {
        public static string total;
        
        protected void btnPay_Click(object sender, EventArgs e)
        {
            //Get Config Info
            string vnp_Returnurl = ConfigurationManager.AppSettings["vnp_Returnurl"]; //URL nhan ket qua tra ve 
            string vnp_Url = ConfigurationManager.AppSettings["vnp_Url"]; //URL thanh toan cua VNPAY 
            string vnp_TmnCode = ConfigurationManager.AppSettings["vnp_TmnCode"]; //Ma định danh merchant kết nối (Terminal Id)
            string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Secret Key

            //Get payment input
            SqlConnectionData order = new SqlConnectionData();
            order.OrderId = DateTime.Now.Ticks; // Giả lập mã giao dịch hệ thống merchant gửi sang VNPAY
            order.Amount = 69360000;
            /*order.Amount = 69360000;*/// Giả lập số tiền thanh toán hệ thống merchant gửi sang VNPAY 100,000 VND
            order.Status = "0"; //0: Trạng thái thanh toán "chờ thanh toán" hoặc "Pending" khởi tạo giao dịch chưa có IPN
            order.CreatedDate = DateTime.Now;
            //Save order to db

            //Build URL for VNPAY
            VnPayLibrary vnpay = new VnPayLibrary();

            vnpay.AddRequestData("vnp_Version", VnPayLibrary.VERSION);
            vnpay.AddRequestData("vnp_Command", "pay");
            vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
            vnpay.AddRequestData("vnp_Amount", (order.Amount * 100).ToString()); //Số tiền thanh toán. Số tiền không mang các ký tự phân tách thập phân, phần nghìn, ký tự tiền tệ. Để gửi số tiền thanh toán là 100,000 VND (một trăm nghìn VNĐ) thì merchant cần nhân thêm 100 lần (khử phần thập phân), sau đó gửi sang VNPAY là: 10000000
            if (bankcode_Vnpayqr.Checked == true)
            {
                vnpay.AddRequestData("vnp_BankCode", "VNPAYQR");
            }
            else if (bankcode_Vnbank.Checked == true)
            {
                vnpay.AddRequestData("vnp_BankCode", "VNBANK");
            }
            else if (bankcode_Intcard.Checked == true)
            {
                vnpay.AddRequestData("vnp_BankCode", "INTCARD");
            }

            vnpay.AddRequestData("vnp_CreateDate", order.CreatedDate.ToString("yyyyMMddHHmmss"));
            vnpay.AddRequestData("vnp_CurrCode", "VND");
            vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());

            if (locale_Vn.Checked == true)
            {
                vnpay.AddRequestData("vnp_Locale", "vn");
            }
            else if (locale_En.Checked == true)
            {
                vnpay.AddRequestData("vnp_Locale", "en");
            }
            vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang:" + order.OrderId);
            vnpay.AddRequestData("vnp_OrderType", "other"); //default value: other

            vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
            vnpay.AddRequestData("vnp_TxnRef", order.OrderId.ToString()); // Mã tham chiếu của giao dịch tại hệ thống của merchant. Mã này là duy nhất dùng để phân biệt các đơn hàng gửi sang VNPAY. Không được trùng lặp trong ngày

            //Add Params of 2.1.0 Version
            //Billing

            string paymentUrl = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);
            
            Response.Redirect(paymentUrl);
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadInfoKH();             
                total = Request.QueryString["total"];
                if (Request.QueryString["idBill"] !=null)
                {
                    LoadBill();
                    buttonsubmit.InnerText = "Trở lại";
                }
                else
                {
                    LoadCarts();
                    buttonsubmit.InnerText = "Đặt hàng";
                }
            }
        }
        protected void LoadInfoKH()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getInfo";
            cmd.Parameters.AddWithValue("@matk", Int32.Parse(Session["userid"].ToString()));
            cmd.Connection = cnn;
            SqlDataReader rd = cmd.ExecuteReader();
            if (rd.HasRows)
            {
                while (rd.Read())
                {
                    hotenkh.Text = rd.GetString(6);
                    diachi.Text = rd.GetString(7);
                    sodienthoai.Text  = rd.GetString(8);
                }
                rd.Close();
            }
        }
        protected void LoadCarts()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "getCheckedProductInCart";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idcustomer", Session["userid"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpDonHang.DataSource = dt;
            rpDonHang.DataBind();
        }
        protected void LoadBill()
        {
            SqlConnection cnn = model.SqlConnectionData.Connect();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "selectDetailBillsProduct";
            cmd.Connection = cnn;
            cmd.Parameters.AddWithValue("@idbill", Request.QueryString["idBill"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rpDonHang.DataSource = dt;
            rpDonHang.DataBind();
        }

        protected void buttonSubmit(object sender, EventArgs e)
        {
            if (Request.QueryString["idBill"] == null)
            {
                SqlConnection cnn = model.SqlConnectionData.Connect();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "createBill";
                cmd.Connection = cnn;
                cmd.Parameters.AddWithValue("@iProductPayment", total);
                cmd.Parameters.AddWithValue("@idcustomer", Session["userid"]);
                cmd.ExecuteNonQuery();
            }
            Response.Redirect("DonHang.aspx");

        }
    }
}