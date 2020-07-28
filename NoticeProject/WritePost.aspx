<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="WritePost.aspx.cs" Inherits="NoticeProject.WritePost" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    

    <script runat="server">
    
    </script>


    <link rel="stylesheet" href="PageSheet.css" />

    <div id="wrapper">

    <div id="sidebar">
        <div id="profile">
            어서오세요! <br /><asp:Label ID="Login_UserID_lbl" runat="server" BorderColor="Blue" Text="" />님, 환영합니다.<br />
            <asp:Button ID="Logout" runat="server" Text="로그아웃" OnClick="Logout_Click" />
        </div>
        <br />
        <div style="padding-left:5px;" >
            <asp:TreeView ID="SiteMenu" runat="server" DataSourceID="SiteMapDataSource1"
                 ShowLines="True" Height="250px" Width="195px"></asp:TreeView>
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
        </div>
    </div>

    <div id="contents">
    <center>
    <asp:Table ID="WriteTable" runat="server">
        <asp:TableRow>
            <asp:TableCell HorizontalAlign="Right">
                작성자 : 
            </asp:TableCell>
            <asp:TableCell>
                <asp:Label ID="Written" runat="server" Text="" />
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell HorizontalAlign="Right">
                제목 :
            </asp:TableCell><asp:TableCell>
                <asp:TextBox ID="WriteHeader" runat="server" MaxLength="30" Width="550"/>
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell HorizontalAlign="Right" VerticalAlign="Top">
                내용 :
            </asp:TableCell><asp:TableCell>
                <asp:TextBox ID="WriteContents" runat="server" Width="550"
                    TextMode="MultiLine" Rows="20" Wrap="true"/>
            </asp:TableCell></asp:TableRow><asp:TableRow>
            <asp:TableCell HorizontalAlign="Right">
                첨부파일 : 
            </asp:TableCell><asp:TableCell>
                <asp:FileUpload ID="FileUpLoad" runat="server" Width="550" />
            </asp:TableCell></asp:TableRow></asp:Table><asp:RequiredFieldValidator 
        ID="CheckHeader" runat="server" 
        ValidationGroup="CreateBoard"
        ForeColor="Red" Font-Size="Medium"
        ControlToValidate="WriteHeader"
        ErrorMessage="제목을 입력하세요."
        Display="Dynamic" />
    <asp:RequiredFieldValidator
        ID="CheckContents" runat="server"
        ValidationGroup="CreateBoard"
        ForeColor="Red" Font-Size="Medium"
        ControlToValidate="WriteContents"
        ErrorMessage="내용을 입력하세요."
        Display="Dynamic" />

    <hr />

    <asp:Button ID="CancelBtn" runat="server" 
        Text="취소" OnClick="CancelBtn_Click" 
        Width="80" Height="30" />
    <asp:Button ID="CreateBoardBtn" runat="server" Text="작성완료" 
        OnClick="CreateBoardBtn_Click" 
        Width="80" Height="30" 
        ValidationGroup="CreateBoard" />
    <asp:Button ID="UpdateContentsBtn" runat="server" Text="수정완료"
        OnClick="UpdateContentsBtn_Click"
        Width="80" Height="30"
        ValidationGroup="CreateBoard" />

    </center>
    </div>
    </div>
</asp:Content>
