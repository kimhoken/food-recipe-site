<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 목록</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recipe.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/category.css">
    <link rel="stylesheet" href="/css/chatbot.css" />
    <script src="/js/chatbot.js"></script>
    <script src="${pageContext.request.contextPath}/js/alarm.js"></script>


    <script>
        // 옵션( 최신순, 조회수순, 좋아요순 ) 선택했을 때
        function changeSort(){
            let sortValue = document.getElementsById("recipeSort").value;
            //왼쪽 폼 안에 있는 hidden필드에 선택한 정렬 값 세팅
            documnet.getElementsById("formSort").value = sortValue;
            //기존 필터 유지한 채 폼 보내기
            document.frm.submit();

        }
        
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
            //폼을 보내기 전에 select의 정렬 값을 hidden에 동기화
            document.getElementById("formSort").value = document.getElementById("recipeSort").value;

            document.getElementById("formPage").value = "1";
            
            f.submit();
        }
    </script>


</head>
<body>

    <header>
        <div class="header-top">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/images/Logo.png" alt="로고">
                </a>
            </div>
            
            <form action="${pageContext.request.contextPath}/search.do" method="post" class="search-bar-form">
                <div class="search-bar">
                    <input type="text" id="mainSearch" name="search" placeholder="재료, 요리명으로 검색해보세요!">
                    <button type="submit">⌕</button>
                </div>
            </form>
            
            <div class="user-menu">
                <%-- 로그인/로그아웃으로 session에 값에 따라 변경 --%>
                <c:if test="${empty user}">
                    <a href="/login.do" class="menu-item" id="login">
                        <span class="menu-icon">
                            <img src="${pageContext.request.contextPath}/images/login.png">
                        </span>
                        <div>로그인</div>
                    </a>
                </c:if>
                <c:if test="${!empty user}">
                    <a href="#" class="menu-item" id="login" onClick="logout(); return false;" >
                        <span class="menu-icon">
                            <img src="${pageContext.request.contextPath}/images/login.png">
                        </span>
                        <div>로그아웃</div>
                    </a>
                </c:if>
                <%-- ------------------------------------------ --%>

                <a href="/register_form.do" class="menu-item">
                    <span class="menu-icon">
                        <img src="${pageContext.request.contextPath}/images/login.png">
                    </span>
                    <div>회원가입</div>
                </a>
                
                <a href="${pageContext.request.contextPath}/mypage.do" class="menu-item">
                    <span class="menu-icon">
                        <img src="${pageContext.request.contextPath}/images/mypage.png">
                    </span>
                    <div>마이페이지</div>
                </a>
            </div>
        </div>

        <ul class="nav-bar">
            <li><a href="/">홈</a></li>
            <li class="active">
                <a href="/recipe_list.do"> 레시피</a>
            </li>
            <li>카테고리</li>
            <li>랭킹</li>
            <li><a href="/list.do">커뮤니티</a></li>
            <li><a href="/fridge_list.do?member_id=${user.member_id}">냉장고 추천</a></li>
            <li>키친가이드</li>
        </ul>
    </header>
