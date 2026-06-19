<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

        <c:set var="separator" value="${fn:contains(pageUrl, '?') ? '&' : '?'}" />

        <nav class="paging">
            <c:if test="${paging.prev}">
                <a href="${pageUrl}${separator}page=${paging.startpage-1}">이전</a>
            </c:if>

            <c:forEach var="p" begin="${paging.startpage}" end="${paging.endpage}">
                <a href="${pageUrl}${separator}page=${p}" class="${paging.page == p ? 'active' : ''}">
                    ${p}
                </a>
            </c:forEach>

            <c:if test="${paging.next}">
                <a href="${pageUrl}${separator}page=${paging.endpage + 1}">다음</a>
            </c:if>
        </nav>
