<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>오늘 뭐 먹지? - 맛있는 하루의 시작</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

    <header>
        <div class="header-top">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/images/Logo.png" alt="로고">
                </a>
            </div>
            
            <form action="${pageContext.request.contextPath}/search" method="get" class="search-bar-form">
                <div class="search-bar">
                    <input type="text" id="mainSearch" name="keyword" placeholder="재료, 요리명으로 검색해보세요!">
                </div>
            </form>
            
            <div class="user-menu">
                <a href="${pageContext.request.contextPath}/login" class="menu-item">
                    <span class="menu-icon">
                        <img src="${pageContext.request.contextPath}/images/login.png">
                    </span>
                    <div>로그인</div>
                </a>
                
                <a href="${pageContext.request.contextPath}/join" class="menu-item">
                    <span class="menu-icon">
                        <img src="${pageContext.request.contextPath}/images/login.png">
                    </span>
                    <div>회원가입</div>
                </a>
                
                <a href="${pageContext.request.contextPath}/mypage" class="menu-item">
                    <span class="menu-icon">
                        <img src="${pageContext.request.contextPath}/images/mypage.png">
                    </span>
                    <div>마이페이지</div>
                </a>
            </div>
        </div>
        <ul class="nav-bar">
            <li class="active">홈</li>
            <li>레시피</li>
            <li>카테고리</li>
            <li>랭킹</li>
            <li>커뮤니티</li>
            <li>냉장고 추천</li>
            <li>이벤트</li>
        </ul>
    </header>

    <div class="main-banner-container">
        <div class="max-container">
            <div class="banner-image-side"></div>        
        </div>
    </div>

    <div class="container main-page">
        <div class="category-list">
            <div class="category-item" data-category="korean"><div class="category-icon">🍚</div>한식</div>
            <div class="category-item" data-category="western"><div class="category-icon">🍝</div>양식</div>
            <div class="category-item" data-category="japanese"><div class="category-icon">🍣</div>일식</div>
            <div class="category-item" data-category="chinese"><div class="category-icon">🍳</div>중식</div>
            <div class="category-item" data-category="dessert"><div class="category-icon">🍰</div>디저트</div>
            <div class="category-item" data-category="single"><div class="category-icon">🥗</div>자취요리</div>
            <div class="category-item" data-category="diet"><div class="category-icon">💪</div>다이어트</div>
            <div class="category-item" data-category="easy"><div class="category-icon">⏱️</div>간단요리</div>
            <div class="category-item" data-category="baking"><div class="category-icon">🍞</div>베이킹</div>
            <div class="category-item" data-category="all" id="btnAllCategory">
                <div class="category-icon">⣿</div>전체보기
            </div>
      
        </div>
    </div>

    <div class="container main-page">
        <div class="section-title">지금 인기있는 레시피🔥</div>
        <div class="recipe-grid">
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="rank-badge">1</div>
                <div class="recipe-info">
                    <div class="recipe-name">크림 새우 파스타</div>
                    <div class="recipe-author">👤 요리하는 주방장</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.8</span><span>조회수 12,345</span></div>
                </div>
            </div>
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="rank-badge">2</div>
                <div class="recipe-info">
                    <div class="recipe-name">돼지고기 Kimchi찌개</div>
                    <div class="recipe-author">👤 오늘도 요리해</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.9</span><span>조회수 11,234</span></div>
                </div>
            </div>
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="rank-badge">3</div>
                <div class="recipe-info">
                    <div class="recipe-name">치즈 계란말이</div>
                    <div class="recipe-author">👤 간단요리왕</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.7</span><span>조회수 9,876</span></div>
                </div>
            </div>
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="rank-badge">4</div>
                <div class="recipe-info">
                    <div class="recipe-name">닭가슴살 샐러드</div>
                    <div class="recipe-author">👤 나는야 코코맘</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.8</span><span>조회수 8,765</span></div>
                </div>
            </div>
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="rank-badge">5</div>
                <div class="recipe-info">
                    <div class="recipe-name">스팸 마요 덮밥</div>
                    <div class="recipe-author">👤 자취요리러</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.6</span><span>조회수 7,654</span></div>
                </div>
            </div>
        </div>
    </div>

    <div class="container main-page mid-sections">
        <div class="mid-box refrigerator-box">
            <div>
                <br/>
                <h3>냉장고 재료로<br>레시피 추천받기</h3>
                <p>집에 있는 재료를 선택하면<br>만들 수 있는 요리를 추천해드려요!</p>
            </div>
            <button class="ref-btn" id="btnRecipe">재료 선택하기 &rarr;</button>
        </div>
        
        <div class="mid-box">
            <h3 class="box-title">오늘의 추천 레시피</h3>
            <div class="today-main">
                <div class="today-main-img"></div>
                <div class="today-main-info">
                    <h4>오므라이스</h4>
                    <p>부드러운 계란과 새콤한 소스의 완벽한 조화!</p>
                    <span class="author">👤 요리마스터</span>
                </div>
            </div>
            <div class="today-sub-list">
                <div class="today-sub-thumb"></div>
                <div class="today-sub-thumb"></div>
                <div class="today-sub-thumb" ></div>
                <div class="today-sub-thumb"></div>
                <div class="today-sub-thumb"></div>
            </div>
        </div>
    </div>

    <div class="container main-page">
        <div class="section-title-space">
            <div class="section-title">최신 레시피 후기 </div>
            <a href="#" class="more-btn">더보기 &gt;</a>
        </div>
        <div class="recipe-grid">
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="recipe-info">
                    <div class="recipe-name">참치 마요 유부초밥</div>
                    <div class="recipe-author">👤 초밥왕</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.7</span><span>조회수 589</span></div>
                </div>
            </div>
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="recipe-info">
                    <div class="recipe-name">우삼겹 숙주볶음</div>
                    <div class="recipe-author">👤 맛있는 하루</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.8</span><span>조회수 678</span></div>
                </div>
            </div>
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="recipe-info">
                    <div class="recipe-name">바질 페스토 파스타</div>
                    <div class="recipe-author">👤 파스타러버</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.6</span><span>조회수 512</span></div>
                </div>
            </div>
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="recipe-info">
                    <div class="recipe-name">단호박 수프</div>
                    <div class="recipe-author">👤 스프요리사</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.9</span><span>조회수 423</span></div>
                </div>
            </div>
            <div class="recipe-card">
                <div class="recipe-img"></div>
                <div class="recipe-info">
                    <div class="recipe-name">연어 스테이크</div>
                    <div class="recipe-author">👤 연어좋아</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.8</span><span>조회수 701</span></div>
                </div>
            </div>
        </div>
    </div>


    <div class="info-bar">
        <div class="info-item">🍳 <span>쉽고 간단한 레시피<br><small>누구나 따라할 수 있어요</small></span></div>
        <div class="info-item">🍱 <span>다양한 카테고리<br><small>원하는 메뉴를 쉽게 찾아보세요</small></span></div>
        <div class="info-item">🥕 <span>냉장고 재료 활용<br><small>남은 재료로 알뜰하게 요리해요</small></span></div>
        <div class="info-item">💬 <span>요리로 소통해요<br><small>후기와 팁을 공유해보세요</small></span></div>
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
                    <a href="#">공지사항</a>
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
    <button class="chatbot-fixed-btn" id="chatbotBtn">
        <span>?</span>
    </button>

</body>
</html>