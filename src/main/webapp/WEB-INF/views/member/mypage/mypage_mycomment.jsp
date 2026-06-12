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
                <!-- foreach문으로 돌릴 예정 -->
                <img src="#"/>
                <a href="#"><strong>댓글 내용</storng></a>
                <small>작성일자</small>
                
                <!--  -->

            </div>
            <!-- 페이징 구현 해서 아래에 출력하게 하기 -->
            <div> 페이징 처리 &lt 1 &gt</div>
        </div>
    </section>