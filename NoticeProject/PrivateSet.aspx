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

            if (pwd1 != '' && pwd2 == '') {
                null;
            } else if (pwd1 != "" || pwd2 != "") {
                if (pwd1 == pwd2) {
                    $("#alert-success").css('display', 'inline-block');
                    $("#alert-danger").css('display', 'none');
                } else {
                    alert("비밀번호가 일치하지 않습니다. 비밀번호를 재확인해주세요.");
                    $("#alert-success").css('display', 'none');
                    $("#alert-danger").css('display', 'inline-block');
                }
            }
        });


        function TableView()


    </script>


    <!--사용자의 개인정보 출력 뒤, 수정된 값이 있다면 업데이트 수행-->
    <table id="UserInfoTable" visible="true">
        <tr>
            <td> 이름 : </td>
            <td> <input id="UserName" type="text" readonly/> </td>
        </tr>
        <tr>
            <td> 생년월일 : </td>
            <td> <input id="Birthday" type="datetime" /> </td>
        </tr>
        <tr>
            <td> 아이디 : </td>
            <td> <input id="UserID" type="text" style="border:0;" readonly/></td>
        </tr>
        <tr>
            <td> 비밀번호 : </td>
            <td> 
                <input id="Password" type="button" 
                    value="비밀번호 변경" runat="server"
                    onclick="Password_ServerClick"/>
            </td>
        </tr>
        <tr>
            <td> E-Mail : </td>
            <td> <input id="Email" type="email" /> </td>
        </tr>
        <tr>
            <td> 전화번호 : </td>
            <td> <input id="Phone" type="tel"/> </td>
        </tr>
        <tr>
            <td> 가입일 : </td>
            <td> <input id="JoinDate" type="text" style="border:0;" readonly /> </td>
        </tr>
        <tr>
            <td colspan="2"> 
                <input id="UpdateInfo" type="button"
                    value="정보수정" runat="server" 
                    onserverclick="UpdateInfo_ServerClick"/> 
            </td>
        </tr>
    </table>


    <!--이전 비밀번호 확인 후, 비밀번호 유효성 검사 수행(이후 변경)-->
    <table id="PassWordTable" visible="false">
        <tr>
            <td> 현재 비밀번호 입력 : </td>
            <td> <input ID="NowPassWord" type="text" disabled/> </td>
        </tr>
        <tr>
            <td> 새 비밀번호 입력 : </td>
            <td> <input id="NewPassword" type="password" 
                maxlength="30" 
                placeholder="비밀번호"
                onblur="validate(this, 8, 32);"/> 
            </td>
        </tr>
        <tr>
            <td> 새 비밀번호 확인 : </td>
            <td> <input id="NewPasswordCheck" type="password" 
                maxlength="30"
                placeholder="비밀번호 확인"
                onblur="validate(this, 8, 32);"/> 
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input id="PrintMsg" type="text" 
                    style="border:0;"
                    value=""/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input id="NewPassInput" type="button" value="비밀번호 변경" />
            </td>
        </tr>
    </table>


</asp:Content>

