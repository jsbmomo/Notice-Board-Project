<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="WritePost.aspx.cs" Inherits="NoticeProject.WritePost" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    

    <script type="text/javascript">

        var text = $('#toptitle').text();
        if (text == '프로필') {
            $('#toptitle').text('테스트');
        }


        $(document).on("click", "#Password", function () {
            TableViewChs("ViewPass");
        });

        function TableViewChs(isResult) {

            if (isResult == "ViewPass") {
                $("#UserInfoTable").css("display", "none");
                $("#PassWordTable").css("display", "");

            } else {
                $("#UserInfoTable").css("display", "");
                $("#PassWordTable").css("display", "none");

            }
        }
    </script>


    <link rel="stylesheet" href="PageSheet.css" />


    <aside id="sidebar">
        <div id="profile">
            어서오세요! <br /><asp:Label ID="Login_UserID_lbl" runat="server" BorderColor="Blue" Text="" />님, 환영합니다.<br />
            <input type="button" name="privateInfoBtn" id="privateInfoBtn" value="개인설정" 
                OnClick="location.href='PrivateSet.aspx'" />
            <asp:Button ID="Logout" runat="server" Text="로그아웃" OnClick="Logout_Click" />
        </div>
        <br />
        <div style="padding-left:5px;" >
            <asp:TreeView ID="SiteMenu" runat="server" DataSourceID="SiteMapDataSource1"
                 ShowLines="True" Width="195px"></asp:TreeView>
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
        </div>
    </aside>


    <section id="board">

        <article style="text-align:center;">
            <hr />
            <h2> 게시물 내용 작성 </h2>
            <hr />
        </article>
    
        <section style="text-align:left; width:100%; margin-top:50px; background-color: aqua;">
        <div>
            <div>
                <br /><label>작성자</label>
                <input id="Written" runat="server" type="text" style="border:0; background:none;" readonly/>
            </div>
        </div>

        <div>
            <div>
                <br /><label for="WriteHead"> 게시물 제목 </label><br />
                <input id="WriteHead" runat="server" type="text" style="width: 500px;"/>
            </div>
        </div>

        <div>
            <div>
                <br /><label> 게시물 내용 </label><br />
                <asp:TextBox ID="WriteContent" runat="server" Width="500"
                        TextMode="MultiLine" Rows="20" Wrap="true"/>
            </div>
        </div>

        <div>
            <div>
                <br /><label> 이미지 첨부 </label><br />
                <asp:FileUpload ID="FileUpLoader" runat="server" Width="500" />
            </div>
        </div>

        <label for="Errorlbl"></label>

        <hr />


        <section style="text-align:center;">
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
        </section>

        </section>
    </section>
    
</asp:Content>
