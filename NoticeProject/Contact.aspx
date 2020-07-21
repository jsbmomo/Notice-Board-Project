<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="NoticeProject.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
<center>
    <asp:Panel ID="Panel1" runat="server" Height="100px" Width="600px" HorizontalAlign="Center">
        <asp:Label ID="headerlbl" runat="server" Text="" Font-Size="Larger" />
    </asp:Panel>

    <asp:Panel ID="Panel2" runat="server" Width="60%" Height="50px" HorizontalAlign="Right">
        <input type="submit" name="Previous_Btn" runat="server" 
            value="< 이전글" OnServerClick="Previous_Btn_Click" />
        <input type="submit" name="Next_Btn" runat="server" 
            value="다음글 >" OnServerClick="Next_Btn_Click" />
    </asp:Panel>

    <hr style="width:60%;" />
    <asp:Panel ID="updatePanel" runat="server" Width="60%" HorizontalAlign="Right">
        <asp:Button ID="UpdateBtn" runat="server" Text="수정" OnClick="UpdateBtn_Click"/>
    </asp:Panel>
    <asp:Panel ID="Panel3" runat="server" Width="60%" Height="70%" HorizontalAlign="Left">
        <asp:Literal ID="Literal" runat="server" Text=""></asp:Literal>
    </asp:Panel>

    <hr style="width:60%;" />

    <asp:Panel ID="Panel4" runat="server" Width="60%" Height="10%" HorizontalAlign="Right">
        <asp:Button ID="BackButton" runat="server" Text="뒤로 가기" OnClick="BackButton_Click" />
    </asp:Panel>
</center>

</asp:Content>
