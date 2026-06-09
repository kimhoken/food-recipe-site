<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/member/mypage.jsp"/>
<html>

    <head>

    </head>

    <body>
        <c:if test="${ sel eq 'info' }">
            <div>
                안녕 정보 페이지야
            </div>
        </c:if>
        <c:if test="${ sel eq 'pwd' }">
            <div>
                안녕 비밀번호 변경 페이지야
            </div>
        </c:if>
        <c:if test="${ sel eq 'del' }">
            <div>
                안녕 탈퇴 페이지야
            </div>
        </c:if>
    </body>

</html>