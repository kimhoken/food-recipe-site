<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

    <%-- 레시피에 접속시 class="active"를 레시피 li에 적용하게 전부 변경 --%>
    <ul class="nav-bar">
        <li>홈</li>
        <li>레시피</li>
        <li>카테고리</li>
        <li>랭킹</li>
        <li>커뮤니티</li>
        <li>
            <a href="/fridge_list.do">냉장고 추천</a>
        </li>
        <li>이벤트</li>
    </ul>
</header>
