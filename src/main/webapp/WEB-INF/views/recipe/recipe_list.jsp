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
            <li>홈</li>
            <li>
                <a href="/recipe_list.do"> 레시피</a>
            </li>
            <li>카테고리</li>
            <li>랭킹</li>
            <li><a href="/list.do">커뮤니티</a></li>
            <li><a href="/fridge_list.do?member_id=${user.member_id}">냉장고 추천</a></li>
            <li>이벤트</li>
        </ul>

<div class="recipe-container">

    <!-- 왼쪽 -->

    <aside class="filter-area">

        <form action="${pageContext.request.contextPath}/recipe_list.do" method="get">
              

            <div class="filter-title">
                필터
            </div>

            <hr><br>

            <div class="filter-section">

                <h4>카테고리</h4>

                <label><input type="radio" name="category" value="상황별추천"> ⭐ 상황별 추천</label>

                <label><input type="radio" name="category" value="한식"> 🍚 한식</label>

                <label><input type="radio" name="category" value="양식"> 🍝 양식</label>

                <label><input type="radio" name="category" value="중식"> 🍳 중식</label>

                <label><input type="radio" name="category" value="일식"> 🍣 일식</label>

                <label><input type="radio" name="category" value="아시안"> 🌏 아시안</label>

                <label><input type="radio" name="category" value="건강식/다이어트"> 🥗 건강식/다이어트</label>

                <label><input type="radio" name="category" value="초간단요리"> ⏱️ 초간단요리</label>

                <label><input type="radio" name="category" value="디저트"> 🍰 디저트</label>

                <label><input type="radio" name="category" value="베이킹"> 🍞 베이킹</label>

                <label><input type="radio" name="category" value="음료/차"> ☕ 음료/차</label>

            </div>

            <hr><br>

            <div class="filter-section">

                <h4>조리시간</h4>

                <label>
                    <input type="checkbox" name="cookTimes" value="10">          
                    10분 이하
                </label>

                <label>
                    <input type="checkbox" name="cookTimes" value="20">  
                    10~20분
                </label>

                <label>
                    <input type="checkbox" name="cookTimes" value="30">   
                    20~30분
                </label>

                <label>
                    <input type="checkbox" name="cookTimes" value="60">       
                    30~60분
                </label>

                <label>
                    <input type="checkbox" name="cookTimes" value="61">
                    60분 이상
                </label>

            </div>

            <button class="filter-btn" type="submit">        
                적용하기</button> 
            </button>

        </form>

    </aside>

    <!-- 오른쪽 -->

    <section class="recipe-area">

        <div class="recipe-header">

            <h2>전체 레시피</h2>
            
            <select class="sort-select"
                    name="sort">

                <option value="latest">
                    최신순
                </option>

                <option value="name">
                    가나다순
                </option>

                <option value="view">
                    조회수순
                </option>

                <option value="like">
                    좋아요순
                </option>

            </select>

        </div>

        <div class="recipe-list">

            <c:forEach items="${recipeList}" var="recipe">
                      

                <div class="recipe-card">

                    <img src="${recipe.thumbnail}">

                    <div class="recipe-info">

                        <div class="recipe-title">
                            ${recipe.title}
                        </div>

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

        </div>

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