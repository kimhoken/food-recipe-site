<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <section>
        <div class="recipe-box">
            <h3>내가 쓴 댓글</h3>
            <div class="recipe-list">
                <select>
                    <option value="recently">최신순</option>
                    <option value="asc">오름차순</option>
                    <option value="desc">내림차순</option>
                    <option value="likes">좋아요순</option>
                </select>

                <c:if test="${ empty list }">
                    <div>작성한 댓글이 존재하지 않습니다.</div>
                </c:if>
                
                <!-- foreach문으로 돌릴 예정 -->
                <c:forEach var="comment" items="${list}">            
                <img src="#"/>
                <a href="#"><strong>${comment.content}</storng></a>
                <small>${comment.created_date}</small>
                </c:forEach>
                <!--  -->

            </div>
            <!-- 페이징 구현 해서 아래에 출력하게 하기 -->
            <c:set var="pageUrl" value="/mypage.do?menu=comment" scope="request"/>
           <jsp:include page="/WEB-INF/views/common/paging.jsp"/>
        </div>
    </section>