<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <title>오늘 뭐 먹지? - 맛있는 하루의 시작</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/category.css">
    <link rel="stylesheet" href="/css/chatbot.css" />

    <script src="/js/chatbot.js"></script>
    <script src="${pageContext.request.contextPath}/js/alarm.js"></script>
    <script>
        /* ============================ 여기부터 카테고리 모달창 관련 함수들 ============================ */
        // 선택한 카테고리들 열기
        function selectCategory(category){
            //location.href = "/recipe/list?category=" + category;
        }

        // 전체보기 모달 열기 (열릴 때 자동으로 첫 번째 카테고리 '상황별추천')
        function openModal(){
            document.getElementById("categoryModal").style.display = 'flex';
            sideTabCategory('상황별추천'); 
        }

        // 전체보기 모달 닫기
        function closeModal(){
            document.getElementById("categoryModal").style.display = 'none';
        }

        // 메뉴창 바깥 영역 클릭 시 닫히게 하기 
        function closeModalOnOutside(event) {
            const modal = document.getElementById("categoryModal");
            if (event.target === modal) {
                closeModal();
            }
        }
    

        //왼쪽 사이드바 클릭 감지
        function handleSidebarClick(event) {
            const item = event.target.closest('.sidebar-item'); // item = 클릭된 <div> 태그 자체
            if (!item) return; // sidebar-item을 클릭한 게 아니면 무시
            
            // 카테고리명(data-cat 값) 전달
            sideTabCategory(item.dataset.cat); 
        }
        

        // 카테고리 변경 및 스타일 적용 함수
        function sideTabCategory(category) { 
            // 1. 모든 사이드바 메뉴에서 active 다 지우기
            document.querySelectorAll('.modal-sidebar .sidebar-item').forEach(el => el.classList.remove('active'));
            
            // 2. 현재 누른 카테고리 메뉴에만 하얀배경(active) 켜기
            const activeTab = document.querySelector(`.sidebar-item[data-cat="${category}"]`);
            if (activeTab) activeTab.classList.add('active');

            fetch('/category.do?category=' + category)
                .then(res => res.json())
                .then(data => {
                    let list = data.catList;
                    let html = ""; 

                    for (let i = 0; i < list.length-4 ; i+=4) {
                        html += "<div class='menu-group'>";
                        // 소분류 타이틀 (예: 국/찌개, 볶음/조림 등)
                        html += "<h3>" + list[i].subCategoryName + "</h3>"; 
                        html += "<ul>";
                        
                        html += "<li><a href='#'>" + list[i].foodName + "</a></li>";
                        html += "<li><a href='#'>" + list[i+1].foodName + "</a></li>";
                        html += "<li><a href='#'>" + list[i+2].foodName + "</a></li>";
                        html += "<li><a href='#'>" + list[i+3].foodName + "</a></li>";
                        
                        html += "<li><a href='#' class='more-btn'>더보기 &gt;</a></li>";
                        html += "</ul>";
                        html += "</div>";
                    }

                    document.getElementById("modalCategoryBody").innerHTML = html;
                    
                    // 우측 배너 영역 
                    document.querySelector(".modal-banner-side").innerHTML = 
                        "<div class='banner-img-box'>" +
                        "    <img src='/images/main.png' alt='추천 요리' style='width:100%; height:100%; object-fit:cover; border-radius:12px;'> gap" +
                        "</div>" +
                        "<div class='banner-text-box'>" +
                        "    <h3>오늘 뭐 먹지?</h3>" +
                        "    <p>다양한 레시피로<br>매일 새로운 한 끼를 만나보세요.</p>" +
                        "    <button type='button' class='banner-go-btn' onclick='location.href=\"/recipe_list.do\"'>레시피 둘러보기 &gt;</button>" +
                        "</div>";
                })
                .catch(err => {
                    console.error("데이터를 가져오는 도중 에러 발생:", err);

                    document.getElementById("modalCategoryBody").innerHTML = "<div style='grid-column: 1/-1; text-align:center; padding:40px; color:#999;'>카테고리 데이터를 불러오지 못했습니다.</div>";
                });
        }
             document.querySelector('.modal-sidebar')?.addEventListener('click', handleSidebarClick);


        /* ============================ 여기까지 카테고리 모달창 관련 함수들 ============================ */
        
        const applicationServerKey = "BDbjVtJHaSNMMaypEcx2MeXmHvfoWISYWzTCj6Ycc7SoaucH53CzsDGAen6O4ENI9eZMmnilVr9r0F-q3OSbsiM";
        const logout = ()=>{
            if(confirm("로그아웃 하시겠습니까?")){ 
                fetch("/logout.do", {
                    method: "post",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        id: "${user.member_id}"
                    })
                })
                    .then(res => res.json())
                    .then(data => {
                        if (data.result == "success") {
                            alert("로그아웃 되었습니다.")
                            location.href = "/main_list.do";
                        }
                    })
            }
        }
        
        // base64 URL 소스를 Uint8Array로 변환하는 함수 (푸시 서버 인증용 필수 함수)
        function urlB64ToUint8Array(base64String) {
            const padding = '='.repeat((4 - base64String.length % 4) % 4);
            const base64 = (base64String + padding).replace(/\-/g, '+').replace(/_/g, '/');
            const rawData = window.atob(base64);
            const outputArray = new Uint8Array(rawData.length);
            for (let i = 0; i < rawData.length; ++i) {
                outputArray[i] = rawData.charCodeAt(i);
            }
            return outputArray;
        }

        const member_id = '${sessionScope.user.member_id}';
        // 2. 브라우저가 서비스 워커와 푸시를 지원하는지 확인 후 등록
        if ('serviceWorker' in navigator && 'PushManager' in window && member_id != null ) {
            window.addEventListener('load', function() {
                navigator.serviceWorker.register('/js/alarm.js')
                .then(function(registration) {
                    console.log('서비스 워커 등록 성공:', registration);
                    
                    // 등록 성공 후 사용자에게 권한 요청 및 구독 진행
                    requestNotificationPermission(registration);
                })
                .catch(function(error) {
                    console.error('서비스 워커 등록 실패:', error);
                });
            });
        }

        // 3. 알림 권한 요청 및 구독 처리
        function requestNotificationPermission(registration) {
            Notification.requestPermission().then(function(permission) {
                if (permission === 'granted') {
                    console.log('알림 권한 허용됨');
                    subscribeUser(registration);
                } else {
                    console.warn('알림 권한 거부됨');
                }
            });
        }

        // 4. 푸시 서버(FCM 등)로부터 구독 정보 받아오기
        function subscribeUser(registration) {
            const subscribeOptions = {
                userVisibleOnly: true,
                applicationServerKey: urlB64ToUint8Array(applicationServerKey)
            };

            registration.pushManager.subscribe(subscribeOptions)
            .then(function(subscription) {
                console.log('푸시 구독 성공:', JSON.stringify(subscription));
                
                // 5. 이 subscription 객체를 DB에 저장하기 위해 백엔드로 전송해야 해!
                sendSubscriptionToServer(subscription);
            })
            .catch(function(error) {
                console.error('푸시 구독 실패:', error);
            });
        }

        // 6. 백엔드(Spring Boot)로 구독 정보 전송 (Ajax)
        function sendSubscriptionToServer(subscription) {
            // 여기에 Fetch API나 jQuery Ajax를 써서 Spring Boot 컨트롤러로 던져주면 돼.
            fetch('/api/push/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(subscription)
            })
            .then(res => {
                if(res.ok) console.log('서버에 구독 정보 저장 완료');
            })
            .catch(err => console.error('서버 전송 실패:', err));
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
    </header>
    
    <!-- 메인 배너 -->
    <div class="main-banner-container">
        <div class="max-container">
            <div class="banner-image-side">
                <img src="${pageContext.request.contextPath}/images/main.png" alt="메인 배너 이미지">
            </div>        
        </div>
    </div>

    <div class="container main-page">
        <div class="category-list">
            <button type="button" class="category-item" data-category="korean" onclick="selectCategory('korean')">
                <div class="category-icon">🍚</div>한식
            </button>
            <button type="button" class="category-item" data-category="western" onclick="selectCategory('western')">
                <div class="category-icon">🍝</div>양식
            </button>
            <button type="button" class="category-item" data-category="chinese" onclick="selectCategory('chinese')">
                <div class="category-icon">🍳</div>중식
            </button>
            <button type="button" class="category-item" data-category="japanese" onclick="selectCategory('japanese')">
                <div class="category-icon">🍣</div>일식
            </button>
            <button type="button" class="category-item" data-category="asian" onclick="selectCategory('asian')">
                <div class="category-icon">🌏</div>아시안 
            </button>
            <button type="button" class="category-item" data-category="diet" onclick="selectCategory('diet')">
                <div class="category-icon">🥗</div>다이어트
            </button>
            <button type="button" class="category-item" data-category="easy" onclick="selectCategory('easy')">
                <div class="category-icon">⏱️</div>초간단요리
            </button>
            <button type="button" class="category-item" data-category="dessert" onclick="selectCategory('dessert')">
                <div class="category-icon">🍰</div>디저트
            </button>
            <button type="button" class="category-item" data-category="baking" onclick="selectCategory('baking')">
                <div class="category-icon">🍞</div>베이킹
            </button>

            <button type="button" class="category-item" id="btnAllCategory" onclick="openModal()">
                <div class="category-icon">☰</div>전체보기
            </button>
        </div>
    </div>

    <div class="container main-page">
        <div class="section-title">지금 인기있는 레시피🔥</div>
        <div class="recipe-grid">
        <%--
            <c:forEach var="recipe" items=${view_recipes}>
                <div class="recipe-card">
                    <a href="/recipe_detail.do?id=${recipe.recipe_id}">
                        <div class="recipe-img"><img src="/images/${recipe.image}"/></div>
                        <div class="rank-badge">${recipe.rank}</div>
                        <div class="recipe-info">
                            <div class="recipe-name">${recipe.title}</div>
                            <div class="recipe-author">👤 ${recipe.nickname}</div>
                            <div class="recipe-meta"><span class="star-rating">★ 4.8</span><span>조회수 <fmt:formatNumber value="${recipe.view_count}"/> </span></div>
                        </div>
                    </a>
                </div> 
            </c:forEach>
            --%>
            <%-- 위에 완성시 밑에 코드 삭제  --%>
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
            <%-- ------------------------- --%>
        </div>
    </div>

    <div class="container main-page mid-sections">
        <div class="mid-box refrigerator-box">
            <div>
                <br/>
                <h3>냉장고 재료로<br>레시피 추천받기</h3>
                <p>집에 있는 재료를 선택하면<br>만들 수 있는 요리를 추천해드려요!</p>
            </div>
            <button class="ref-btn" onClick="location.href='/fridge_list.do?member_id=${sessionScope.user.member_id}'">재료 선택하기 &rarr;</button>
        </div>

        <div class="mid-box">
            <%-- 레시피중에 랜덤으로 뜨게하기 binding은 today로 --%>
            <h3 class="box-title">오늘의 추천 레시피</h3>
            <div class="today-main">
                <div class="today-main-img"></div>
                <div class="today-main-info">
                    <h4>오므라이스</h4>
                    <p>부드러운 계란과 새콤한 소스의 완벽한 조화!</p>
                    <span class="author">👤 요리마스터</span>
                </div>
            </div>  

            <%-- 
            <h3 class="box-title">오늘의 추천 레시피</h3>
            <div class="today-main">
                <div class="today-main-img"> <img src="/images/${today.image}"/> </div> 
                <div class="today-main-info">
                    <h4>${today.title}</h4> 
                    <p>${today.content}</p> 
                    <span class="author">👤 ${today.nickname}</span>
                </div>
            </div>   --%>

            <%-- 이미지 작게 5개 나오는 자라 --%>
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
            <%-- 링크 누르면 최신 레시피 더 보여주는곳으로 이동 --%>
            <a href="#" class="more-btn">더보기 &gt;</a>
        </div>
        <%-- 등록일자 기준으로 조회 --%>
        <%-- 
            <c:forEach var="recipe" items="${reg_recipes}" >
                <div class="recipe-card">
                <div class="recipe-img"><img src="/images/${recipe.image}"/> </div>
                <div class="recipe-info">
                    <div class="recipe-name">${recipe.title}</div>
                    <div class="recipe-author">👤 ${recipe.nickname}</div>
                    <div class="recipe-meta"><span class="star-rating">★ 4.7</span><span>조회수 <fmt:formatNumber value="${recipe.view_count}"/></span></div>
                </div>
            </div>
            </c:forEach>
        --%>

        <%-- 위에 완성시 밑에 코드 삭제  --%>
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
        <%-- -------------------------- --%>
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

    <!-- 메인배너 밑 카테고리 중 전체보기 클릭 시 보여질 블럭 -->
    <div id="categoryModal" class="modal-overlay" onclick="closeModalOnOutside(event)">
        <div class="modal-content">
            <button type="button" class="modal-close-btn" onclick="closeModal()">×</button>
            
            <div class="modal-body">
                <div class="modal-sidebar" onclick="handleSidebarClick(event)">
                    <div class="sidebar-item active" data-cat="상황별추천">⭐ 상황별 추천</div>
                    <div class="sidebar-item" data-cat="한식">🍚 한식</div>
                    <div class="sidebar-item" data-cat="양식">🍝 양식</div>
                    <div class="sidebar-item" data-cat="중식">🍳 중식</div>
                    <div class="sidebar-item" data-cat="일식">🍣 일식</div>
                    <div class="sidebar-item" data-cat="아시안">🌏 아시안</div>
                    <div class="sidebar-item" data-cat="건강식/다이어트">🌿 건강식/다이어트</div>
                    <div class="sidebar-item" data-cat="초간단요리">⏱️ 초간단요리</div>
                    <div class="sidebar-item" data-cat="디저트">🍰 디저트</div>
                    <div class="sidebar-item" data-cat="베이킹">🍞 베이킹</div>
                    <div class="sidebar-item" data-cat="음료/차">☕ 음료/차</div>
                </div>
                
                <div class="modal-main">
                    <div id="modalCategoryBody" class="category-grid-wrapper"></div>
                </div>
                
                <div class="modal-banner-side">

                </div>
            </div>

        </div>
    </div>

</body>
</html>