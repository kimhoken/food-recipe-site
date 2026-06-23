<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>

</head>

<body>

    <h2>신고하기</h2>

    <form action="/report/insert.do" method="post">

        <p>
        신고 대상 유형
            <select name="target_type">
                <option value="">선택하세요</option>
                <option value="게시판 댓글">게시판</option>
                <option value="게시판">게시판 댓글</option>
                <option value="레시피">레시피</option>
                <option value="레시피 후기">레시피 후기</option>
            </select>
        </p>

        <p>
            신고 사유
            <select name="report_type">
                <option value="">선택하세요</option>
                <option value="욕설/비방">욕설/비방</option>
                <option value="광고/도배">광고/도배</option>
                <option value="음란물">음란물</option>
                <option value="허위정보">허위정보</option>
                <option value="기타">기타</option>
            </select>
        </p>

        <p>
            신고 상세 내용
            <textarea name="report_reason" rows="8" cols="50"
                      placeholder="신고 사유를 입력하세요"></textarea>
        </p>

        <input type="submit" value="신고하기">
        <input type="button" value="취소" onclick="history.back()">

    </form>

</body>
</html>