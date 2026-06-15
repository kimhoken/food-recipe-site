<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <body>
            <section>
                <div>
                    <div class="activity-left">
                        <h3> 내활동</h3>
                        <div class="activity-menu">
                            <span>레시피</span>
                            <span>댓글</span>
                            <span>북마크</span>
                        </div>
                        <div id="recipe-box">
                            <h3>최근 작성 레시피</h3>
                            <!-- forEach로 레시피 5개, 댓글 5개 출력 -->
                            <c:forEach var="recipe" items="${recentlyRecipeList}">
                                <a href="#">
                                    <div>
                                        <img src="/upload/recipe/${recipe.thumbnail}" />
                                        <strong>${recipe.title}</strong>
                                        <small>${recipe.created_date}</small>
                                    </div>
                                </a>
                            </c:forEach>
                            <!--  -->
                        </div>
                        
                        <div id="comment-box">
                            <h3>최근 작성된 댓글</h3>
                            <!-- forEach로 레시피 5개, 댓글 5개 출력 -->
                            <c:forEach var="comment" items="${commentList}">
                                <a href="#">
                                    <div>
                                        <img src="/upload/recipe/" />
                                        <strong>${comment.content}</strong>
                                        <small>${comment.created_date}</small>
                                    </div>
                                </a>
                            </c:forEach>
                            <!--  -->
                        </div>

                        <div id="bookmark-box">
                            <h3>북마크</h3>
                            <!-- forEach로 레시피 5개, 댓글 5개 출력 -->
                            <c:forEach var="bookmark" items="${bookmarkList}">
                                <a href="#">
                                    <div>
                                        <img src="/upload/" />
                                        <strong>${bookmark.bookmark_id}</strong>
                                        <small>${bookmark.created_date}</small>
                                    </div>
                                </a>
                            </c:forEach>
                            <!--  -->
                        </div>

                        <input type="button" value="더보기" onclick="" />
                    </div>
                </div>

                <div class="activity-right">
                    <!-- 활동 내역 출력을 최근순 5개 출력하게 세팅 예정  -->
                    <h3>최근 활동 내역</h3>
                    <!-- 나중에 foreach 사용 예정 -->
                    <c:forEach var="activity" items="${activity}">
                    <div>${activity.activity_title} <span>${activity.created_date}</span></div>
                    </c:forEach>
                    <!--  -->
                </div>
                <div><input type="button" value="다른 회원정보 보기" onclick="location.href='/user/1'" /></div>
            </section>
        </body>

        </html>