<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
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

                        <input type="hidden" name="board_id" value="${param.board_id}">
                        <input type="hidden" name="comment_id" value="${param.comment_id}">
                        <input type="hidden" name="recipe_id" value="${param.recipe_id}">
                        <input type="hidden" name="review_id" value="${param.review_id}">

                        <p>
                            신고 대상
                            <select name="target_type">
                                <option value="">선택하세요</option>
                                <option value="게시판" ${param.target_type eq '게시판' ? 'selected' : ''}>게시판</option>
                                <option value="게시판 댓글" ${param.target_type eq '게시판 댓글' ? 'selected' : ''}>게시판 댓글</option>
                                <option value="레시피" ${param.target_type eq '레시피' ? 'selected' : ''}>레시피</option>
                                <option value="레시피 후기" ${param.target_type eq '레시피 후기' ? 'selected' : ''}>레시피 후기</option>
                            </select>
                        </p>

                        <p>
                            신고 사유
                            <select name="reason">
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
                            <input type="text" name="report_title" maxlength="50" required />
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