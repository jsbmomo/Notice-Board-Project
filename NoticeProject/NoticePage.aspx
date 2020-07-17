<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NoticePage.aspx.cs" Inherits="NoticeProject.LoginPage" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <script runat="server">



    </script>


    어서오세요! <asp:Label ID="Login_UserID_lbl" runat="server" BorderColor="Blue" Text="" />
    
    <hr style="width:650px;"/>
        
    <asp:GridView ID="NoticeGrid" runat="server" 
        
        DataSourceID="SqlDataSource"
        emptydatatext="No data avilable"
        allowpaging="true"
        AutoGenerateColumns="false"
        AutoGenerateEditButton="false"
        DataKeyNames="number" Height="338px" Width="679px">

        <Columns>
            <asp:BoundField DataField="number" HeaderText="Index" 
                InsertVisible="false" ReadOnly="true"
                SortExpression="number" />
            <asp:BoundField DataField="written" HeaderText="ID" SortExpression="written" />
            <asp:BoundField DataField="header" HeaderText="Header" SortExpression="header" />
            <asp:BoundField DataField="input_date" HeaderText="Date" SortExpression="input_date" />

            <asp:TemplateField HeaderText="others">
                <ItemTemplate>
                    <asp:Button ID="deleteBtn" runat="server" Text="삭제" 
                        CommandName="DeleteItem"
                        CommandArgument='<% # Eval("written") %>' />
                    <asp:Button ID="updateBtn" runat="server" Text="수정" 
                        CommandName="DeleteItem"
                        CommandArgument='<% # Eval("written") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT number, written, header, input_date FROM dbo.Borad">
    </asp:SqlDataSource>

    <asp:Label ID="testlbl" runat="server" Text="" />

    <hr style="width:640px;" />

    <div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

   
    <p>Use this area to provide additional information.</p>

</asp:Content>