<div class="recipe-container">

    <!-- 왼쪽 -->

    <aside class="filter-area">

        <form name="frm" action="${pageContext.request.contextPath}/recipe_list.do" method="get">
              
            <input id="formSort" name="sort" type="hidden" value="${recipeSearchDTO.sort}">
            <input type="hidden" name="page" id="formPage" value="${recipeSearchDTO.page}">

            <div class="filter-title">
                필터
            </div>

            <hr><br>

            <div class="filter-section">

                <h4>카테고리</h4>

                <label><input type="radio" name="category" value="상황별추천"
                    <c:if test="${recipeSearchDTO.category eq '상황별추천'}">checked</c:if>> ⭐ 상황별 추천</label>

                <label><input type="radio" name="category" value="한식"
                    <c:if test="${recipeSearchDTO.category eq '한식'}">checked</c:if>> 🍚 한식</label>

                <label><input type="radio" name="category" value="양식"
                    <c:if test="${recipeSearchDTO.category eq '양식'}">checked</c:if>> 🍝 양식</label>

                <label><input type="radio" name="category" value="중식"
                    <c:if test="${recipeSearchDTO.category eq '중식'}">checked</c:if>> 🍳 중식</label>

                <label><input type="radio" name="category" value="일식"
                    <c:if test="${recipeSearchDTO.category eq '일식'}">checked</c:if>> 🍣 일식</label>

                <label><input type="radio" name="category" value="아시안"
                    <c:if test="${recipeSearchDTO.category eq '아시안'}">checked</c:if>> 🌏 아시안</label>

                <label><input type="radio" name="category" value="건강식/다이어트"
                    <c:if test="${recipeSearchDTO.category eq '건강식/다이어트'}">checked</c:if>> 🥗 건강식/다이어트</label>

                <label><input type="radio" name="category" value="초간단요리"
                    <c:if test="${recipeSearchDTO.category eq '초간단요리'}">checked</c:if>> ⏱️ 초간단요리</label>

                <label><input type="radio" name="category" value="디저트"
                    <c:if test="${recipeSearchDTO.category eq '디저트'}">checked</c:if>> 🍰 디저트</label>

                <label><input type="radio" name="category" value="베이킹"
                    <c:if test="${recipeSearchDTO.category eq '베이킹'}">checked</c:if>> 🍞 베이킹</label>

                <label><input type="radio" name="category" value="음료/차"
                    <c:if test="${recipeSearchDTO.category eq '음료/차'}">checked</c:if>> ☕ 음료/차</label>

            </div>

            <hr><br>

            <div class="filter-section">

                <h4>조리시간</h4>

                <label>
                <input type="checkbox" name="cookTimes" value="10" 
                    <c:forEach var="time" items="${recipeSearchDTO.cookTimes}">
                        <c:if test="${time eq '10'}">checked</c:if>
                    </c:forEach>>          
                10분 이하
                </label>

                <label>
                    <input type="checkbox" name="cookTimes" value="20" 
                        <c:forEach var="time" items="${recipeSearchDTO.cookTimes}">
                            <c:if test="${time eq '20'}">checked</c:if>
                        </c:forEach>>  
                    10~20분
                </label>

                <label>
                    <input type="checkbox" name="cookTimes" value="30" 
                        <c:forEach var="time" items="${recipeSearchDTO.cookTimes}">
                            <c:if test="${time eq '30'}">checked</c:if>
                        </c:forEach>>   
                    20~30분
                </label>

                <label>
                    <input type="checkbox" name="cookTimes" value="60" 
                        <c:forEach var="time" items="${recipeSearchDTO.cookTimes}">
                            <c:if test="${time eq '60'}">checked</c:if>
                        </c:forEach>>       
                    30~60분
                </label>

                <label>
                    <input type="checkbox" name="cookTimes" value="61" 
                        <c:forEach var="time" items="${recipeSearchDTO.cookTimes}">
                            <c:if test="${time eq '61'}">checked</c:if>
                        </c:forEach>>
                    60분 이상
                </label>

            </div>

            <button class="filter-btn" type="button" onclick="send()">        
                적용하기
            </button> 

        </form>

    </aside>

    <!-- 오른쪽 -->

    <section class="recipe-area">

        <div class="recipe-header">
            
            <select class="sort-select" name="sort" id="recipeSort" onchange="changeSort()">            

                <option value="latest" ${recipeSearchDTO.sort eq 'latest' ? 'selected' : ''}>
                    최신순
                </option>

                <option value="view" ${recipeSearchDTO.sort eq 'view' ? 'selected' : ''}>
                    조회수순
                </option>

                <option value="like" ${recipeSearchDTO.sort eq 'like' ? 'selected' : ''}>
                    좋아요순
                </option>

            </select>

        </div>

        <div class="recipe-list">

            
    <c:choose>
        <c:when test="${not empty emptyMsg}">
            <%-- 빈 결과 메시지 --%>
            <p class="empty-msg">${emptyMsg}</p>
        </c:when>
        <c:otherwise>
            <c:forEach items="${recipeList}" var="recipe">
                <div class="recipe-card">
                    <img src="${pageContext.request.contextPath}/images/${recipe.thumbnail}">
                    <div class="recipe-info">
                        <div class="recipe-title">${recipe.title}</div>
                        <div class="recipe-meta">
                            ⏱ ${recipe.cooking_time}
                            <br>
                            👁 ${recipe.view_count}
                            &nbsp;&nbsp;
                            ❤️ ${recipe.like_count}
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>

        </div>

