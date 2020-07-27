<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NoticeProject._Default" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Configuration" %>


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
            if (LoginCheck(LoginID.Text, LoginPW.Text) > 0)
            {
                Session["LoginUsers"] = LoginID.Text;
                
                Response.Redirect("~/NoticePage.aspx");
            }
            
            else
                Label1.Text = "아이디 또는 비밀번호를 확인해주세요.";
        }

        protected void CreateAccount_Click(object sender, EventArgs e)
        {

            Response.Redirect("~/NewAccount.aspx");
        }

        protected int LoginCheck(string loginID, string loginPW) // 신규 회원가입 시 페이지 넘김 
        {
            SqlConnection con = new SqlConnection(sqlCon);
            string sql = "SELECT COUNT(user_id) FROM UserInfo WHERE user_id=@UserID AND user_pw=@UserPW";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@UserID", loginID);
            cmd.Parameters.AddWithValue("@UserPW", loginPW);

            con.Open();
            int value = (int)cmd.ExecuteScalar(); // 해당 ID, PW가 존재하면, 개수를 반환
            con.Close();

            return value;
        }
    </script>

    <center>
        <div class="row">

            <h2>Notice Board</h2> <br />
            <hr style="width:60%;"/><br />
            <table>
                <tr>
                <td>로그인 </td>
                <td><asp:TextBox ID="LoginID" runat="server" /> 
                    </td></tr>
                <tr>    
                <td>비밀번호 </td>
                <td><asp:TextBox ID="LoginPW" runat="server" TextMode="Password" /> 
                    </td></tr>
                
            </table>
            <asp:Label ID="Label1" runat="server" Text="" ForeColor="Red" Font-Size="Small"/> <br />
            <asp:Button ID="CreateAccount" runat="server" 
                style="height:30px; width:70px;" 
                Text="회원가입" OnClick="CreateAccount_Click" />
            <asp:Button ID="MovePage" runat="server" 
                style="height:30px; width:70px;" 
                Text="로그인" OnClick="MovePage_Click" /> 
            <br /><br /><br />

            <hr style="width:60%;"/> <br />
               
        </div>
    </center>

</asp:Content>
