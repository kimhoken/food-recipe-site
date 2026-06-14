<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>

        <script>
            function checkPassword(f) {
                const password = f.guest_password.value.trim();

                if (password === "") {
                    alert("비밀번호를 입력하세요.");
                    f.guest_password.focus();
                    return;
                }

                f.submit();
            }
        </script>
    </head>

    <body>

    <h2>비회원 문의 답변 확인</h2>

    <c:if test="${not empty msg}">
        <p style="color:red; text-align:center;">${msg}</p>
    </c:if>

    <form action="/guest/inquiry/check" method="post">

        <input type="hidden" name="inquiry_code" value="${inquiry_code}">

        <table>
            <tr>
                <th>비밀번호</th>
                <td>
                    <input type="password" name="guest_password" placeholder="문의 작성 시 입력한 비밀번호">
                </td>
            </tr>

            <tr>
                <td colspan="2" align="center">
                    <input type="button" value="답변 확인" onclick="checkPassword(this.form)">
                    <input type="button" value="메인으로" onclick="location.href='/main_list.do'">
                </td>
            </tr>
        </table>

    </form>

    </body>
</html>