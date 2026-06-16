<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <section>
        <div class="recipe-box">
            <h3>내가 쓴 레시피</h3>
            <div class="recipe-list">
                <select>
                    <option value="recently">최신순</option>
                    <option value="asc">오름차순</option>
                    <option value="desc">내림차순</option>
                    <option value="likes">좋아요순</option>
                </select>
                <c:if test="${ empty list }">
                    <div>작성한 레시피가 존재하지 않습니다.</div>
                    <input type="button" value="레시피 등록 하러 가기" onclick=""/>
                </c:if>
                <c:forEach var="recipe" items="${list}">
                    <img src="/upload/recipe/${recipe.thumbnail}"/>
                    <a href="/recipe_detail.do?id=${recipe.recipe_id}"><strong>${recipe.title}</storng></a>
                    <small>${recipe.created_date}</small>

                </c:forEach>
                                

            </div>
            <c:set var="pageUrl" value="/mypage.do?menu=recipe" scope="request"/>
           <jsp:include page="/WEB-INF/views/common/paging.jsp"/>
        </div>
    </section>