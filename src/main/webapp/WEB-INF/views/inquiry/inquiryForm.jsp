<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의하기</title>

<script>
function send(f) {
    const type = f.type.value.trim();
    const title = f.title.value.trim();
    const content = f.content.value.trim();

    if (type === "") {
        alert("문의 유형을 선택하세요.");
        f.type.focus();
        return;
    }

    if (title === "") {
        alert("제목을 입력하세요.");
        f.title.focus();
        return;
    }

    if (title.length > 100) {
        alert("제목은 100자 이하로 입력하세요.");
        f.title.focus();
        return;
    }

    if (content === "") {
        alert("내용을 입력하세요.");
        f.content.focus();
        return;
    }

    // 비회원일 때만 검사
    if (f.guest_name) {
        const guestName = f.guest_name.value.trim();
        const guestEmail = f.guest_email.value.trim();
        const guestPassword = f.guest_password.value.trim();

        const nameRegex = /^[가-힣a-zA-Z]{2,20}$/;
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{8,20}$/;

        if (guestName === "") {
            alert("이름을 입력하세요.");
            f.guest_name.focus();
            return;
        }

        if (!nameRegex.test(guestName)) {
            alert("이름은 한글 또는 영문 2~20자로 입력하세요.");
            f.guest_name.focus();
            return;
        }

        if (guestEmail === "") {
            alert("이메일을 입력하세요.");
            f.guest_email.focus();
            return;
        }

        if (!emailRegex.test(guestEmail)) {
            alert("이메일 형식이 올바르지 않습니다.");
            f.guest_email.focus();
            return;
        }

        if (guestPassword === "") {
            alert("비밀번호를 입력하세요.");
            f.guest_password.focus();
            return;
        }

        if (!passwordRegex.test(guestPassword)) {
            alert("비밀번호는 영문과 숫자를 포함해 8~20자로 입력하세요.");
            f.guest_password.focus();
            return;
        }
    }

    f.submit();
}
</script>
</head>

<body>

<h2>문의하기</h2>

<form action="/inquiry" method="post">
    <table>
        <tr>
            <th>유형</th>
            <td>
                <select name="type">
                    <option value="">선택</option>
                    <option value="계정">계정</option>
                    <option value="레시피 문의">레시피 문의</option>
                    <option value="서비스 이용 문의">서비스 이용 문의</option>
                    <option value="기타">기타</option>
                </select>
            </td>
        </tr>
        <!-- 회원일때 -->
        <c:if test="${not empty sessionScope.user}">
            <tr>
                <th>이름</th>
                <td>
                    <input type="text"
                           value="${sessionScope.user.nickname}"
                           readonly>

                    <input type="hidden"
                           name="member_id"
                           value="${sessionScope.user.member_id}">
                </td>
            </tr>
        </c:if>
        <!-- 비회원일때 -->
        <c:if test="${empty sessionScope.user}">
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" name="guest_name">
                </td>
            </tr>

            <tr>
                <th>이메일</th>
                <td>
                    <input type="email" name="guest_email">
                </td>
            </tr>

            <tr>
                <th>비밀번호</th>
                <td>
                    <input type="password" name="guest_password">
                </td>
            </tr>
        </c:if>

        <tr>
            <th>제목</th>
            <td>
                <input type="text" name="title" maxlength="200">
            </td>
        </tr>

        <tr>
            <th>내용</th>
            <td>
                <textarea name="content" rows="8"></textarea>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <input type="button" value="문의하기" onclick="send(this.form)">
            </td>
        </tr>
    </table>
</form>

</body>
</html>