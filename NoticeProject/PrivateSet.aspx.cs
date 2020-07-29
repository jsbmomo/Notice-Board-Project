using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
        private static DataSet dataSet = new DataSet();
        private static string password = "";
        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Remove("LoginUsers");
            Response.Redirect("~/Default.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Label1.Text = Session["LoginUsers"].ToString();
                string findUser = Session["LoginUsers"].ToString();

                SqlConnection con = new SqlConnection(sqlCon);
                con.Open();

                string sqlcmd = "SELECT * FROM UserInfo WHERE user_id='" + findUser + "'";
                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlcmd, con);
                dataAdapter.Fill(dataSet,"User information");

                con.Close();


                if(dataSet.Tables[0].Rows[0]["authority_root"].ToString() == "1")
                {
                    Grade.Value = "< " + "관리자" + " >";
                }
                else
                {
                    Grade.Value = "< " + "일반 회원" + " >";
                }

                UserName.Value = dataSet.Tables[0].Rows[0]["name"].ToString();
                UserID.Value = dataSet.Tables[0].Rows[0]["user_id"].ToString();
                Email.Value = dataSet.Tables[0].Rows[0]["email"].ToString();
                Phone.Value = dataSet.Tables[0].Rows[0]["phone"].ToString();

                // 사용자가 비밀번호 변경 시, 현재 비밀번호가 맞는지 확인하기 위해 사용
                password = dataSet.Tables[0].Rows[0]["user_pw"].ToString(); 

                string birthday = dataSet.Tables[0].Rows[0]["brithday"].ToString();
                string joindate = dataSet.Tables[0].Rows[0]["join_date"].ToString();

                Birthday.Value = birthday.Substring(0, 10);
                JoinDate.Value = joindate.Substring(0, 10);
            }
        }


        protected void UserDataSet(object sender, EventArgs e)
        {
            
        }

        // 사용자가 데이터 변경 후, 저장 버튼을 눌렀을 때,
        protected void UpdateInfo_ServerClick(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(sqlCon);
            string sqlcmd = "UPDATE UserInfo SET name=@Name, birthday=@Birth, phone=@Phone, email=@Email WHERE user_id=@UserID";
            SqlCommand cmd = new SqlCommand(sqlcmd, con);

            cmd.Parameters.AddWithValue("@UserID", Session["LoginUsers"].ToString());
            cmd.Parameters.AddWithValue("@Name", UserName.Value);
            cmd.Parameters.AddWithValue("@Birth", Birthday.Value);
            cmd.Parameters.AddWithValue("@Phone", Phone.Value);
            cmd.Parameters.AddWithValue("@Email", Email.Value);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            ClientScript.RegisterStartupScript(typeof(Page), "alert",
                "<script> alert('정상적으로 변경되었습니다.'); </script>");
        }

        protected void Password_ServerClick(object sender, EventArgs e)
        {
            if(password == NowPassWord.Value) // 만약 현재 사용자의 비밀번호가 맞다면 비밀번호 업데이트
            {
                SqlConnection con = new SqlConnection(sqlCon);
                string sqlcmd = "UPDATE UserInfo SET user_pw=@PassWord WHERE user_id=@UserID";
                SqlCommand cmd = new SqlCommand(sqlcmd, con);

                cmd.Parameters.AddWithValue("@UserID", Session["LoginUsers"].ToString());
                cmd.Parameters.AddWithValue("@PassWord", UserName.Value);
                
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script> alert('비밀번호가 변경되었습니다.') </script>");
            }
            
        }
    }
}