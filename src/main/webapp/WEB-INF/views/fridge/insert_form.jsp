<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>냉장고 재료 등록</title>
        <link rel="stylesheet" type="text/css" href="/css/fridge_form.css">
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
                
                if(freezer == 'true'){
                    freezer = true;
                }else{
                    freezer = false;
                }
                
                const url = "/food_insert.do";
                const method="post";
                const data = {
                    id: id,
                    ingredient_name: ingredient_name,
                    quantity: quantity,
                    expire_date: expire_date,
                    freezer: freezer
                };
                
                fetch(url, {
                    method:method,
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(data)
                })
                .then(res => res.json())
                .then(data => {
                    if(data.res == "success"){ 
                        alert("등록 성공");
                        //등록 성공 시 냉장고 리스트로 이동
                        location.href="/fridge_list.do"
                    }else{
                        alert("등록 실패");
                    }
                }).catch(err => {
                alert("서버 통신 에러... 서버를 확인해주세요")
                console.log(err)
            })
            
        }
    </script>
</head>
<body>
    <div class="header-container">
        <div class="logo-box">로고들어가는 자리</div>
        <div class="header-right">
            <button class="user-menu-btn">👤 로그인 / 회원가입</button>
        </div>
    </div>

    <nav class="nav-bar">
        <ul class="nav-links">
            <li><a href="#">레시피</a></li>
            <li> | </li>
            <li class="active"><a href="#">냉장고 파먹기 </a></li>
            <li> | </li>
            <li><a href="#">나만의 레시피</a></li>
            <li> | </li>
            <li><a href="#">키친가이드</a></li>
        </ul>
    </nav>

    <div class="main-container">
        <div class="fridge-wrapper">
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
                            <option value="false">냉장실</option>
                            <option value="true">냉동실</option>
                        </select>
                    </div>

                    <div class="form-button-group">
                        <input type="button" class="btn-submit" value="등록" onClick="send(this.form)">
                        <input type="button" class="btn-cancel" value="취소" onClick="history.back()">
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-content">
            <div class="footer-links">
                <span>회사 소개 . 광고/제휴</span>
                <span>개인정보처리방침</span>
                <span>이용약관</span>
                <span>고객센터</span>
            </div>
            <p>대충 Copyright 만개의레시피 Inc. All Rights Reserved 이런거 들어가는 자리</p>
        </div>
    </footer>


</body>
</html>