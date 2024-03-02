using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QLBanHangThietBiCongNghe
{
    public partial class Main : System.Web.UI.MasterPage
    {

        public String nameUser = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] != null && Session["username"] != "")
            {
                nameUser = Session["username"].ToString();
                menuright.Visible = true;
                buttonAdmin.Visible = Session["userPermission"].ToString().Equals("1");
            }
            else
            {
                menuright.Visible = false;
            }
        }
       

    }
}