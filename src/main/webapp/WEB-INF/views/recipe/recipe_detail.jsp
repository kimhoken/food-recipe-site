<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/common/navibar.jsp"/>
        <%-- 레시피의 조리순서, 재료, 사진 등을 보여주기 --%>
        <div>
            <table border="1">
                <tr>
                    <th>레시피 이름</th>
                    <td>${recipeId}번의 아이디</td>
                </tr>
            </table>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </body>
</html>