<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NewAccount.aspx.cs" Inherits="NoticeProject.NewAccout" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >

    <script type="text/javascript">

    </script>
         

    <center>
    <h3>계정을 생성하세요.</h3>
    <hr style="width:50%;"/><br />

    <div>
        <asp:Label ID="testlbl" runat="server" Text="" />
        <table>
            <tr>
            <td align=right> 이름 : </td>
            <td><asp:TextBox ID="userName" runat="server" Text="" /></td></tr>
            <tr><td><td>
                <asp:RequiredFieldValidator ID="RequireValidator2" runat="server"
                    ControlToValidate="userName"
                    Display="Dynamic"
                    ForeColor="Red" Font-Size="Small"
                    ValidationGroup="vali"
                    ErrorMessage="이름은 반드시 입력해야합니다." />
                </td></tr>

            <tr>
            <td align="right"> 생년월일 : </td>
            <td><asp:DropDownList ID="birthYear" runat="server" 
                    OnSelectedIndexChanged="birthYear_SelectedIndexChanged"/>년
                <asp:DropDownList ID="birthMonth" runat="server"
                    AutoPostBack="true" OnSelectedIndexChanged="birthMonth_SelectedIndexChanged"/>월
                <asp:DropDownList ID="birthDay" runat="server" 
                    AutoPostBack="true" OnSelectedIndexChanged="birthDay_SelectedIndexChanged" />일
            </td></tr>
            <tr><td><td>
                </td></tr>

            <tr>
            <td align=right> 아이디 : </td>
            <td><asp:TextBox ID="LoginID" runat="server" MaxLength="10"/>
                <asp:Button ID="compareID" runat="server" Text="중복확인" OnClick="compareID_Click"/>
                </td>
            <tr><td><td>
                <asp:RegularExpressionValidator ID="ID_Check_valid" runat="server" 
                    ControlToValidate="LoginID" 
                    ValidationExpression="(?!^[0-9]*$)(?!^[a-zA-Z]*$)^(.{4,15})$"
                    Display="Dynamic"
                    ForeColor="Red" Font-Size="Small"
                    ValidationGroup="vali"
                    ErrorMessage="아이디를 입력하세요(영어 또는 숫자 4자 이상)." />
                </td></tr>
            
            <tr>
            <td align=right> 비밀번호 : </td>
            <td>
                <asp:TextBox ID="LoginPW" runat="server" MaxLength="30" TextMode="Password" />
                </td></tr>
            <tr><td><td>
                <asp:RegularExpressionValidator ID="RegularExpress1" runat="server"
                    ControlToValidate="LoginPW" 
                    ValidationExpression="^(?=.*[a-z])(?=.*[0-9]).{4,30}$"
                    ForeColor="Red" Font-Size="Small"
                    ValidationGroup="vali"
                    ErrorMessage="비밀번호는 4~30자리입니다."
                    Display="Dynamic" />
                </td></tr>

            <tr>
            <td align=right> 비밀번호 확인 : </td>
            <td><asp:TextBox ID="passCheck" runat="server" TextMode="Password" /></td></tr>
            <tr><td><td>
                <asp:CompareValidator ID="comparePassword" runat="server"
                    ControlToCompare="LoginPW"
                    ControlToValidate="passCheck"
                    ForeColor="Red" Font-Size="Small"
                    ErrorMessage="비밀번호가 일치하지 않습니다."
                    Display="Dynamic"/>
                </td></tr>

            <tr>
            <td align=right> 이메일 : </td>
            <td><asp:TextBox ID="eMail" runat="server" Text="" Width="100" /> @
                <asp:DropDownList ID="webSiteList" runat="server" Width="100">
                    <asp:ListItem>naver.com</asp:ListItem>
                    <asp:ListItem>daum.com</asp:ListItem>
                    <asp:ListItem>google.com</asp:ListItem>
                    <asp:ListItem>chol.com</asp:ListItem>
                    <asp:ListItem>nate.com</asp:ListItem>
                </asp:DropDownList>
            </td></tr>
            <tr><td><td>
                <asp:RequiredFieldValidator ID="RequireValidator3" runat="server"
                    ControlToValidate="eMail"
                    ForeColor="Red" Font-Size="Small"
                    ValidationGroup="vali"
                    ErrorMessage="이메일은 필수 입력사항 입니다." 
                    Display="Dynamic"/>
                </td></tr>

            <tr>
            <td align=right> 전화번호 : </td>
            <td><asp:DropDownList ID="FrontNumber" runat="server" Width="50">
                    <asp:ListItem>010</asp:ListItem>
                    <asp:ListItem>011</asp:ListItem>
                </asp:DropDownList> -
                <asp:TextBox ID="PhoneNumber" runat="server" Text="" MaxLength="9" Width="100"/>
            </td></tr>
            <tr><td><td>
                <asp:RegularExpressionValidator ID="phoneNumberCheck" runat="server"
                    ControlToValidate="PhoneNumber"
                    ValidationExpression="\d{4}-\d{4}"
                    ForeColor="Red" Font-Size="Small"
                    ValidationGroup="vali"
                    ErrorMessage="중간에 '-'를 넣고 번호를 모두 입력해주세요."
                    Display="Dynamic" />
                </td></tr>
        </table>

        <p>
            <input ID="backToMain" type="button" value="메뉴 화면" 
                OnClick="location.href='Default.aspx'"/>
            <asp:Button ID="createAccount" runat="server" Text="계정 생성" 
                ValidationGroup="vali" OnClick ="createAccount_Click" />
        </p>

    </div><br />
    <hr style="width:50%;"/>
    </center>

</asp:Content>