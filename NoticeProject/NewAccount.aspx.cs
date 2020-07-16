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
    public partial class NewAccout : System.Web.UI.Page
    {
        private static string sqlConnect = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
        private static Boolean ID_Valid = false;
        DataTable dataTable = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DropBoxBinding();
            }
        }

        protected void compareID_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(sqlConnect);
            string sql = "SELECT COUNT(user_id) FROM UserInfo WHERE user_id=@UserID";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@UserID", LoginID.Text);

            con.Open();
            int value = (int)cmd.ExecuteScalar();
            con.Close();

            if (value > 0) ID_Valid = true;
            else ID_Valid = false;

            if (ID_Valid)
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script>alert('중복된 아이디입니다.');</script>");
            }
            else
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script>alert('사용가능한 아이디입니다.');</script>");
            }
        }

        protected void createAccount_Click(object sender, EventArgs e)
        {
            if (!ID_Valid)
            {
                SqlConnection con = new SqlConnection(sqlConnect);
                string sql = "INSERT INTO UserInfo(user_id, user_pw, name, brithday, email, phone) VALUES (@UserID, @Password, @Name, @Birth, @Email, @Phone)";
                SqlCommand cmd = new SqlCommand(sql, con);

                // @UserID, @Password, @Name, @Birth, @Email, @Phone
                cmd.Parameters.AddWithValue("@UserID", LoginID.Text);
                cmd.Parameters.AddWithValue("@Password", LoginPW.Text);
                cmd.Parameters.AddWithValue("@Name", userName);
                cmd.Parameters.AddWithValue("@Email", eMail);
            }
            else
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script>alert('중복된 아이디입니다.');</script>");
            }
        }

        protected void backToMain_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }

        protected void Customer_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string Number1 = args.Value;

            // 문자열이 존재하면 if문 실행 IsNullOrEmpty는 null일 경우 true
            if (String.IsNullOrEmpty(Number1))
            {
                args.IsValid = false;
            }
            else
            {
                string Number2 = PhoneNumber2.Text;
                if (String.IsNullOrEmpty(Number2))
                {
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;
                }
            }
        }

        // 드롭 박스에서 '연도'를 선택했을 경우
        protected void birthYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        // 드롭 박스에서 '월'을 선택했을 경우 
        protected void birthMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        // 드롭 박스에서 '일'을 선택했을 경우
        protected void birthDay_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }


        // 드롭 박스에서 "년" "월" "일" 선택
        void DropBoxBinding()
        {
            // 생년월일의 "년"을 구하는 구간 
            string years_string = DateTime.Now.ToString("yyyy");
            int years = int.Parse(years_string);

            for (int i = years; i >= 1940; i--)
            {
                    birthYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            birthYear.Items.FindByText(System.DateTime.Now.Year.ToString()).Selected = true;


            // 생년월일의 "월"을 구하는 구간 
            string month_string = DateTime.Now.ToString("MM");
            int month_N = int.Parse(month_string);

            birthMonth.Items.Clear();
            for (int i = 1; i <= 12; i++)
            {
                birthMonth.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            birthMonth.Items.FindByText(System.DateTime.Now.Month.ToString()).Selected = true;


            // 생년월일의 "일"을 구하는 구간 
            string day_string = DateTime.Now.ToString("dd");
            int[] day_ = new int[] { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

            int select_year = int.Parse(birthYear.Text);
            if ((select_year % 4 == 0) || (select_year % 100 == 0))
            {
                if (select_year % 100 == 0)
                {
                    day_[1] = 28;
                }
                else
                {
                    day_[1] = 29;
                }
            }

            birthDay.Items.Clear();
            for (int i = 1; i <= day_[month_N - 1]; i++)
            {
                birthDay.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            int day_N = int.Parse(day_string) - 1;
            birthDay.Items.FindByText(System.DateTime.Now.Day.ToString()).Selected = true;
        }
    }
}