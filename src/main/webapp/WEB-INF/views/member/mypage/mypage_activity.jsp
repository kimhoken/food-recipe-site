<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <body>
           <section>
                <div>
                   <div class="activity-left">
                        <h3> 내활동</h3>
                        <div class="activity-menu" >
                            <span>레시피</span>
                            <span>댓글</span>
                            <span>북마크</span>                            
                        </div>
                        <!-- foreach로 레시피, 댓글, 북마크 최근순 5개 가져올예정 -->
                        <div class="activity-view" >
                            <img src="#"/>
                            <a href="#">김치찌개 레시피</a>
                            <span>작성일</span>
                        </div>
                        <!--  -->

                        <input type="button" value="더보기" onclick=""/>
                   </div>
                </div>

                <div class="activity-right">
                    <!-- 활동 내역 출력을 최근순 5개 출력하게 세팅 예정  -->
                    <h3>최근 활동 내역</h3>
                    <!-- 나중에 foreach 사용 예정 -->
                    <div>김치찌개 레시피 등록 <span>1시간전</span></div>
                    <!--  -->
                </div>
           </section>
        </body>

        </html>