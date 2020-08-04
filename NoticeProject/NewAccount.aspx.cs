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
    public partial class NewAccout : System.Web.UI.Page
    {
        private static Boolean ID_Valid;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DropBoxBinding();
            } 
        }

        protected void compareID_Click(object sender, EventArgs e)
        {
            string sql = @"SELECT COUNT
                                ([user_id])
                           FROM dbo.UserInfo 
                           WHERE 
                                [user_id]='" + LoginID.Text + "'";
            MSConnection connection = new MSConnection();
            int value = connection.ScalarExecute(sql);
            connection.CloseDB();

            if (value <= 0) ID_Valid = true; // 사용가능함
            else ID_Valid = false;

            if (ID_Valid)
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script>alert('사용가능한 아이디입니다.');</script>");
            }
            else if (string.IsNullOrWhiteSpace(LoginID.Text))
            {
                ID_Check_valid.IsValid = false;
            }
            else
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script>alert('중복된 아이디입니다.');</script>");
            }
        }

        protected void createAccount_Click(object sender, EventArgs e)
        {
            if (ID_Valid)
            {
                string email_data = eMail.Text + '@' + webSiteList.Text;
                string birthday_data = birthYear.Text + '-' + birthMonth.Text + '-' + birthDay.Text;
                string phone_data = FrontNumber.Text + '-' + PhoneNumber.Text;

                // @User_ID, @Password, @Name, @Birth, @Email, @Phone
                string sql = @"INSERT INTO UserInfo(
                                    [user_id], 
                                    [user_pw], 
                                    [name], 
                                    [brithday],
                                    [email], 
                                    [phone]
                               ) 
                               VALUES (
                                    @1,
                                    @2,
                                    @3,
                                    @4,
                                    @5,
                                    @6
                               )";
                List<object> param = new List<object>();
                param.Add(LoginID.Text);
                param.Add(LoginPW.Text);
                param.Add(userName.Text);
                param.Add(email_data);
                param.Add(birthday_data);
                param.Add(phone_data);

                MSConnection connection = new MSConnection();
                connection.ExcuteQuery(sql, param);
                connection.CloseDB();
   
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                        "<script>alert('계정이 생성되었습니다.');</script>");
            }
            else
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                        "<script>alert('아이디 중복 확인을 해주세요.');</script>");
            }
            
        }


        // 드롭박스에서 "년"을 선택했을 경우 
        protected void birthYear_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        // 드롭 박스에서 '월'을 선택했을 경우 
        protected void birthMonth_SelectedIndexChanged(object sender, EventArgs e)
        {
            string str = birthMonth.Text;
            int month_Value = int.Parse(str);

            SelectedMonth(month_Value);
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

            SelectedMonth(month_N); // 현재 "월" 데이터를 받아서 "일" 수 계산 
        }

        void SelectedMonth(int month_N)
        {
            // 생년월일의 "일"을 구하는 구간 
            string day_string = DateTime.Now.ToString("dd");
            int[] day_ = new int[] { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

            int select_year = int.Parse(birthYear.Text); // 윤년일 경우 
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