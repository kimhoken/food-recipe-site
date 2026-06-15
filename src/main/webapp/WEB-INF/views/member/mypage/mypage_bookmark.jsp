<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<section>
    <div class="recipe-box">
            <h3>내가 쓴 북마크</h3>
            <div class="recipe-list">
                <select>
                    <option value="recently">최신순</option>
                    <option value="asc">오름차순</option>
                    <option value="desc">내림차순</option>
                    <option value="likes">좋아요순</option>
                </select>
                <!-- foreach문으로 돌릴 예정 -->
                 <c:forEach var="bookmark" items="${list}">
                    <img src="#"/>
                    <a href="#"><strong>${bookmark.bookmark_id}</storng></a>
                    <small>${bookmark.created_date}</small>
                 </c:forEach>
                <!--  -->

            </div>
            <c:set var="pageUrl" value="/mypage.do?menu=bookmark" scope="request"/>
           <jsp:include page="/WEB-INF/views/common/paging.jsp"/>


        </div>
</section>    