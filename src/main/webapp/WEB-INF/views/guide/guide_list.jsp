<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <title>오늘 뭐 먹지? - 레시피 공유</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search_bar.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guide.css">
            <link rel="stylesheet" href="/css/chatbot.css" />
            <script src="/js/chatbot.js"></script>

                <script>
                // 키친가이드 들어오면 자동 '전체보기' 
                window.onload = function() {
                    showTab('all');
                };

                function showTab(tabName) {
                
                    document.querySelectorAll(".tab-btn").forEach(function(btn) {
                        btn.classList.remove("active");
                    });
                    let targetBtn = document.getElementById(tabName);
                    if (targetBtn) {
                        targetBtn.classList.add("active");
                    }

                    fetch("${pageContext.request.contextPath}/guide_tab.do?tab=" + tabName, { method: "get" })
                    .then( function(res) { return res.json(); } ) 
                    .then( function(data) {
                        
                        console.log("서버에서 받아온 데이터 목록:", data); // 데이터 잘 왔는지 확인할라고 씀
                        
                        let grid = document.getElementById("guideGrid");
                        grid.innerHTML = ""; 
                        
                        for (let i = 0; i < data.length; i++) {
                        let guide = data[i]; 
                        
                        // 소제목이 null일 때 화면에 'null'이라고 뜨는 걸 방지
                        let subTitle = guide.sub_title ? guide.sub_title : "";                   
                        let imgPath = "${pageContext.request.contextPath}/guide_img/" + guide.image;

                        //해당 guide-grid 클릭하면 guide_id로 상세페이지로 이동
                        let cardHtml = "<div class='guide-card-link' onclick=\"location.href='${pageContext.request.contextPath}/guide_list.do/" + guide.guide_id + "'\">" +
                        "  <div class='guide-card'>" +
                        "    <div class='card-img-box'>" +
                        "      <img src='" + imgPath + "' alt='가이드 이미지'>" +
                        "    </div>" +
                        "    <div class='card-info'>" +
                        "      <p>" + subTitle + "</p>" +
                        "      <h3>" + guide.title + "</h3>" +
                        "    </div>" +
                        "  </div>" +
                        "</div>";
                        grid.innerHTML += cardHtml;
                    }
                    })
                    .catch(function(error) {
                        console.error("데이터 로드 중 에러 발생:", error);
                    });
                }
            </script>

            <style>
                /* 배경 흰색 고정 */
                body.guide-page {
                    background-color: #ffffff !important;
                }
            </style>
        </head>

        <body class="guide-page">
            <header>
                <div class="header-top">
                    <div class="logo">
                        <a href="${pageContext.request.contextPath}/">
                            <img src="${pageContext.request.contextPath}/images/Logo.png" alt="로고" />
                        </a>
                    </div>

                    <%-- 검색창 클릭시 나올 화면 --%>
                        <div class="search-wrapper" style="position: relative;">
                            <form action="${pageContext.request.contextPath}/search_recipe.do" method="post"
                                class="search-bar-form">
                                <div class="search-bar">
                                    <select name="select" id="sel">
                                        <option value="recipe">레시피</option>
                                        <option value="review">후기</option>
                                    </select>
                                    <input type="text" id="mainSearch" name="search" placeholder="재료, 요리명으로 검색해보세요!"
                                        autocomplete="off">
                                    <button type="submit">⌕</button>
                                </div>
                            </form>

                            <div id="searchDropdown" class="search-dropdown">
                                <div class="search-section" id="recent">
                                    <h4>최근 검색어</h4>
                                    <c:if test="${empty currentSearchList}">
                                        <p class="empty-text">최근 검색어가 없습니다.</p>
                                    </c:if>
                                    <c:if test="${!empty currentSearchList}">
                                        <form action="${pageContext.request.contextPath}/search_recipe.do"
                                            method="post">
                                            <c:forEach var="item" items="${currentSearchList}" varStatus="status">
                                                <input type="submit" value="${item}" name="search">
                                            </c:forEach>
                                        </form>
                                    </c:if>
                                </div>

                                <div class="search-section" id="recommend">
                                    <h4>추천 검색어</h4>
                                </div>

                                <div class="search-section">
                                    <h4>급상승 검색어</h4>
                                    <div class="trending-list">
                                        <c:forEach var="vo" items="${searchList}" varStatus="status">
                                            <div class="trending-item">
                                                <!-- 상세보기 만들면 거기에 맞는 상세보기로 바로 이동 -->
                                                <a href="#"><span class="rank-num">${status.index + 1}</span> ${vo}</a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

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
                                    <a href="#" class="menu-item" id="login" onClick="logout(); return false;">
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
                    <li><a href="/recipe_list.do"> 레시피</a></li>
                    <li>랭킹</li>
                    <li><a href="/list.do">커뮤니티</a></li>
                    <li><a href="/fridge_list.do?member_id=${user.member_id}">냉장고 추천</a></li>
                    <li class="active"><a href="/guide_list.do">키친가이드</a></li>
                </ul>
            </header>


            <div class="guide-header-frame">
                <div class="guide-title-box">
                    <h1>KITCHEN GUIDE</h1>
                    <h2>일상이 깊어지는 곳, 당신만의 주방 가이드</h2>
                </div>
            </div>
            &nbsp;

            <div class="guide-container">
                <div class="category-tabs">
                    <button class="tab-btn" id="all" onclick="showTab('all')">전체보기</button>
                    <button class="tab-btn" id="storage" onclick="showTab('storage')">보관법</button>
                    <button class="tab-btn" id="trim" onclick="showTab('trim')">손질법</button>
                    <button class="tab-btn" id="tip" onclick="showTab('tip')">요리꿀팁</button>
                    <button class="tab-btn" id="etc" onclick="showTab('etc')">기타정보</button>
                </div>
            </div>


            <div class="guide-grid" id="guideGrid">

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
                                <p>주소 : 경기도 성남시 분당구 판교로 216길 92, kh타워 22층 2201호( 삼평동, 판교 에이치스퀘어 ) &nbsp;&nbsp; 이메일:
                                    kh@culture.net</p>
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