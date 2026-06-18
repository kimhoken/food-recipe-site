<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 키친가이드 상세페이지 --%>
<c:set var="currentMenu" value="guide" />
<jsp:include page="/WEB-INF/views/common/navibar.jsp"/>

        <!DOCTYPE html>
        <html>

        <head>
            <title>키친가이드 상세페이지</title>
            <style>
                /* 배경 흰색 고정 */
                body.guide-page {
                    background-color: #ffffff !important;
                }
            </style>
        </head>

        <body class="guide-page">


            <p> 여긴 상세페이지 </p>


            <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
        </body>

        </html>