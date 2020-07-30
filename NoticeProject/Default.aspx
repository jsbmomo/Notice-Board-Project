<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NoticeProject._Default" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>
<%@ Import Namespace="System.Data" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script runat="server">
        private static string sqlCon = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs args)
        {
            if (!Page.IsPostBack)
            {

            }
        }

        protected void MovePage_Click(object sender, EventArgs e) // 로그인 성공 시 페이지 넘김
        {
            if (LoginCheck(LoginID.Text, LoginPW.Text))
            {
                Response.Redirect("~/NoticePage.aspx");
            }

            else
                Label1.Text = "아이디 또는 비밀번호를 확인해주세요.";
        }

        protected bool LoginCheck(string loginID, string loginPW) // 신규 회원가입 시 페이지 넘김 
        {
            SqlConnection con = new SqlConnection(sqlCon);
            DataSet dataSet = new DataSet();
            con.Open();

            string sql = "SELECT user_id, authority_root FROM UserInfo WHERE user_id='" +
                          loginID + "' AND user_pw='" + loginPW + "'";
            SqlDataAdapter dataAdapter = new SqlDataAdapter(sql, con);
            dataAdapter.Fill(dataSet,"User information");

            con.Close();

            // 사용자의 아이디와 
            if (dataSet.Tables[0].Rows.Count > 0)
            {
                Session["LoginUsers"] = dataSet.Tables[0].Rows[0]["user_id"].ToString();
                Session["authority"] = dataSet.Tables[0].Rows[0]["authority_root"].ToString();

                return true;
            }
            else
            {
                return false;
            }

        }

        protected void FindPassword_Click(object sender, EventArgs e)
        {

        }

    </script>


    <section>
        <article>
            <h2>Notice Board</h2> <br />
        </article>

        <article>
            <hr style="width:60%;"/><br />
            <table>
                <tr>
                    <td>로그인 </td>
                    <td><asp:TextBox ID="LoginID" runat="server" /> </td>
                    <td rowspan="2"> 
                        <asp:Button ID="MovePage" runat="server" 
                            style="height:50px; width:70px;" 
                            text="로그인" onclick="MovePage_Click" 
                            type="button"/> 
                    </td>
                </tr>
                <tr>    
                    <td>비밀번호 </td>
                    <td><asp:TextBox ID="LoginPW" runat="server" TextMode="Password" /> </td>
                </tr>
            </table>

            <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red" Font-Size="Small"/> <br />
            
            <asp:Button ID="FindPassword" runat="server"
                style="height:25px; width:95px;"
                Text="비밀번호 찾기" OnClick="FindPassword_Click" /> / 
            <input id="CreateAccount" type="button"
                style="height: 25px; width: 70px;"
                value="회원가입" onclick="location.href='NewAccount.aspx'" />

            <br /><br /><br />

            <hr style="width:60%;"/> <br />
               
        </article>
    </section>

</asp:Content>
