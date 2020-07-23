<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="NoticeProject.Contact" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<!--마스터 폼에서는 type="text/javascript"로 JS 작성 가능-->
<script type="text/javascript">
    
</script>
    
<center>
    <asp:Panel ID="HeaderPanel" runat="server" Height="100px" Width="600px">
        <asp:Label ID="BoardIndexText" runat="server" Text="게시물 번호 : " Font-Size="Smaller"/>
        <asp:Label ID="BoardIndex" runat="server" Text="" Font-Size="Smaller" /><br />
        <asp:Label ID="headerlbl" runat="server" Text="" Font-Size="Larger" />
    </asp:Panel>

    <asp:Panel ID="ButtonPanel" runat="server" Width="60%" HorizontalAlign="Right">
        <table ID="table1" style="width:100%">
            <tr>
                <td align="left">
                    작성자 : <asp:Label ID="Written" runat="server" ForeColor="Blue" Text="" />
                </td>
                <td align="right">
                    <input type="submit" name="Previous_Btn" runat="server" 
                        value="< 이전글" OnServerClick="Previous_Btn_Click" />
                    <input type="submit" name="Next_Btn" runat="server" 
                        value="다음글 >" OnServerClick="Next_Btn_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>

    <hr style="width:60%;" />
    <asp:Panel ID="updatePanel" runat="server" Width="60%" HorizontalAlign="Right">
        <asp:Button ID="UpdateBtn" runat="server" Text="수정" OnClick="UpdateBtn_Click"/>
    </asp:Panel>

    <!--게시물의 내용이 표시되는 부분-->
    <asp:Panel ID="ContantsPanel" runat="server" Width="60%" Height="70%" HorizontalAlign="Left">
        <asp:Label ID="Literal" runat="server" Text=""></asp:Label>
    </asp:Panel>

    <hr style="width:60%; height:2px;" />

    <asp:Panel ID="Panel4" runat="server" Width="60%" Height="10%" HorizontalAlign="Right">
        <table id="table2" style="width:100%">
            <tr>
                <td align="left">
                    <asp:Button ID="BackButton" runat="server" Text="뒤로 가기" OnClick="BackButton_Click" />
                </td>
                <td align="right">
                    <asp:Button ID="CommentBtn" runat="server" Text="댓글 작성" OnClick="CommentHidden_Click"/><br />
                </td>
            </tr>
        </table>
    </asp:Panel><br />


    <!--댓글 작성 및 해당 게시물의 댓글이 보여지는 부분-->
    <asp:Panel ID="Comment_Panel" runat="server" Width="60%" HorizontalAlign="Center">
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

    <asp:Panel ID="CommentCount_Panel" runat="server" Width="60%" HorizontalAlign="Left">
        전체 댓글 수 : <asp:Label ID="CommentCount_lbl" runat="server" Text=""/>
    </asp:Panel><br />

    <!--댓글이 보일 GridView와 댓글 수정/삭제 버튼-->
    <asp:Panel ID="CommentViewPanel" runat="server" Width="60%" HorizontalAlign="Center">
        
        <asp:gridview id="CommentGridView" runat="server" style="width:100%"
            DataSourceID="SqlDataSource" 
            AutoGenerateColumns="False"
            HeaderStyle-BorderStyle="None"
            emptydatatext="<br />댓글이 없습니다."
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
                        <asp:Button ID="CancelUpdate" runat="server" Text="취소" width="80px" Visible="false" OnClick="CancelUpdate_Click"/>
                        <asp:Button ID="UpdateCommentBtn" runat="server" Text="수정완료" width="80px" Visible="false" 
                            ValidationGroup="NewValue" OnClick="UpdateCommentBtn_Click"/><br />
                        <hr />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Center" 
                    ShowHeader="false" ItemStyle-Width="15%">
                    <ItemTemplate>
                        <asp:Button ID="DeleteComment" runat="server" Text="삭제" Font-Size="X-Small" 
                            OnClick="DeleteComment_Click"
                            OnClientClick="return confirm('정말 삭제하시겠습니까?')"/>
                        <asp:Button ID="ReplaceComment" runat="server" Text="수정" Font-Size="X-Small" 
                            OnClick="ReplaceComment_Click"/>

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

    </asp:Panel>
    
    <hr style="width:63%;" />

</center>

</asp:Content>
