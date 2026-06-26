<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    
    <c:if test="${empty param.board_id and empty param.comment_id and empty param.recipe_id and empty param.review_id}">
        <script>
            alert("신고 대상이 없습니다.");
            location.href = "/main_list.do";
        </script>
    </c:if>
</head>

<body>
<c:choose>

    <c:when test="${empty sessionScope.user}">
        <script>
            alert("로그인 후 이용해주세요.");
            location.href = "/login.do";
        </script>
    </c:when>

    <c:otherwise>
        <h2>신고하기</h2>

        <form action="/report/insert.do" method="post">

            <input type="hidden" name="target_type" value="${param.target_type}">
            <input type="hidden" name="board_id" value="${param.board_id}">
            <input type="hidden" name="comment_id" value="${param.comment_id}">
            <input type="hidden" name="recipe_id" value="${param.recipe_id}">
            <input type="hidden" name="review_id" value="${param.review_id}">

            <c:if test="${not empty board}">
                신고 게시글:
                <a href="/view.do?board_id=${board.board_id}">
                    ${board.title}
                </a>
            </c:if>

            <c:if test="${param.target_type eq '게시판 댓글' and not empty param.comment_id}">
                신고 댓글:
                <a href="/view.do?board_id=${param.board_id}">
                    댓글 보러가기
                </a>
            </c:if>

           <c:if test="${param.target_type eq '레시피' and not empty param.recipe_id}">
                신고 레시피:
                <a href="/recipe_detail.do?recipeId=${param.recipe_id}">
                    레시피 보러가기
                </a>
            </c:if>

            <c:if test="${param.target_type eq '레시피 후기' and not empty param.comment_id}">
                신고 후기:
                <a href="/recipe_detail.do?recipeId=${param.recipe_id}&commentId=${param.comment_id}">
                    후기 보러가기
                </a>
            </c:if>


            <p>
                신고 사유
                <select name="reason" required>
                    <option value="">선택하세요</option>
                    <option value="욕설/비방">욕설/비방</option>
                    <option value="광고/도배">광고/도배</option>
                    <option value="음란물">음란물</option>
                    <option value="허위정보">허위정보</option>
                    <option value="기타">기타</option>
                </select>
            </p>

            <p>
                신고제목
                <input type="text" name="report_title" maxlength="50" required>
            </p>

            <p>
                신고 상세 내용
                <textarea name="detail" rows="8" cols="50"
                          placeholder="신고 상세 내용을 입력하세요"></textarea>
            </p>

            <input type="submit" value="신고하기">
            <input type="button" value="취소" onclick="history.back()">

        </form>
    </c:otherwise>

</c:choose>
</body>
</html>