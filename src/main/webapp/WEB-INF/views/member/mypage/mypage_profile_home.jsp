<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <section>
            <div>
                <h3>최근 작성 레시피</h3>
                <!-- forEach로 레시피 5개, 댓글 5개 출력 -->
                <c:forEach var="recipe" items="recentlyRecipeList">
                    <a href="#">
                        <div>
                            
                        </div>
                    </a>
                </c:forEach>
                <!--  -->
            </div>

            <div>
                <h3>최근 작성 댓글</h3>
                <a href="#">
                    <div>댓글 내용</div>
                    <span>작성한 게시글</span>
                    <span>작성 일자</span>
                </a>

            </div>


        </section>