<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="NoticePage.aspx.cs" Inherits="NoticeProject.LoginPage" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >

    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.0/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
    <script src="http://code.jquery.com/ui/1.10.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <script>
        $(function () {
            // datepicker에는 아래와 같이 기본적으로 설정할 수 있는 옵션들이 있다.
            $("#datepicker").datepicker({
                dateFormat: 'yymmdd',
                monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                changeMonth: true, //월변경가능
                changeYear: true, //년변경가능
                showMonthAfterYear: true, //년 뒤에 월 표시
            });
        });
    </script>
    
    <script type="text/javascript">
        function NoticeList() {
            
            $("#NoticeGridTable").jqGrid({
                colModel: [
                    { name: "number", label: "번호" },
                    { name: "header", label: "제목" },
                    { name: "user_id", label: "작성자" },
                    { name: "input_date", label: "작성 날짜" },
                    { label: "기타" }
                ],
                height: 'auto',
                guiStyle: "bootstrap",
                iconSet: "fontAwesome",
                sortname: "invdate",
                sortorder: "desc",
                threeStateSort: true,
                headertitles: true,
                rownumbers: true,
                toppager: true,
                pager: true,
                loadtext: "Data Loading...",
                rowNum: 20,
                inlineEditing: {keys: true, defaultFocusField: "number", focusField: "number"},

                onSelectRow: function (rowid, status, e){
                    $("#NoticeGridTable").jqGrid('getRowData', rodiw);
                    var sItemID = $("#NoticeGridTable").getRowData(rowid).ID;
                    LoadList(sItemID);
                }
            })
        }

        function LoadList(sItemID) {
            var param = "{ number:'" + sItemID + "'}";
            $("#NoticeGridTable").jqGrid('clearGridData');
            var gridArrayData = [];
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "applicatoin/json; charset=utf-8",
                url: "NoticePage.aspx/LoadList",
                data: param,
                success: function (data) {
                    var result = jQuery.parseJSON(data.d).Rows;

                    for (var i = 0; i < result.length; i++) {
                        var item = result[i];
                        gridArrayData.push({
                            number: item.number,
                            header: item.header,
                            user_id: item.user_id,
                            input_date: item.input_date
                        });
                    }

                    $("#NoticeGridTable").jqGrid('setGridParam', { data: gridArrayData });
                    $("#NoticeGridTable").trigger('reloadGrid');
                }
            })
        }
    </script>
    

    <aside id="sidebar">
        <div id="profile">
            어서오세요! <br /><asp:Label ID="Login_UserID_lbl" runat="server" BorderColor="Blue" Text="" />님, 환영합니다.<br />
            <input type="button" name="privateInfoBtn" id="privateInfoBtn" value="개인설정" 
                OnClick="location.href='PrivateSet.aspx'" />
            <asp:Button ID="Logout" runat="server" Text="로그아웃" OnClick="Logout_Click" />
        </div>
        <br />
        <div style="padding-left:5px; height:initial;" >
            <asp:TreeView ID="SiteMenu" runat="server" DataSourceID="SiteMapDataSource1"
                    ShowLines="True" Width="195px"></asp:TreeView>
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
        </div>
        <br /><hr style="width:96%;"/>
    </aside>
    

    <section id="board">

        <article>
            <hr />
                <h2>게시판 목록</h2>
            <hr />
        </article>

        <!--해당 GridView는 메인 화면에 표시될 게시판에 대한 설정이다.-->
        <!--DataNavigateUrlFields는 gridview 내에 있는 DataField의 값을 가져오고 -->
        <!--HyperLink에 DataNavigateUrlFormatString을 통해 해당 값을 넣어준다.-->
        <article>
            <table id="NoticeGridTable"></table>
        </article>


        <article>
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
        </article>
        <!------------------------------------------------------------------------------>


        <!--메인 게시판에 게시물의 목록을 가져오는 JQuary-->
        <!--게시판 메인 화면 구성(mssql에서 게시판의 내용을 가져와 gridview로 보여줌)-->
        <asp:SqlDataSource ID="SqlDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
            SelectCommand="SELECT number, user_id, header, input_date FROM dbo.Board ORDER BY number DESC">
        </asp:SqlDataSource> 
    
    
        <article style="text-align:right; margin: 5px 10px;">
            <input ID="NewNotice" type="button" value="게시물 작성" OnClick="location.href='WritePost.aspx?board_id=&previousPage=main'" />
            <hr />
        </article>

        <article style="display:flex; margin-top:50px">
            <article style="width:50%;">
                <div id="datepicker"></div>
            </article>

            <article style="text-align:left; margin-top:5px; margin-left:15px;">
                <p style="font: 23px; font-weight: bold">ASP.NET</p>
                <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
                <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>
            </article>
        </article>
        <br /><hr />

    </section>
    
</asp:Content>