<<<<<<< HEAD
    <c:if test="${totalPage > 0}">

    <div class="paging">
        <c:set var="curPage" value="${empty recipeSearchDTO.page ? 1 : recipeSearchDTO.page}" />
        <c:set var="currentSort" value="${empty recipeSearchDTO.sort ? 'latest' : recipeSearchDTO.sort}" />
        
        <a href="${curPage > 1 ? '/recipe_list.do?page='.concat(curPage - 1).concat('&category=').concat(recipeSearchDTO.category).concat('&sort=').concat(currentSort) : '#'}<c:forEach var='t' items='${recipeSearchDTO.cookTimes}'><c:if test='${curPage > 1}'>&cookTimes=${t}</c:if></c:forEach>" 
           class="arrow ${curPage == 1 ? 'disabled' : ''}">◀</a>
=======
        <c:if test="${totalPage > 0}">
                
            <div class="paging">
                <c:set var="curPage" value="${empty recipeSearchDTO.page ? 1 : recipeSearchDTO.page}" />
                
                <a href="${curPage > 1 ? '/recipe_list.do?page='.concat(curPage - 1).concat('&category=').concat(recipeSearchDTO.category) : '#'}<c:forEach var='t' items='${recipeSearchDTO.cookTimes}'><c:if test='${curPage > 1}'>&cookTimes=${t}</c:if></c:forEach>" 
                class="arrow ${curPage == 1 ? 'disabled' : ''}">◀</a>
>>>>>>> 1a68d347e6e02acf981e841487911912d3b4cfea

        <c:set var="startP" value="${curPage - 1 < 1 ? 1 : (curPage == totalPage and totalPage >= 3 ? totalPage - 2 : curPage - 1)}" />
        <c:set var="endP" value="${startP + 2 > totalPage ? totalPage : startP + 2}" />

        <c:if test="${totalPage < 1}">
            <c:set var="startP" value="1" />
            <c:set var="endP" value="1" />
        </c:if>

        <c:forEach var="i" begin="${startP}" end="${endP}">
            <a href="/recipe_list.do?page=${i}&category=${recipeSearchDTO.category}&sort=${currentSort}<c:forEach var='t' items='${recipeSearchDTO.cookTimes}'>&cookTimes=${t}</c:forEach>" 
               class="${i == curPage ? 'active' : ''}">
                ${i}
            </a>
        </c:forEach>

        <a href="${curPage < totalPage ? '/recipe_list.do?page='.concat(curPage + 1).concat('&category=').concat(recipeSearchDTO.category).concat('&sort=').concat(currentSort) : '#'}<c:forEach var='t' items='${recipeSearchDTO.cookTimes}'><c:if test='${curPage < totalPage}'>&cookTimes=${t}</c:if></c:forEach>" 
           class="arrow ${curPage == totalPage || totalPage <= 1 ? 'disabled' : ''}">▶</a>
        
    </div>

</c:if>

    </section>

</div>

    <footer>
        <div class="footer-container">
            <div class="footer-top-row">
                <div class="cs-section">
                    <h3>고객센터</h3>
                    <div class="cs-buttons">
                        <div class="cs-btn">📞 1833-8307</div>
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