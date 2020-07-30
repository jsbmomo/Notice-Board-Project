<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PrivateSet.aspx.cs" Inherits="NoticeProject.PrivateSet" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <!--JS로 유효성 검사-->
    <script type="text/javascript">
        /*function validate(element, min, max) {
            var len = element.value.length;

            if ((len < min) || (len > max)) {
                element.style.borderColor = "#FF0000";
                element.focus();
            }
            else {
                element.style.borderColor = "#ffffff";
            }
        } */

        $('.PrintMsg').focusout(function () {
            var pwd1 = $("#NewPassword").val();
            var pwd2 = $("#NewPasswordCheck").val();
            alert(a);

            if (pwd1 != '' && pwd2 == '') {
                alert(b);
                null;
            } else if (pwd1 != "" || pwd2 != "") {
                if (pwd1 == pwd2) {
                    alert(c);
                    $("#alert-success").css('display', 'inline-block');
                    $("#alert-danger").css('display', 'none');
                } else {
                    alert("비밀번호가 일치하지 않습니다. 비밀번호를 재확인해주세요.");
                    $("#alert-success").css('display', 'none');
                    $("#alert-danger").css('display', 'inline-block');
                }
            }
        });
        

        $(document).on("click", "#Password", function () {
            TableViewChs("ViewPass");
        });

        function TableViewChs(isResult) {
            
            if (isResult == "ViewPass") {
                $("#UserInfoTable").css("display", "none");
                $("#PassWordTable").css("display", "");
                //document.getElementById("UserInfoTable").style.display = 'none';
                //document.getElementById("PassWordTable").style.display = 'block';
            } else {
                $("#UserInfoTable").css("display", "");
                $("#PassWordTable").css("display", "none");
                //document.getElementById("UserInfoTable").style.display = 'block';
                //document.getElementById("PassWordTable").style.display = 'none';
            }
        }

    </script>


    <aside id="sidebar">
        <div id="profile">
            어서오세요! <br /><asp:Label ID="Label1" runat="server" BorderColor="Blue" Text="" />님, 환영합니다.<br />
            <asp:Button ID="Button1" runat="server" Text="로그아웃" OnClick="Logout_Click" />
        </div>
        <div style="padding-left:5px;" >
            <asp:TreeView ID="SiteMenu" runat="server" DataSourceID="SiteMapDataSource1"
                    ShowLines="true" Width="195px"></asp:TreeView>
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
        </div>
    </aside>

    <!--사용자의 개인정보 출력 뒤, 수정된 값이 있다면 업데이트 수행-->
    <section id="board">
    <section id="boardMainContents" style="margin-top:200px; text-align:center;">
        <table id="UserInfoTable">
            <tr>
                <td colspan="2" style="text-align:center;"> 
                    현재 회원님은<br />
                    <input id="Grade" type="text" runat="server"
                        style="font-size:18px; font-style:initial; 
                        color:darkgray; text-align:center; 
                        border:none; background:none; margin:3px;"/>
                    <br />입니다.<br />
                </td>
            </tr>
            <tr>
                <td> 이름 : </td>
                <td> <input id="UserName" type="text" runat="server"/> </td>
            </tr>
            <tr>
                <td> 생년월일 : </td>
                <td> <input id="Birthday" type="datetime" runat="server" value=""/> </td>
            </tr>
            <tr>
                <td> 아이디 : </td>
                <td> <input id="UserID" type="text" style="border:none; background:none;" runat="server" readonly/></td>
            </tr>
            <tr>
                <td> 비밀번호 : </td>
                <td> 
                    <input id="Password" type="button"
                        value="비밀번호 변경" />
                </td>
            </tr>
            <tr>
                <td> E-Mail : </td>
                <td> <input id="Email" type="email" runat="server"/> </td>
            </tr>
            <tr>
                <td> 전화번호 : </td>
                <td> <input id="Phone" type="tel" runat="server"/> </td>
            </tr>
            <tr>
                <td> 가입일 : </td>
                <td> <input id="JoinDate" type="text" style="border:none; background:none" runat="server" readonly /> </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;"><br />
                    <input id="UpdateInfo" type="button"
                        value="정보수정" runat="server" 
                        onserverclick="UpdateInfo_ServerClick"/>  
                </td>
            </tr>
        </table>


        <!--이전 비밀번호 확인 후, 비밀번호 유효성 검사 수행(이후 변경)-->
        <table id="PassWordTable" style="display:none;">
            <tr>
                <td> 현재 비밀번호 입력 : </td>
                <td> <input ID="NowPassWord" type="password" runat="server"/> </td>
            </tr>
            <tr>
                <td> 새 비밀번호 입력 : </td>
                <td> 
                    <input id="NewPassword" type="password" runat="server"
                        maxlength="30" 
                        placeholder="비밀번호"
                        onblur="validate(this, 8, 32);"/> 
                </td>
            </tr>
            <tr>
                <td> 새 비밀번호 확인 : </td>
                <td>
                    <input id="NewPasswordCheck" type="password" 
                        onblur="validate(this, 8, 32);"
                        maxlength="30"
                        placeholder="비밀번호 확인"/> 
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input id="PrintMsg" type="text" 
                        style="border:none; background:none;"
                        value=""/>
                </td>
            </tr>
            <tr>
                <td style="text-align:right"> <input id="BackBtn" type="button" value="뒤로 가기" onclick="javascript:TableViewChs('ViewMain');" /> </td>
                <td style="text-align:left"> <input id="NewPassInput" runat="server" type="button" value="비밀번호 변경" onserverclick="Password_ServerClick" /> </td>
            </tr>
        </table>
    </section>
    </section>

</asp:Content>

