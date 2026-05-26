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
                <h1>오늘 뭐 먹지?</h1>
                <span>맛있는 하루의 시작</span>
            </div>
            <div class="search-bar">
                <input type="text" placeholder="재료, 요리명으로 검색해보세요!">
            </div>
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
            <div class="banner-image-side">
                </div>
        </div>

        
    </div>

</body>
</html>