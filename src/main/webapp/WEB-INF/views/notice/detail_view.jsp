<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <script>
            function deleteNotice() {
                if (confirm("삭제하시겠습니까?")) {
                    location.href = "notice_delete.do?notice_id=${notice.notice_id}";
                }
            }
        </script>
    </head>
    <body>

        <table border="1">
            <tr>
                <th></th>
                <td>${notice.notice_id}</td>
            </tr>

            <tr>
                <th>제목</th>
                <td>${notice.title}</td>
            </tr>

            <tr>
                <th>작성자</th>
                <td>${notice.member_id}</td>
            </tr>

            <tr>
                <th>내용</th>
                <td>
                    <img src="${image_list}" style="max-width: 200px; max-height: 200px;" />
                    ${notice.content}    
                </td>
            </tr>

            <tr>
                <th>작성일</th>
                <td>
                    <fmt:formatDate value="${notice.created_date}" pattern="yyyy-MM-dd HH:mm:ss" />
                </td>
            </tr>

            <tr>
                <th>조회수</th>
                <td>${notice.view_count}</td>
            </tr>
        </table>

        <c:if test="${sessionScope.user.role eq 'ADMIN'}">
            <input type="button" value="수정" onclick="location.href='notice_update.do?notice_id=${notice.notice_id}'" />
            <input type="button" value="삭제" onclick="deleteNotice()" />
        </c:if>

        <input type="button" value="목록" onclick="history.back()" />

    </body>
</html>