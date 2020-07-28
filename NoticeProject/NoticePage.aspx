<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NoticePage.aspx.cs" Inherits="NoticeProject.LoginPage" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >
    <script runat="server">
        
    </script>

    <article id="sidebar">
        <div id="profile">
            어서오세요! <br /><asp:Label ID="Login_UserID_lbl" runat="server" BorderColor="Blue" Text="" />님, 환영합니다.<br />
            <input type="submit" name="privateInfoBtn" id="privateInfoBtn" value="개인설정" 
                runat="server" onserverclick="privateInfoBtn_ServerClick" />
            <asp:Button ID="Logout" runat="server" Text="로그아웃" OnClick="Logout_Click" />
        </div>
        <br />
        <div style="padding-left:5px;" >
            <asp:TreeView ID="SiteMenu" runat="server" DataSourceID="SiteMapDataSource1"
                 ShowLines="True" Height="250px" Width="195px"></asp:TreeView>
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
        </div>
    </article>

    <article id="contents">

    <h2>게시판 목록</h2>
    <hr />

    <!--해당 GridView는 메인 화면에 표시될 게시판에 대한 설정이다.-->
    <!--DataNavigateUrlFields는 gridview 내에 있는 DataField의 값을 가져오고 -->
    <!--HyperLink에 DataNavigateUrlFormatString을 통해 해당 값을 넣어준다.-->
    <div class="GridViewClass">
    <asp:GridView ID="NoticeGrid" runat="server" width="100%"
        DataSourceID="SqlDataSource"
        emptydatatext="게시물이 존재하지 않습니다."
        AllowPaging="True"
        AllowSorting="True"
        PageSize="15"
        HeaderStyle-CssClass="GridViewClass"
        AutoGenerateColumns="False"
        DataKeyNames="number"
        ForeColor="#333333" GridLines="None" 
        OnSelectedIndexChanged="NoticeGrid_SelectedIndexChanged">

        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />

        <Columns>
            <asp:BoundField DataField="number" 
                ItemStyle-Width="9%"
                HeaderText="번호" 
                HeaderStyle-HorizontalAlign="Center"
                InsertVisible="false" ReadOnly="true" 
                SortExpression="number" 
                ItemStyle-HorizontalAlign="Center" ShowHeader="true"/>
            
            <asp:HyperLinkField DataTextField="header" 
                ItemStyle-Width="34%"
                DataNavigateUrlFields="number, user_id"
                DataNavigateUrlFormatString="~/Contents.aspx?board_id={0}&user={1}"
                target="_self"
                HeaderText="제목" 
                ControlStyle-ForeColor="Blue"
                SortExpression="header"
                ItemStyle-HorizontalAlign="Center" ShowHeader="true">
            </asp:HyperLinkField>

            <asp:BoundField DataField="user_id"
                ItemStyle-Width="18%"
                HeaderText="작성자"
                InsertVisible="false" ReadOnly="true"
                SortExpression="user_id"
                ItemStyle-HorizontalAlign="Center" ShowHeader="true"/>

            <asp:BoundField DataField="input_date" 
                ItemStyle-Width="21%"
                HeaderText="작성 날짜" 
                SortExpression="input_date" 
                DataFormatString="{0:yyyy/MM/dd}"
                ItemStyle-HorizontalAlign="Center" ShowHeader="true"/>

            <asp:TemplateField HeaderText="기타" ItemStyle-HorizontalAlign="Center" 
                ShowHeader="true" ItemStyle-Width="16%">
                <ItemTemplate>
                    <asp:Button ID="deleteBtn" runat="server" Text="삭제"  
                        Height="27px"
                        CommandName="DeleteItem"
                        CommandArgument='<% # Eval("user_id") %>' 
                        OnClick="deleteBtn_Click"/>
                    
                    <asp:Button ID="updateBtn" runat="server" Text="수정" 
                        Height="27px"
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
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    </div>

    <!--GirdView에 적용될 CSS-->
    <style type="text/css">
        .GridViewClass{
            text-align: center;
            
        }
    </style>

    <!--메인 게시판에 게시물의 목록을 가져오는 JQuary-->
    <!--게시판 메인 화면 구성(mssql에서 게시판의 내용을 가져와 gridview로 보여줌)-->
    <asp:SqlDataSource ID="SqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
        SelectCommand="SELECT number, user_id, header, input_date FROM dbo.Board ORDER BY number DESC">
    </asp:SqlDataSource> 
    
    <hr />
    <asp:Panel ID="Panel1" runat="server" Width="100%" Height="50px" HorizontalAlign="Right">
        <asp:Button ID="NewNotice" runat="server" Height="30px" Text="게시물 작성" OnClick="NewNotice_Click" />
    </asp:Panel>

    


    <div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
    </div>

    </article>


</asp:Content>

