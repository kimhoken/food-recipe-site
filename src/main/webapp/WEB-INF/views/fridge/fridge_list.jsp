<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

{%
    <c:if test="${empty sessionScope.user}">
        <script>
            alert("로그인후 이용해주세요.")
            location.href="/login.do";
        </script>
    </c:if>
%}

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오늘 뭐 먹지? - 냉장고 파먹기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fridge.css">
    <script>
        function deleteItem(fridge_id){
            if(confirm("삭제하시겠습니까?")){
                const url = "/delete_fridge.do";
                fetch(url, {
                    method: "post",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ id: fridge_id })
                })
                .then(res => res.json())
                .then(data => {
                    if(data.result == "success"){
                        alert("삭제되었습니다.");
                        location.reload();
                    }else{
                        alert("삭제 실패...");
                    }
                })
            }
        }

        function modify(fridge_id){
            const quantity = prompt("수량:");
            if(quantity === null) return; // 취소 클릭 시
            
            const url = "/modity.do";
            const data = { firdge_id: fridge_id, quantity: quantity };

            fetch(url, {
                method: "post",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data)
            })
            .then(res => res.json())
            .then(js => {
                if(js.result == "success"){
                    alert("수정되었습니다.");
                    location.reload();
                }else{
                    alert("수정 실패....");
                }
            })
        }

        const reco= ()=>{
            //멤버아이디를 넘겨 레시피 추천 화면으로 이동
            location.href="/fridge_recommend.do?id=" + ${user.member_id};
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
            <div class="search-bar">
                <input type="text" placeholder="재료, 요리명으로 검색해보세요!">
            </div>
            <div class="user-menu">
                <c:if test="${empty user}">
                    <a href="/login.do" class="menu-item" id="login">
                        <span class="menu-icon">
                            <img src="${pageContext.request.contextPath}/images/login.png">
                        </span>
                        <div>로그인</div>
                    </a>
                </c:if>
                <c:if test="${!empty user}">
                    <a href="/logout.do" class="menu-item" id="login">
                        <span class="menu-icon">
                            <img src="${pageContext.request.contextPath}/images/login.png">
                            <p>${user.nickname}님</p>
                        </span>
                        <div>로그아웃</div>
                    </a>
                </c:if>
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
            <li><a href="/main_list.do">홈</a></li>
            <li ><a href="/list.do">레시피</a></li>
            <li>카테고리</li>
            <li>랭킹</li>
            <li>커뮤니티</li>
            <li class="active"><a href="/fridge_list.do">냉장고 추천</a></li>
            <li>이벤트</li>
        </ul> 
    </header>

    <div class="container main-container">
        <div class="fridge-wrapper">
            <div class="fridge-title-area">
                <%-- 로그인시 접속가능한 공간 --%>
                <div class="user-title">${user.nickname}님의 현재 냉장고 재료 </div>
                <button class="add-btn" onClick="location.href='/food_insert.do?id=1'">재료 추가</button>
            </div>

            <div class="fridge-content">
                <div class="fridge-side freezer-side">
                    <div class="side-title">냉동실 </div>
                    <div class="item-grid">
                        <c:forEach var="vo" items="${list}">
                            <c:if test="${vo.freezer eq true}">
                                <div class="ingredient-card">
                                    <span class="ing-name">${vo.ingredient_name}</span>
                                    <span class="ing-qty">${vo.quantity}</span>
                                    
                                    <div class="expire-hover">
                                        <span>유통기한</span>
                                        <strong>${vo.expire_date}</strong>
                                        <div class="card-actions">
                                            <input type="button" value="수정" onClick="modify(${vo.fridge_id})">
                                            <input type="button" value="삭제" onClick="deleteItem(${vo.fridge_id})">
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>

                <div class="divider"></div>

                <div class="fridge-side total-fridge-side">
                    <div class="side-title">냉장실 </div>
                    <div class="item-grid">
                        <c:forEach var="vo" items="${list}">
                            <c:if test="${vo.freezer ne true}">
                                <div class="ingredient-card">
                                    <span class="ing-name">${vo.ingredient_name}</span>
                                    <span class="ing-qty">${vo.quantity}</span>
                                    
                                    <div class="expire-hover">
                                        <span>유통기한</span>
                                        <strong>${vo.expire_date}</strong>
                                        <div class="card-actions">
                                            <input type="button" value="수정" onClick="modify(${vo.fridge_id})">
                                            <input type="button" value="삭제" onClick="deleteItem(${vo.fridge_id})">
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <input type="button" value="레시피 추천" onClick="reco()">
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
                </div>
            </div>
        </div>
        <div class="footer-nav-bar">
            <div class="footer-container">
                <div class="nav-links">
                    <a href="#"><strong>이용약관</strong></a>
                    <a href="#"><strong>개인정보처리방침</strong></a>
                    <span class="partner-mail">광고/제휴 문의: kh@culture.net</span>
                </div>
            </div>
        </div>
    </footer>

</body>
</html>