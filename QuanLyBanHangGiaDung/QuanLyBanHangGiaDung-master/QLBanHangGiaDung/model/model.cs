using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace QLBanHangThietBiCongNghe.model
{
    public class SqlConnectionData
    {
        public long OrderId { get; set; }
        public long Amount { get; set; }
        public string OrderDesc { get; set; }

        public DateTime CreatedDate { get; set; }
        public string Status { get; set; }

        public long PaymentTranId { get; set; }
        public string BankCode { get; set; }
        public string PayStatus { get; set; }

        public static SqlConnection Connect()
        {
            string strCnn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
            SqlConnection cnn = null;
            if (cnn == null)
            {
                cnn = new SqlConnection(strCnn);
            }
            if (cnn.State == ConnectionState.Closed)
            {
                cnn.Open();
            }
            return cnn;
        }
    }
    public class model
    {
       // function here
    }
}