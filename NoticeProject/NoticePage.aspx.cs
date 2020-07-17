using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace NoticeProject
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string loginUser = "";

            loginUser = Session["LoginUsers"].ToString();
            Login_UserID_lbl.Text = loginUser + "님, 환영합니다.";


        }

        protected void movepage_Click(object sender, EventArgs e)
        {

        }

        protected void NoticeGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
        }
    }
}