<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/common/navibar.jsp">
    <jsp:param name="currentMenu" value="home" />
</jsp:include>
<!DOCTYPE html>
<html>
    <head>
        <title>오늘 뭐 먹지? - 맛있는 하루의 시작</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/category.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search_bar.css">
        <link rel="stylesheet" href="/css/chatbot.css" />

        <script src="/js/chatbot.js"></script>
        <script src="${pageContext.request.contextPath}/js/alarm.js"></script>
        <script>
        /* ============================ 여기부터 카테고리 모달창 관련 함수들 ============================ */
            // 선택한 카테고리들 열기
            function selectCategory(category){
                document.getElementById("categoryModal").style.display = 'flex';
                sideTabCategory(category);
            }
            
            // 전체보기 모달 열기 (열릴 때 자동으로 첫 번째 카테고리 '상황별추천')
            function openModal(){
                document.getElementById("categoryModal").style.display = 'flex';
                sideTabCategory('상황별추천');
            }
            
            // 전체보기 모달 닫기
            function closeModal(){
                document.getElementById("categoryModal").style.display = 'none';
                document.getElementById("category-detail").style.display = 'none';
            }
            
            // 메뉴창 바깥 영역 클릭 시 닫히게 하기
            function closeModalOnOutside(event) {
                const modal = document.getElementById("categoryModal");
                if (event.target === modal) {
                    closeModal();
                }
            }
            
            //왼쪽 중분류 사이드바 클릭 감지
            function handleSidebarClick(event) {
                document.getElementById("category-detail").style.display = 'none';
                document.getElementById("categoryModal").style.display = 'flex';
                
                const item = event.target.closest('.sidebar-item'); // item = 클릭된 <div> 태그 자체
                if (!item) return; // sidebar-item을 클릭한 게 아니면 무시
                
                // 카테고리명(data-cat 값) 전달
                sideTabCategory(item.dataset.cat);
            }
            
            function handleSubSidebarClick(event) {
                document.getElementById("category-detail").style.display = 'flex';
                
                const item = event.target.closest('.sidebar-item'); // item = 클릭된 <div> 태그 자체
                if (!item) return; // sidebar-item을 클릭한 게 아니면 무시
                
                // 카테고리명(data-cat 값) 전달
                openDetailCategory(item.dataset.cat);
            }
            
            let ctg = "none";
            
            // 카테고리 변경 및 스타일 적용 함수
            function sideTabCategory(category) {
                const sidebarItems = document.querySelectorAll('.modal-sidebar > div');
                ctg = category;
                sidebarItems.forEach(item => {
                    if(item.dataset.cat === category) {
                        item.className = "sidebar-item-active"; // 누른 것만 활성화
                    } else {
                        item.className = "sidebar-item"; // 나머지는 기본 스타일
                    }
                });
                
                fetch('/category.do?category=' + category)
                .then(res => res.json())
                .then(data => {
                    let html = "";
                    
                    for(const[subCategoryName, foodList] of Object.entries(data)){
                        html += "<div class='menu-group'>";
                        html += "<h3>" + subCategoryName + "</h3>";
                        html += "<ul>";
                        
                        let limit = Math.min(foodList.length, 4);
                        
                        for(let i=0 ; i<limit ; i++){
                            html += "<li><a href='#'>" + foodList[i] + "</a></li>"
                        }
                        html += "<li><input type='button' value='더보기 -&gt' onClick='openDetailCategory( \"" + subCategoryName + "\")'></li>";
                        
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
            
            const openDetailCategory = (subName) => {
                document.getElementById("categoryModal").style.display = 'none';
                document.getElementById("category-detail").style.display = "flex";
                
                const sidebarItems = document.querySelectorAll('.modal-sidebar > div');
                
                sidebarItems.forEach(item => {
                    if(item.dataset.cat === ctg) {
                        item.className = "sidebar-item-active"; // 누른 것만 활성화
                    } else {
                        item.className = "sidebar-item"; // 나머지는 기본 스타일
                    }
                });
                
                fetch("/category.do?category=" + ctg)
                .then(res => res.json())
                .then(data => {
                    let html = "";
                    let mainHtml = "<ul class='main-list'>";
                    for(const[subCategoryName, foodList] of Object.entries(data)){
                        if(subName == subCategoryName){
                            html += "<div class='sidebar-item-active' data-cat='" + subCategoryName + "'>";
                        }else{
                            html += "<div class='sidebar-item' data-cat='" + subCategoryName + "'>";
                        }
                        
                        html += subCategoryName;
                        html += "</div>";
                        
                        for(let i=0 ; i<foodList.length ; i++){
                            if(subName == subCategoryName){
                                mainHtml += "<li><a href='#'>" + foodList[i] + "</a></li>"
                            }
                        }
                        
                    }
                    mainHtml += "</ul>";
                    
                    document.getElementById("modal-sidebar2").innerHTML = html;
                    document.getElementById("modal-main-banner").innerHTML = mainHtml;
                    
                })
                .catch(err => {
                    console.log("Error: " + err);
                })
            }
            
        /* ============================ 여기까지 카테고리 모달창 관련 함수들 ============================ */
            const applicationServerKey = "BDbjVtJHaSNMMaypEcx2MeXmHvfoWISYWzTCj6Ycc7SoaucH53CzsDGAen6O4ENI9eZMmnilVr9r0F-q3OSbsiM";
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
            if ('serviceWorker' in navigator && 'PushManager' in window && member_id != null && member_id != '') {
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
        /* ============================ 여기까지 알림 관련 함수들 ============================ */
        </script>
    </head>
    <body>

        <!-- 메인 배너 -->
        <div class="main-banner-container">
            <div class="max-container">
                <div class="banner-image-side">
                    <a href="${pageContext.request.contextPath}/fridge_list.do?member_id=${user.member_id}">
                        <img src="${pageContext.request.contextPath}/images/main.png" alt="메인 배너 이미지">
                    </a>
                </div>
            </div>
        </div>

        <div class="container main-page">
            <div class="category-list">
                <button type="button" class="category-item" data-category="korean" onclick="selectCategory('한식')">
                    <div class="category-icon">🍚</div>한식
                </button>
                <button type="button" class="category-item" data-category="western" onclick="selectCategory('양식')">
                    <div class="category-icon">🍝</div>양식
                </button>
                <button type="button" class="category-item" data-category="chinese" onclick="selectCategory('중식')">
                    <div class="category-icon">🍳</div>중식
                </button>
                <button type="button" class="category-item" data-category="japanese" onclick="selectCategory('일식')">
                    <div class="category-icon">🍣</div>일식
                </button>
                <button type="button" class="category-item" data-category="asian" onclick="selectCategory('아시안')">
                    <div class="category-icon">🌏</div>아시안
                </button>
                <button type="button" class="category-item" data-category="diet" onclick="selectCategory('건강식/다이어트')">
                    <div class="category-icon">🌿</div>건강식/다이어트
                </button>
                <button type="button" class="category-item" data-category="easy" onclick="selectCategory('초간단요리')">
                    <div class="category-icon">⏱️</div>초간단요리
                </button>
                <button type="button" class="category-item" data-category="dessert" onclick="selectCategory('디저트')">
                    <div class="category-icon">🍰</div>디저트
                </button>
                <button type="button" class="category-item" data-category="baking" onclick="selectCategory('베이킹')">
                    <div class="category-icon">🍞</div>베이킹
                </button>
                <button type="button" class="category-item" id="btnAllCategory" onclick="openModal()">
                    <div class="category-icon">☰</div>전체보기
                </button>
            </div>
        </div>

        <div class="container main-page">
            <div class="section-title">조회수 TOP 5 레시피</div>
                <div class="recipe-grid">
                    <c:forEach var="recipe" items="${view_recipes}" varStatus="status">
                        <div class="recipe-card">
                            <a href="/recipe_detail.do?recipeId=${recipe.recipe_id}">
                                <div class="recipe-img">
                                    <img src="${pageContext.request.contextPath}/images/${recipe.thumbnail}"/>
                                </div>
                                <div class="rank-badge">${status.index + 1}</div>
                                <div class="recipe-info">
                                    <div class="recipe-name">${recipe.title}</div>
                                    <div class="recipe-author">👤 ${recipe.nickname}</div>
                                    <div class="recipe-meta"><span class="star-rating">★ 4.8</span><span>조회수 <fmt:formatNumber value="${recipe.view_count}"/> </span></div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
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
                <button class="ref-btn" onClick="location.href='/fridge_list.do?member_id=${sessionScope.user.member_id}'">재료 선택하기 &rarr;</button>
            </div>

            <div class="mid-box">
                <h3 class="box-title">오늘의 추천 레시피</h3>
                <div class="today-main">
                    <div class="today-main-img"><%-- 이미지 들어갈 자리 --%></div>
                    <div class="today-main-info">
                        <h4>${today.title}</h4>
                        <p>이런 메뉴는 어떠신가요?</p>
                        <span class="author">👤 ${today.nickname}</span>
                    </div>
                </div>

                <!-- 이미지 작게 5개 나오는 자라 -->
                <div class="today-sub-list">
                    <div class="today-sub-thumb"></div>
                    <div class="today-sub-thumb"></div>
                    <div class="today-sub-thumb"></div>
                    <div class="today-sub-thumb"></div>
                    <div class="today-sub-thumb"></div>
                </div>
            </div>
        </div>

        <div class="container main-page">
            <div class="section-title-space">
                <div class="section-title">최근 레시피 후기 </div>
                <!-- 링크 누르면 최근 등록한 레시피 더 보여주는곳으로 이동 -->
                <a href="${pageContext.request.contextPath}/list.do?tab=review" class="more-btn">더보기 &gt;</a>
            </div>
            <div class="recipe-grid">
                <!-- 등록일자 기준으로 조회 -->
                <c:forEach var="recipe" items="${reg_recipes}" >
                    <div class="recipe-card">
                        <div class="recipe-img">
                            <img src="/images/${recipe.thumbnail}"/>
                        </div>
                        <div class="recipe-info">
                            <div class="recipe-name">${recipe.title}</div>
                            <div class="recipe-author">👤 ${recipe.nickname}</div>
                            <div class="recipe-meta"><span class="star-rating">★ 4.7</span><span>조회수 <fmt:formatNumber value="${recipe.view_count}"/></span></div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <%-- <div class="info-bar">
            <div class="info-item">🍳 <span>쉽고 간단한 레시피<br><small>누구나 따라할 수 있어요</small></span></div>
            <div class="info-item">🍱 <span>다양한 카테고리<br><small>원하는 메뉴를 쉽게 찾아보세요</small></span></div>
            <div class="info-item">🥕 <span>냉장고 재료 활용<br><small>남은 재료로 알뜰하게 요리해요</small></span></div>
            <div class="info-item">💬 <span>요리로 소통해요<br><small>후기와 팁을 공유해보세요</small></span></div>
        </div> --%>

        <!-- footer 회사 정보 jsp 파일 include -->
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

        <!-- 챗봇 -->
        <jsp:include page="/WEB-INF/views/chatbot/chatbot_main.jsp" />

        <!-- 메인배너 밑 카테고리 중 전체보기 클릭 시 보여질 블럭 -->
        <div id="categoryModal" class="modal-overlay" onclick="closeModalOnOutside(event)">
            <div class="modal-content">
                <button type="button" class="modal-close-btn" onclick="closeModal()">×</button>

                <div class="modal-body">
                    <div class="modal-sidebar" onclick="handleSidebarClick(event)">
                        <div class="sidebar-item-active" data-cat="상황별추천" id="1">⭐ 상황별 추천</div>
                        <div class="sidebar-item" data-cat="한식" id="2">🍚 한식</div>
                        <div class="sidebar-item" data-cat="양식" id="3">🍝 양식</div>
                        <div class="sidebar-item" data-cat="중식" id="4">🍳 중식</div>
                        <div class="sidebar-item" data-cat="일식" id="5">🍣 일식</div>
                        <div class="sidebar-item" data-cat="아시안" id="6">🌏 아시안</div>
                        <div class="sidebar-item" data-cat="건강식/다이어트" id="7">🌿 건강식/다이어트</div>
                        <div class="sidebar-item" data-cat="초간단요리" id="8">⏱️ 초간단요리</div>
                        <div class="sidebar-item" data-cat="디저트" id="9">🍰 디저트</div>
                        <div class="sidebar-item" data-cat="베이킹" id="10">🍞 베이킹</div>
                        <div class="sidebar-item" data-cat="음료/차" id="11">☕ 음료/차</div>
                    </div>

                    <div class="modal-main">
                        <div id="modalCategoryBody" class="category-grid-wrapper"></div>
                    </div>

                    <div class="modal-banner-side">
                    </div>
                </div>
            </div>
        </div>

        <!-- 카테고리에서 상세보기로 보여줄 블럭 -->
        <div class="modal-overlay" id="category-detail">
            <div class="modal-content">
                <button type="button" class="modal-close-btn" onclick="closeModal()">×</button>

                <div class="modal-body">
                    <div class="modal-sidebar" onclick="handleSidebarClick(event)">
                        <div class="sidebar-item" data-cat="상황별추천" id="1">⭐ 상황별 추천</div>
                        <div class="sidebar-item" data-cat="한식" id="2">🍚 한식</div>
                        <div class="sidebar-item" data-cat="양식" id="3">🍝 양식</div>
                        <div class="sidebar-item" data-cat="중식" id="4">🍳 중식</div>
                        <div class="sidebar-item" data-cat="일식" id="5">🍣 일식</div>
                        <div class="sidebar-item" data-cat="아시안" id="6">🌏 아시안</div>
                        <div class="sidebar-item" data-cat="건강식/다이어트" id="7">🌿 건강식/다이어트</div>
                        <div class="sidebar-item" data-cat="초간단요리" id="8">⏱️ 초간단요리</div>
                        <div class="sidebar-item" data-cat="디저트" id="9">🍰 디저트</div>
                        <div class="sidebar-item" data-cat="베이킹" id="10">🍞 베이킹</div>
                        <div class="sidebar-item" data-cat="음료/차" id="11">☕ 음료/차</div>
                    </div>

                    <div class="modal-sidebar2" id="modal-sidebar2" onClick="handleSubSidebarClick(event)">
                        <!-- 여기에서 중분류만 보여줌 -->

                    </div>

                    <div class="modal-main-banner" id="modal-main-banner">
                        <!-- 여기에 음식이름 전부 보여주기 -->
                    </div>

                    <div class="modal-banner-side">
                        <div class='banner-img-box'>
                            <img src='/images/main.png' alt='추천 요리' style='width:100%; height:100%; object-fit:cover; border-radius:12px;'>gap
                        </div>
                        <div class='banner-text-box'>
                            <h3>오늘 뭐 먹지?</h3>
                            <p>다양한 레시피로<br>매일 새로운 한 끼를 만나보세요.</p>
                            <button type='button' class='banner-go-btn' onclick='location.href="/recipe_list.do"'>레시피 둘러보기 &gt;</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>