<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="NoticeProject.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
<center>
    <asp:Panel ID="Panel1" runat="server" Height="100px" Width="600px">
        <asp:Label ID="BoardIndex" runat="server" Text="" Font-Size="Small" /><br />
        <asp:Label ID="headerlbl" runat="server" Text="" Font-Size="Larger" />
    </asp:Panel>

    <asp:Panel ID="Panel2" runat="server" Width="60%" HorizontalAlign="Right">
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
    <asp:Panel ID="Panel3" runat="server" Width="60%" Height="70%" HorizontalAlign="Left">
        <asp:Label ID="Literal" runat="server" Text=""></asp:Label>
    </asp:Panel>

    <hr style="width:60%; height:2px; border:0;" />

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
    </asp:Panel><br />


    <asp:Panel ID="Panel6" runat="server" Width="60%" HorizontalAlign="Center">
        전체 댓글 수 : <asp:Label ID="CommentCount" runat="server" Text=""/>
        
        <asp:gridview id="CommentList" runat="server" style="width:100%"
            DataSourceID="SqlDataSource" 
            AutoGenerateColumns="False"
            HeaderStyle-BorderStyle="None"
            emptydatatext="댓글이 없습니다."
            ShowHeader="false"
            GridLines="None">
            <Columns>
                <asp:TemplateField ItemStyle-HorizontalAlign="Left" >
                    <ItemTemplate>
                        <asp:Label ID="Written" runat="server" 
                            Text='<% # Eval("user_id") %>' />
                        <asp:Label ID="WriteDate" runat="server" Font-Size="X-Small"
                            Text='<% # Eval("comment_date") %>' /><br />
                        <asp:Label ID="WrittenComment" runat="server"  Font-Size="Small"
                            Text='<% # Eval("comment") %>' /><br />
                        <hr />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Center" 
                    ShowHeader="false" ItemStyle-Width="15%">
                    <ItemTemplate>
                        <asp:Button ID="DeleteComment" runat="server" Text="삭제" Font-Size="X-Small" />
                        <asp:Button ID="ReplaceComment" runat="server" Text="수정" Font-Size="X-Small" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:gridview>

        <asp:SqlDataSource ID="SqlDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DBConnectionString %>"
            SelectCommand="SELECT user_id, comment, comment_date FROM dbo.Comment WHERE board_number=@BoardNum"
            
            >
        
            <SelectParameters>
                <asp:ControlParameter Name="BoardNum" ControlId="BoardIndex" PropertyName="Text"/>
            </SelectParameters>
        </asp:SqlDataSource> 

    </asp:Panel>

    <hr style="width:63%; border:2px;" />

</center>

</asp:Content>
