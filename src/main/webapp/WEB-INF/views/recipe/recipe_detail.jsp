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
            작성자: ${dto.nickName}
            <div>
                <%-- 레시피 대표사진 넣는 곳 --%>
                <table border="1">
                    <tr>
                        <td rowspan="${size + 1}">레시피 사진 들어가는 자리</td>
                        <th colspan="2">필요한 재료</th>
                    </tr>
                    <c:forEach var="vo" items="${ingredients}">
                        <tr>
                            <td>${vo.ingredient_name}</td>
                            <td>${vo.quantity}${vo.unit}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <table border="1">
                <tr>
                    <th colspan="3">조리 순서</th>
                </tr>
                <c:forEach var="vo" items="${orderList}">
                    <tr>
                        <td rowspan="2">
                            사진 들어가는 자리
                        </td>
                        <td>조리 순서: ${vo.order}</td>
                    </tr>
                    <tr>
                        <td>${vo.description}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </body>
</html>