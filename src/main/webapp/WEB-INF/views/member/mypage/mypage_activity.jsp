<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <body>
            <c:choose>

                <c:when test="${ sel eq 'document' }">
                    <section>
                        안녕 레시피 페이지야
                    </section>
                </c:when>

                <c:when test="${ sel eq 'comment' }">
                    <section>
                        안녕 댓글 페이지야
                    </section>
                </c:when>

                <c:when test="${ sel eq 'bookmark' }">
                    <section>
                        안녕 북마크 페이지야
                    </section>
                </c:when>

            </c:choose>
        </body>

        </html>