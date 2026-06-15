<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>

    </head>

    <body>

    <h2 align="center">문의 관리</h2>

    <table border="1" align="center">
        <tr>
            <th>번호</th>
            <th>유형</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>답변상태</th>
        </tr>

        <c:forEach var="vo" items="${list}">
            <tr>
                <td>${vo.inquiry_id}</td>
                <td>${vo.type}</td>

                <td>
        
                    <a href="/inquiry/admin/detail?inquiry_id=${vo.inquiry_id}">
                        ${vo.title}
                    </a>
                </td>

                <td>
                
                    <c:choose>
                        <c:when test="${not empty vo.member_id}">
                            회원번호 ${vo.member_id}
                        </c:when>
                        <c:otherwise>
                            ${vo.guest_name}
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <fmt:formatDate value="${vo.created_date}" pattern="yyyy-MM-dd HH:mm"/>
                </td>

                <td>
                    
                    <c:choose>
                        <c:when test="${vo.status eq 'y'}">
                            답변 완료
                        </c:when>
                        <c:otherwise>
                            답변 대기
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>

    </body>
</html>