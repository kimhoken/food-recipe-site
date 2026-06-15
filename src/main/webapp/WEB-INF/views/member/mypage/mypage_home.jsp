<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <body>
            <section class="home-page">
                <div class="home-grid">
                    <div class="activity-box">
                        <div class="box-header">
                            <h3> 내활동</h3>
                        </div>

                        <div class="activity-tab">
                            <span class="tab-btn active" onclick="btn_change('recipe')">레시피</span>
                            <span class="tab-btn" onclick="btn_change('comment')">댓글</span>
                            <span class="tab-btn" onclick="btn_change('bookmark')">북마크</span>
                        </div>
                        <div id="recipebox" class="activity-list">
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
                        
                        <div id="commentbox">
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

                        <div id="bookmarkbox">
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

                        <input id="see-btn" type="button" value="더보기" onclick="" />
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