using NoticeProject.DBConnection;
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
        private static string password = "";

        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Remove("LoginUsers");
            Session.Remove("authority");
            Response.Redirect("~/Default.aspx");
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Label1.Text = Session["LoginUsers"].ToString();
                string findUser = Session["LoginUsers"].ToString();

                string sqlcmd = @"SELECT * FROM dbo.UserInfo 
                                  WHERE 
                                        [user_id] = @1";
                MSConnection connection = new MSConnection();
                DataTable dataTable = connection.GetDataTable(sqlcmd, findUser);
                connection.CloseDB();

                if(Boolean.Parse(Session["authority"].ToString()))
                    Grade.Value = "< " + "관리자" + " >";
                else 
                    Grade.Value = "< " + "일반 회원" + " >";


                UserName.Value = dataTable.Rows[0]["name"].ToString();
                UserID.Value = dataTable.Rows[0]["user_id"].ToString();
                Email.Value = dataTable.Rows[0]["email"].ToString();
                Phone.Value = dataTable.Rows[0]["phone"].ToString();

                // 사용자가 비밀번호 변경 시, 현재 비밀번호가 맞는지 확인하기 위해 별도 저장
                password = dataTable.Rows[0]["user_pw"].ToString(); 

                string birthday = dataTable.Rows[0]["brithday"].ToString();
                string joindate = dataTable.Rows[0]["join_date"].ToString();
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
            string sqlcmd = @"UPDATE dbo.UserInfo SET 
                                    [name] = @1,
                                    [brithday] = @2,
                                    [phone] = @3,
                                    [email] = @4
                              WHERE 
                                    [user_id] = @5";
            List<object> param = new List<object>();
            param.Add(UserName.Value);
            param.Add(Birthday.Value);
            param.Add(Phone.Value);
            param.Add(Email.Value);
            param.Add(Session["LoginUsers"].ToString());

            MSConnection connection = new MSConnection();
            connection.ExcuteQuery(sqlcmd, param);
            connection.CloseDB();

            ClientScript.RegisterStartupScript(typeof(Page), "alert",
                "<script> alert('정상적으로 변경되었습니다.'); </script>");
        }

        protected void Password_ServerClick(object sender, EventArgs e)
        {
            if(password == NowPassWord.Value) // 만약 현재 사용자의 비밀번호가 맞다면 비밀번호 업데이트
            {
                string sqlcmd = @"UPDATE UserInfo SET 
                                        [user_pw] = @1
                                  WHERE
                                        [user_id] = @2";
                List<object> param = new List<object>();
                param.Add(NewPassword.Value);
                param.Add(Session["LoginUsers"].ToString());

                MSConnection connection = new MSConnection();
                connection.ExcuteQuery(sqlcmd, param);
                connection.CloseDB();

                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script> alert('비밀번호가 변경되었습니다.') </script>");
            }
        }
    }
}