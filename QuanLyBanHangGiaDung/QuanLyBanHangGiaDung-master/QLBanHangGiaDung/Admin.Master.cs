using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLBanHangThietBiCongNghe
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        public String nameUser = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null && Session["username"] != "")
            {
                nameUser = Session["username"].ToString();
                //buttonAdmin.Visible = Session["userPermission"].ToString().Equals("2");
            }
        }
    }
}