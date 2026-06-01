<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <script>
                let
                //아이디 찾기 함수
                function findid(f) {
                    name = f.name.value;
                    email = f.email.value;

                    fetch("/mail_check.do", {
                        method: 'post',
                        headers: { 'Content-Type': "application/x-www-form-urlencoded" },
                        body: 'email=' + encodeURI(email)
                    })
                        .then(res => res.json())
                        .then(data => {
                            alert("인증번호가 발송되었습니다.");
                            email_authnumer = data.authNumber;
                        })

                }

                // 아이디, 이메일 유효성 검사
                function check(val) {
                    let email = document.getElementById("email");

                    let email_msg = document.getElementById("email_msg");

                    if (email == "") {
                        email_msg.innerHTML = "이메일 입력하세요";
                    }

                }
            </script>
        </head>

        <body>
            <div>
                <button onclick="change('id')">아이디</button>
                <button onclick="change('pwd')">비밀번호</button>
                <c:if test="${select eq 'id'}">
                    <form>
                        <table>
                            <caption>아이디 찾기</caption>

                            <tr>
                                <th>이메일</th>
                                <td>
                                    <input name="email" id="email" oninput="check()">
                                    <input type="button" value="인증번호 전송" />
                                    <div id="email_msg"></div>

                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="center">
                                    <button type="button" onclick="findid(this.form)">아이디 찾기</button>
                                </td>
                            </tr>
                        </table>
                    </form>

                </c:if>

                <c:if test="${select eq 'pwd'}">
                    비밀번호 찾기 페이지
                </c:if>

            </div>
        </body>

        </html>