using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NoticeProject
{
    public partial class PrivateSet : System.Web.UI.Page
    {
        private string sqlCon = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string findUser = Session["LoginUsers"].ToString();

                SqlConnection con = new SqlConnection(sqlCon);
                string sqlcmd = "SELECT user_id, name, brithday, email, phone FROM UserInfo WHERE user_id=@UserID";
                SqlCommand cmd = new SqlCommand(sqlcmd, con);

                //SqlDataAdapter dataAdapter = cmd.
            }
        }

        protected void UpdateInfo_ServerClick(object sender, EventArgs e)
        {

        }

        protected void Password_ServerClick(object sender, EventArgs e)
        {
            
        }

    }
}