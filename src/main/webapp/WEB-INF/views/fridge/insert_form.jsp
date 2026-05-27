<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오늘 뭐 먹지? - 재료 등록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fridge_form.css">
    <script>
        const send = (f) => {
            const ingredient_name = f.ingredient_name.value;
            const quantity = f.quantity.value;
            const expire_date = f.expire_date.value;
            let freezer = f.freezer.value;
            const id = f.id.value;
            
            if(!ingredient_name.trim()){
                alert("재료이름은 필수입력사항입니다.");
                return;
            }
            if(!quantity.trim()){
                alert("수량을 입력해주세요");
                return;
            }
            if(expire_date == ''){
                alert("유통기한을 입력해주세요.");
                return;
            }
            
            freezer = (freezer === 'true');
            
            const url = "/food_insert.do";
            const data = {
                id: id,
                ingredient_name: ingredient_name,
                quantity: quantity,
                expire_date: expire_date,
                freezer: freezer
            };
            
            fetch(url, {
                method: "post",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data)
            })
            .then(res => res.json())
            .then(data => {
                if(data.res == "success"){
                    alert("등록 성공");
                    location.href="/fridge_list.do";
                }else{
                    alert("등록 실패");
                }
            })
            .catch(err => {
                alert("서버 통신 에러... 서버를 확인해주세요");
                console.log(err);
            });
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
                <a href="${pageContext.request.contextPath}/login" class="menu-item">
                    <span class="menu-icon"><img src="${pageContext.request.contextPath}/images/login.png"></span>
                    <div>로그인</div>
                </a>
                <a href="${pageContext.request.contextPath}/join" class="menu-item">
                    <span class="menu-icon"><img src="${pageContext.request.contextPath}/images/login.png"></span>
                    <div>회원가입</div>
                </a>
                <a href="${pageContext.request.contextPath}/mypage" class="menu-item">
                    <span class="menu-icon"><img src="${pageContext.request.contextPath}/images/mypage.png"></span>
                    <div>마이페이지</div>
                </a>
            </div>
        </div>
        <ul class="nav-bar">
            <li><a href="${pageContext.request.contextPath}/">홈</a></li>
            <li>레시피</li>
            <li>카테고리</li>
            <li>랭킹</li>
            <li>커뮤니티</li>
            <li class="active">냉장고 추천</li>
            <li>이벤트</li>
        </ul>
    </header>

    <div class="container main-container">
        <div class="form-card-container">
            <h2 class="form-card-title">새로운 재료 등록</h2>

            <form>
                <input type="hidden" value="${id}" name="id">

                <div class="form-input-group">
                    <label for="ingredient_name">재료 이름</label>
                    <input type="text" id="ingredient_name" name="ingredient_name" placeholder="식재료 이름을 입력하세요 (예: 우유)">
                </div>

                <div class="form-input-group">
                    <label for="quantity">재료 수량</label>
                    <input type="text" id="quantity" name="quantity" placeholder="갯수나 용량을 입력하세요 (예: 2개, 500g)">
                </div>

                <div class="form-input-group">
                    <label for="expire_date">유통기한</label>
                    <input type="date" id="expire_date" name="expire_date">
                </div>

                <div class="form-input-group">
                    <label for="freezer">보관 장소</label>
                    <select id="freezer" name="freezer">
                        <option value="false">냉장실 🍏</option>
                        <option value="true">냉동실 ❄️</option>
                    </select>
                </div>

                <div class="form-button-group">
                    <input type="button" class="btn-submit" value="등록" onClick="send(this.form)">
                    <input type="button" class="btn-cancel" value="취소" onClick="history.back()">
                </div>
            </form>
        </div>
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