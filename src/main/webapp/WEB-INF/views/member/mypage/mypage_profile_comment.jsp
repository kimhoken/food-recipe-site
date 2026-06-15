<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <section>

            <div>
                <h3>레시피 목록</h3>
                <c:forEach var="comment" items="${list}">
                    <a href="#">
                        <img src="#" />
                        <div>${comment.content}</div>
                        <span>${comment.created_date}</span>
                    </a>
                </c:forEach>
            </div>

            <c:set var="pageUrl" value="/user/${member_id}?menu=comment" scope="request" />
            <jsp:include page="/WEB-INF/views/common/paging.jsp" />

        </section>