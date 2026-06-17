<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/navibar.jsp"/>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>오늘 뭐 먹지? - 레시피 목록</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recipe.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/category.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search_bar.css">
        <link rel="stylesheet" href="/css/chatbot.css" />
        <script src="/js/chatbot.js"></script>
        <script src="${pageContext.request.contextPath}/js/alarm.js"></script>
        <script>
            window.onload = ()=>{
                const sort = '${sort}';
                let select = document.getElementById("sort");
                let arr = ["latest", "name", "view", "like" ];

                for(let i=0 ; i<arr.length ; i++){
                    if(arr[i] == sort){
                        select.options[i].selected = true;
                    }
                }
            }//onload
            function send() {
                let f = document.frm;
                //카테고리 선택 여부
                let catChecked = false;
                let categoryList = document.getElementsByName("category");
                for (let i = 0; i < categoryList.length; i++) {
                    if (categoryList[i].checked) {
                        catChecked = true;
                        break;
                    }
                }
                
                if (!catChecked) {
                    alert("카테고리를 선택해주세요!");
                    return;
                }
                
                f.submit();
            }//send
            document.addEventListener("DOMContentLoaded", function() {
                const searchInput = document.getElementById("mainSearch");
                const searchDropdown = document.getElementById("searchDropdown");
                
                // 1. 검색창에 포커스가 가면 드롭다운 띄우기
                searchInput.addEventListener("focus", function() {
                    searchDropdown.style.display = "block";
                });
                
                // 2. 검색창이나 드롭다운 바깥 영역을 클릭하면 닫기
                document.addEventListener("click", function(event) {
                    // 클릭한 타겟이 검색창도 아니고 드롭다운 내부도 아니면 닫음
                    if (!searchInput.contains(event.target) && !searchDropdown.contains(event.target)) {
                        searchDropdown.style.display = "none";
                    }
                });
            });
        </script>
    </head>
    <body>
        
        <form name="frm" action="${pageContext.request.contextPath}/recipe_list.do" method="get">
            <div class="recipe-container">
                <!-- 왼쪽 -->
                <aside class="filter-area">
                    <div class="filter-title">필터</div>
                    <hr><br>
                    <div class="filter-section">
                        <h4>카테고리</h4>
                        <%-- 삼항 연산자를 써서 코드를 훨씬 깔끔하게 만들기 --%>
                        <label><input type="radio" name="category" value="상황별추천" ${recipeSearchDTO.category eq '상황별추천' ? 'checked' : ''}> ⭐ 상황별 추천</label>
                        <label><input type="radio" name="category" value="한식" ${recipeSearchDTO.category eq '한식' ? 'checked' : ''}> 🍚 한식</label>
                        <label><input type="radio" name="category" value="양식" ${recipeSearchDTO.category eq '양식' ? 'checked' : ''}> 🍝 양식</label>
                        <label><input type="radio" name="category" value="중식" ${recipeSearchDTO.category eq '중식' ? 'checked' : ''}> 🍳 중식</label>
                        <label><input type="radio" name="category" value="일식" ${recipeSearchDTO.category eq '일식' ? 'checked' : ''}> 🍣 일식</label>
                        <label><input type="radio" name="category" value="아시안" ${recipeSearchDTO.category eq '아시안' ? 'checked' : ''}> 🌏 아시안</label>
                        <label><input type="radio" name="category" value="건강식/다이어트" ${recipeSearchDTO.category eq '건강식/다이어트' ? 'checked' : ''}> 🥗 건강식/다이어트</label>
                        <label><input type="radio" name="category" value="초간단요리" ${recipeSearchDTO.category eq '초간단요리' ? 'checked' : ''}> ⏱️ 초간단요리</label>
                        <label><input type="radio" name="category" value="디저트" ${recipeSearchDTO.category eq '디저트' ? 'checked' : ''}> 🍰 디저트</label>
                        <label><input type="radio" name="category" value="베이킹" ${recipeSearchDTO.category eq '베이킹' ? 'checked' : ''}> 🍞 베이킹</label>
                        <label><input type="radio" name="category" value="음료/차" ${recipeSearchDTO.category eq '음료/차' ? 'checked' : ''}> ☕ 음료/차</label>
                    </div>
                    <hr><br>
                    <div class="filter-section">
                        <h4>조리시간</h4>
                        <%-- 체크박스 상태를 위해 밖에서 미리 변수 세팅하기 --%>
                        <c:set var="chk10" value=""/>
                        <c:set var="chk20" value=""/>
                        <c:set var="chk30" value=""/>
                        <c:set var="chk60" value=""/>
                        <c:set var="chk61" value=""/>

                        <c:if test="${not empty recipeSearchDTO.cookTimes}">
                            <c:forEach var="time" items="${recipeSearchDTO.cookTimes}">
                                <c:if test="${time eq '10'}"><c:set var="chk10" value="checked"/></c:if>
                                <c:if test="${time eq '20'}"><c:set var="chk20" value="checked"/></c:if>
                                <c:if test="${time eq '30'}"><c:set var="chk30" value="checked"/></c:if>
                                <c:if test="${time eq '60'}"><c:set var="chk60" value="checked"/></c:if>
                                <c:if test="${time eq '61'}"><c:set var="chk61" value="checked"/></c:if>
                            </c:forEach>
                        </c:if>

                        <%-- 세팅된 변수를 EL로 넣어주기만 하면 끝 --%>
                        <label><input type="checkbox" name="cookTimes" value="10" ${chk10}> 10분 이하</label>                                                                              
                        <label><input type="checkbox" name="cookTimes" value="20" ${chk20}> 10~20분</label>
                        <label><input type="checkbox" name="cookTimes" value="30" ${chk30}> 20~30분</label>
                        <label><input type="checkbox" name="cookTimes" value="60" ${chk60}> 30~60분</label>
                        <label><input type="checkbox" name="cookTimes" value="61" ${chk61}> 60분 이상</label>
                    </div>
                    <button class="filter-btn" type="button" onclick="send()">
                        적용하기
                    </button>
                </aside> 
                <!-- 오른쪽 -->
                <section class="recipe-area">
                    <div class="recipe-header">                                                                            
                        <select class="sort-select" name="sort" id="sort" onChange="send()">                                                                                                                              
                            <option value="latest">최신순</option>                                                                                                        
                            <option value="name">가나다순</option>
                            <option value="view">조회수순</option>
                            <option value="like">좋아요순</option>
                        </select>
                    </div>
                    <div class="today-recommend-header">
                        <div class="today-recommend-inner">
                            <span class="today-recommend-inner-span">TODAY</span>
                            <h5>오늘의 추천 레시피 ✨</h5>
                        </div>
                    </div>
                    <div class="recipe-list">
                        <c:choose>
                            <c:when test="${not empty emptyMsg}">
                                <%-- 빈 결과 메시지 --%>
                                <p class="empty-msg">${emptyMsg}</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${recipeList}" var="recipe">
                                    <a href="/recipe_detail.do?recipeId=${recipe.recipe_id}">
                                        <div class="recipe-card">
                                            <img src="${pageContext.request.contextPath}/${recipe.thumbnail}"/>
                                            <div class="recipe-info">
                                                <div class="recipe-title">${recipe.title}(${recipe.food_name})</div>
                                                <div class="recipe-meta">
                                                    ⏱ ${recipe.cooking_time}
                                                    &nbsp;&nbsp;
                                                    등록일자: ${recipe.created_date}
                                                    <br>
                                                    👁 ${recipe.view_count}
                                                    &nbsp;&nbsp;
                                                    ❤️ ${recipe.like_count}
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>                                                                                                                        
                    </div>
                    <%-- 페이징 --%>
                    <c:if test="${totalPage > 0}">
                        <div class="paging">
                            <c:set var="curPage" value="${empty recipeSearchDTO.page ? 1 : recipeSearchDTO.page}" />
                            
                            <%-- 1. 반복되는 cookTimes 쿼리 스트링을 밖에서 미리 변수로 만들어두기 --%>
                            <c:set var="cookTimesQuery" value="" />
                            <c:if test="${not empty recipeSearchDTO.cookTimes}">
                                <c:forEach var="t" items="${recipeSearchDTO.cookTimes}">
                                    <c:set var="cookTimesQuery" value="${cookTimesQuery}&cookTimes=${t}" />
                                </c:forEach>
                            </c:if>

                            <%-- 2. 이전 버튼 (미리 만든 cookTimesQuery를 concat으로 붙이기) --%>
                            <a href="${curPage > 1 ? '/recipe_list.do?page='.concat(curPage - 1).concat('&category=').concat(recipeSearchDTO.category).concat(cookTimesQuery) : '#'}"
                            class="arrow ${curPage == 1 ? 'disabled' : ''}">◀</a>

                            <c:set var="startP" value="${curPage - 1 < 1 ? 1 : (curPage == totalPage and totalPage >= 3 ? totalPage - 2 : curPage - 1)}" />
                            <c:set var="endP" value="${startP + 2 > totalPage ? totalPage : startP + 2}" />
                            <c:if test="${totalPage < 1}">
                                <c:set var="startP" value="1" />
                                <c:set var="endP" value="1" />
                            </c:if>

                            <%-- 3. 페이지 번호 (여기도 cookTimesQuery 변수 사용) --%>
                            <c:forEach var="i" begin="${startP}" end="${endP}">
                                <a href="/recipe_list.do?page=${i}&category=${recipeSearchDTO.category}${cookTimesQuery}"
                                class="${i == curPage ? 'active' : ''}">
                                ${i}
                                </a>
                            </c:forEach>

                            <%-- 4. 다음 버튼 --%>
                            <a href="${curPage < totalPage ? '/recipe_list.do?page='.concat(curPage + 1).concat('&category=').concat(recipeSearchDTO.category).concat('&sort=').concat(currentSort).concat(cookTimesQuery) : '#'}"
                            class="arrow ${curPage == totalPage || totalPage <= 1 ? 'disabled' : ''}">▶</a>
                        </div>
                    </c:if>
                </section>
            </div>
        </form>
        <footer>
            <div class="footer-container">
                <div class="footer-top-row">
                    <div class="cs-section">
                        <h3>고객센터</h3>
                        <div class="cs-buttons">
                            <div class="cs-btn" onClick="location.href='/hidden.do'">📞 1833-8307</div>
                            <div class="cs-btn">💬 1:1문의하기</div>
                        </div>
                        <div class="hours-info">
                            <p><strong>운영시간</strong></p>
                            <p>전화문의 - 10:00 ~ 12:00, 13:00 ~ 17:00 / 주말·공휴일 휴무</p>
                            <p>1:1 문의 - 09:00 ~ 12:00, 13:00 ~ 17:30 / 주말·공휴일 휴무</p>
                        </div>
                    </div>
                    <div class="sns-icons">
                        <span class="sns-icon">▶</span>
                        <span class="sns-icon">★</span>
                        <span class="sns-icon">☆</span>
                        <span class="sns-icon">◆</span>
                        <span class="sns-icon">♬</span>
                    </div>
                </div>
            </div>

            <div class="footer-nav-bar">
                <div class="footer-container">
                    <div class="nav-links">
                        <a href="#"><strong>이용약관</strong></a>
                        <a href="#"><strong>개인정보처리방침</strong></a>
                        <a href="/notice.do">공지사항</a>
                        <a href="#">자주묻는질문</a>
                        <span class="partner-mail">광고/제휴 문의: kh@culture.net</span>
                    </div>
                </div>
            </div>

            <div class="footer-container">
                <div class="footer-bottom-row">
                    <div class="company-info">
                        <h4>주식회사 코코짱짱</h4>
                        <p>
                            <span>상호 : KH 개발</span>
                            <span>대표자 : 장승연</span>
                            <span>개인정보관리책임자 : 장승연</span>
                            <span>사업자 등록번호 : 111-01-31111</span>
                        </p>
                        <p>
                            <span>통신판매업 신고 : 제 2015-경기성남-1940 호</span>
                            <span>전화 : 1833-1234</span>
                            <span>팩스 : 031-8017-1800</span>
                        </p>
                        <p>주소 : 경기도 성남시 분당구 판교로 216길 92, kh타워 22층 2201호( 삼평동, 판교 에이치스퀘어 ) &nbsp;&nbsp; 이메일: kh@culture.net</p>
                    </div>

                    <div class="footer-logo-area">
                        <p class="copyright">© 2026 by Khculture. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>
        <!-- 챗봇 -->
        <jsp:include page="/WEB-INF/views/chatbot/chatbot_main.jsp" />
    </body>
</html>
