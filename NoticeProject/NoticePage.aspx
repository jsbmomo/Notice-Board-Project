<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NoticePage.aspx.cs" Inherits="NoticeProject.LoginPage" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >
    <script runat="server">

    </script>

    <center>
    어서오세요! <asp:Label ID="Login_UserID_lbl" runat="server" BorderColor="Blue" Text="" />
    
    <hr style="width:650px;"/>
    
    <!--게시판 메인 화면 구성(mssql에서 게시판의 내용을 가져와 gridview로 보여줌)-->
    <asp:GridView ID="NoticeGrid" runat="server" 
        
        DataSourceID="SqlDataSource"
        emptydatatext="No data avilable"
        allowpaging="true"
        AutoGenerateColumns="false"
        AutoGenerateEditButton="false"
        DataKeyNames="number" Height="340px" Width="680px">

        <Columns>
            <asp:BoundField DataField="number" HeaderText="Index" 
                InsertVisible="false" ReadOnly="true"
                SortExpression="number" />
            <asp:BoundField DataField="user_id" HeaderText="ID" SortExpression="user_id" />
            <asp:BoundField DataField="header" HeaderText="Header" SortExpression="header" />
            <asp:BoundField DataField="input_date" HeaderText="Date" SortExpression="input_date" />

            <asp:TemplateField HeaderText="others">
                <ItemTemplate>
                    <asp:Button ID="deleteBtn" runat="server" Text="삭제" 
                        CommandName="DeleteItem"
                        CommandArgument='<% # Eval("user_id") %>' 
                        OnClick="deleteBtn_Click"/>
                    

                    <asp:Button ID="updateBtn" runat="server" Text="수정" 
                        CommandName="UpdateItem"
                        CommandArgument='<% # Eval("user_id") %>' 
                        OnClick="updateBtn_Click"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT number, user_id, header, input_date FROM dbo.Board">
    </asp:SqlDataSource>

    <asp:Button ID="NewNotice" runat="server" Text="게시물 작성" OnClick="NewNotice_Click" />
    <asp:Button ID="Logout" runat="server" Text="로그아웃" />

    </center>
    
    <hr style="width:640px;" />


    <div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

   
    <p>Use this area to provide additional information.</p>

</asp:Content>

