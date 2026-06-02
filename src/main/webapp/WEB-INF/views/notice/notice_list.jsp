<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
    <head>
    
    </head>

     <body>
        <h2>공지사항 목록</h2>
        <p>새로운 소식과 안내사항을 전달해드립니다</p>

        <table border="1" align="center">
                
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>

            <c:forEach var="vo" items="${notice}">
            
            <tr>
                <td>${vo.notice_id}</td>
                <td>
                     <a href="notice_detail.do?notice_id=${vo.notice_id}">
                        ${vo.title}
                    </a>
                </td>
                
                <td>${vo.member_id}</td>
                    
                <td>
                    <fmt:formatDate value="${vo.created_date}" pattern="yyyy-MM-dd HH:mm:ss" />
                </td>
            
                <td>${vo.view_count}</td>
            </tr>
                
            </c:forEach>

            <tr>
                <td colspan="5" align="center">
                    ${pageMenu}
                </td>
            </tr>

            <c:if test="${user.role eq 'ADMIN'}">
                <input type="button" value="공지등록" onclick="location.href='notice_add.do'">
            </c:if>
              
        </table>
    </body>

</html>