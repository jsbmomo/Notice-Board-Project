<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contents.aspx.cs" Inherits="NoticeProject.Contact" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!--마스터 폼에서는 type="text/javascript"로 JS 작성 가능-->
    <script type="text/javascript">


    </script>
    
    <link rel="stylesheet" href="PageSheet.css" />


    <aside id="sidebar">
        <div id="profile">
            어서오세요! <br /><asp:Label ID="Login_UserID_lbl" runat="server" BorderColor="Blue" Text="" />님, 환영합니다.<br />
            <input type="submit" name="privateInfoBtn" id="privateInfoBtn" value="개인설정"
                Onclick="location.href='PrivateSet.aspx'" />
            <asp:Button ID="Logout" runat="server" Text="로그아웃" OnClick="Logout_Click" />
        </div>
        <br />
        <div style="padding-left:5px;" >
            <asp:TreeView ID="SiteMenu" runat="server" DataSourceID="SiteMapDataSource1"
                    ShowLines="True" Height="250px" Width="195px"></asp:TreeView>
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
        </div>
    </aside>

    
    <section id="board">
        <hr />
        <article>
            <asp:Label ID="BoardIndexText" runat="server" Text="게시물 번호 : " Font-Size="Smaller"/>
            <asp:Label ID="BoardIndex" runat="server" Text="" Font-Size="Smaller" /><br />
            <asp:Label ID="headerlbl" runat="server" Text="" Font-Size="XX-Large" CssClass="chsFont" />
        </article><br />
    
        <article>
            <table ID="table1" style="width:100%">
                <tr>
                    <td align="left">
                        작성자 : <asp:Label ID="Written" runat="server" ForeColor="Blue" Text=""
                                  CssClass="chsFont"/>
                    </td>
                    <td align="right">
                        <input type="submit" name="Previous_Btn" runat="server" 
                            value="< 이전글" OnServerClick="Previous_Btn_Click" />
                        <input type="submit" name="Next_Btn" runat="server" 
                            value="다음글 >" OnServerClick="Next_Btn_Click" />
                    </td>
                </tr>
            </table>
        </article>

        <hr style="width:100%;" />
        <article style="text-align:right;">
            <asp:Button ID="UpdateBtn" runat="server" Text="수정" OnClick="UpdateBtn_Click"/>
        </article>

        <!--게시물의 내용이 표시되는 부분-->
        <section id="boardMainContents">
            <asp:Label ID="Literal" runat="server" Text=""></asp:Label><br />
        </section>

    
        <style type="text/css">
            .chsFont{
                font-weight: bold;
            }
        </style>


        <hr style="width:100%; height:2px;" />

        <article>
            <table id="table2" style="width:100%">
                <tr>
                    <td align="left">
                        <input id="BackButton" type="button" value="뒤로 가기" onclick="location.href='NoticePage.aspx'" />
                    </td>
                    <td align="right">
                        <asp:Button ID="CommentBtn" runat="server" Text="댓글 작성" OnClick="CommentHidden_Click"/><br />
                    </td>
                </tr>
            </table>
        </article><br />


        <!--댓글 작성 및 해당 게시물의 댓글이 보여지는 부분-->
        <asp:Panel ID="Comment_Panel" runat="server" Width="100%" HorizontalAlign="Center">
            <asp:Label ID="CommentID" runat="server" Text="댓글 작성" />
            <asp:TextBox ID="Comment" runat="server" TextMode="MultiLine" Width="100%" Rows="7" Wrap="true"/><br />
            <asp:RequiredFieldValidator ID="RequiredField" runat="server"
                ControlToValidate="Comment"
                ForeColor="Red" Font-Size="Small"
                ValidationGroup="vali"
                ErrorMessage="글을 작성해주세요." 
                Display="Dynamic"/><br />
            <asp:Button ID="CommentStore" runat="server" Text="댓글 등록" OnClick="CommentInput_Click" ValidationGroup="vali"/><br />
        </asp:Panel><br /><br />

        <section style="text-align:left;">
            전체 댓글 수 : <asp:Label ID="CommentCount_lbl" runat="server" Text=""/>
        </section><br />

        <!--댓글이 보일 GridView와 댓글 수정/삭제 버튼-->
        <!--추가로 댓글의 주소를 별도로 보관하기 위해 TextBox에 Index를 저장하고 TextBox를 보이지 않게함-->
        <article>
        
            <asp:gridview id="CommentGridView" runat="server" style="width:100%"
                DataSourceID="SqlDataSource" 
                AutoGenerateColumns="False"
                HeaderStyle-BorderStyle="None"
                emptydatatext="<br />댓글이 없습니다.<br /><br />"
                ShowHeader="false"
                GridLines="None">

                <Columns>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Left" >
                        <ItemTemplate>
                            <asp:Label ID="Written" runat="server" 
                                Text='<% # Eval("user_id") %>' />
                            <asp:TextBox ID="HiddenIndex" runat="server"
                                Text='<% # Eval("num") %>' Visible="false"/>
                            <asp:Label ID="WritteDate" runat="server" Font-Size="X-Small"
                                Text='<% # Eval("comment_date") %>' /><br />
                            <asp:Label ID="WrittenComment" runat="server"  Font-Size="Small"
                                Text='<% # Eval("comment") %>' /><br />
                            <asp:TextBox ID="UpdateComment" runat="server" Text='<% # Eval("comment") %>' Width="100%"
                                Visible="false" TextMode="MultiLine" Rows="5" Wrap="true"/><br />

                            <asp:RequiredFieldValidator ID="ReauiredField" runat="server" 
                                Font-Size="Small" ForeColor="Red"
                                ControlToValidate="UpdateComment"
                                ErrorMessage="공백을 저장할 수 없습니다."
                                ValidationGroup="NewValue"
                                Display="Dynamic" />
                            <br />
                            <hr />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" 
                        ShowHeader="false" ItemStyle-Width="15%">
                        <ItemTemplate>
                            <asp:Button ID="DeleteCommentBtn" runat="server" Text="삭제" Font-Size="X-Small"  Width="60px"
                                OnClick="DeleteComment_Click"
                                OnClientClick="return confirm('정말 삭제하시겠습니까?')"/><br />
                            <asp:Button ID="ReplaceCommentBtn" runat="server" Text="수정" Font-Size="X-Small" Width="60px"
                                OnClick="ReplaceComment_Click"/>

                            <asp:Button ID="CancelUpdateBtn" runat="server" Text="취소" width="60px" Visible="false" Font-Size="X-Small"
                                OnClick="CancelUpdate_Click"/><br />
                            <asp:Button ID="UpdateCommentBtn" runat="server" Text="수정완료" width="60px" Visible="false" Font-Size="X-Small"
                                ValidationGroup="NewValue" OnClick="UpdateCommentBtn_Click"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:gridview>


            <!--GridView에 표시된 Comment DB의 내용(SelectParameters내의 
                ControlParameter의 Name를 통해 게시물의 주소가 저장된 BoardIndex 라벨의 Text를 가져옴)-->
            <asp:SqlDataSource ID="SqlDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
                SelectCommand="SELECT user_id, comment, comment_date, num FROM dbo.Comment WHERE board_number=@BoardNum">
        
                <SelectParameters>
                    <asp:ControlParameter Name="BoardNum" ControlId="BoardIndex" PropertyName="Text"/>
                </SelectParameters>
            </asp:SqlDataSource> 

        </article>
    
        <hr style="width:100%;" /><br /><br />

    </section>

</asp:Content>
