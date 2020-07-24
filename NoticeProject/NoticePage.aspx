<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NoticePage.aspx.cs" Inherits="NoticeProject.LoginPage" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >
    <script runat="server">

    </script>

    <link rel="stylesheet" href="PageSheet.css" />

    
    <div id="wrapper">

    <div id="sidebar">
        <div id="profile">
            어서오세요! <br /><asp:Label ID="Login_UserID_lbl" runat="server" BorderColor="Blue" Text="" />님, 환영합니다.<br />
            <asp:Button ID="Logout" runat="server" Text="로그아웃" />
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
    <hr />
    <asp:GridView ID="NoticeGrid" runat="server" 
        DataSourceID="SqlDataSource"
        emptydatatext="No data avilable"
        AllowPaging="True"
        AllowSorting="True"
        
        AutoGenerateColumns="False"
        DataKeyNames="number"
        ForeColor="#333333" GridLines="None" 
        OnSelectedIndexChanged="NoticeGrid_SelectedIndexChanged">

        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />

        <Columns>
            <asp:BoundField DataField="number" 
                ItemStyle-Width="9%"
                HeaderText="ID" 
                InsertVisible="false" ReadOnly="true" 
                SortExpression="number" 
                ItemStyle-HorizontalAlign="Center" ShowHeader="true"/>
            
            <asp:HyperLinkField DataTextField="header" 
                ItemStyle-Width="28%"
                DataNavigateUrlFields="number, user_id"
                DataNavigateUrlFormatString="~/Contact.aspx?board_id={0}&user={1}"
                target="_self"
                HeaderText="Header" 
                ControlStyle-ForeColor="Blue"
                SortExpression="header"
                ItemStyle-HorizontalAlign="Center" ShowHeader="true">
            </asp:HyperLinkField>

            <asp:BoundField DataField="user_id"
                ItemStyle-Width="22%"
                HeaderText="Written"
                InsertVisible="false" ReadOnly="true"
                SortExpression="user_id"
                ItemStyle-HorizontalAlign="Center" ShowHeader="true"/>

            <asp:BoundField DataField="input_date" 
                ItemStyle-Width="21%"
                HeaderText="Date" 
                SortExpression="input_date" 
                DataFormatString="{0:yyyy/MM/dd}"
                ItemStyle-HorizontalAlign="Center" ShowHeader="true"/>

            <asp:TemplateField HeaderText="others" ItemStyle-HorizontalAlign="Center" 
                ShowHeader="true" ItemStyle-Width="20%">
                <ItemTemplate>
                    <asp:Button ID="deleteBtn" runat="server" Text="삭제"  
                        Width="50px" Height="27px"
                        CommandName="DeleteItem"
                        CommandArgument='<% # Eval("user_id") %>' 
                        OnClick="deleteBtn_Click"/>
                    
                    <asp:Button ID="updateBtn" runat="server" Text="수정" 
                        Width="50px" Height="27px"
                        CommandName="UpdateItem"
                        CommandArgument='<% # Eval("user_id") %>' 
                        OnClick="updateBtn_Click"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>


    <!--게시판 메인 화면 구성(mssql에서 게시판의 내용을 가져와 gridview로 보여줌)-->

    <!--해당 GridView는 메인 화면에 표시될 게시판에 대한 설정이다.-->
    <!--DataNavigateUrlFields는 gridview 내에 있는 DataField의 값을 가져오고 -->
    <!--HyperLink에 DataNavigateUrlFormatString을 통해 해당 값을 넣어준다.-->

    <!--메인 게시판에 게시물의 목록을 가져오는 JQuary-->
    <asp:SqlDataSource ID="SqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT number, user_id, header, input_date FROM dbo.Board ORDER BY number DESC">
    </asp:SqlDataSource> 
    
    <hr />
    <asp:Panel ID="Panel1" runat="server" Width="60%" Height="50px" HorizontalAlign="Right">
        <asp:Button ID="NewNotice" runat="server" Text="게시물 작성" OnClick="NewNotice_Click" />
    </asp:Panel>

    </center>
    </div>
    </div>


    <div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

   
    <p>Use this area to provide additional information.</p>

</asp:Content>

