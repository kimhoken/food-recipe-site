<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>냉장고 파먹기</title>
        <link rel="stylesheet" type="text/css" href="/css/fridge.css">
        <script>
            function deleteItem(fridge_id){
                if(confirm("삭제하시겠습니까?")){
                    const url = "/delete_fridge.do";
                    fetch(url, {
                        method: "post",
                        headers: {
                            "Content-Type": "application/json"
                        },
                        body:JSON.stringify({
                            id: fridge_id
                        })
                    })
                    .then(res => res.json())
                    .then(data => {
                        if(data.result == "success"){
                            alert("삭제되었습니다.")
                            location.reload()
                        }else{
                            alert("삭제 실패...")
                        }
                    })
                }
            }

            function modify(firdge_id){
                const quantity = prompt("수량:");
                //alert(quantity + "/" + firdge_id)
                const url = "/modity.do";
                const data = {
                    firdge_id:firdge_id,
                    quantity:quantity
                }

                fetch(url, {
                    method: "post",
                    headers: {
                            "Content-Type": "application/json"
                    },
                    body:JSON.stringify(data)
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
        </script>
    </head>
    <body>

        <div class="header-container">
            <div class="logo-box"><a href="/"><img src="/images/Logo_2.png" alt="로고이미지" width="672" height="120"></a></div>
            <div class="header-right">
                <button class="user-menu-btn">👤 로그인</button>
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
                <div class="fridge-title-area">
                    <div class="user-title">OO님의 현재 냉장고 재료</div>
                    <button class="add-btn" onClick="location.href='/food_insert.do?id=1'">재료추가</button>
                </div>

                <div class="fridge-content">

                    <div class="freezer-side">
                        <div class="side-title">냉동실</div>
                        <div class="item-grid">
                            <c:forEach var="vo" items="${list}">
                                <c:if test="${vo.freezer eq true}">
                                    <div class="ingredient-card">
                                        <span class="ing-name">${vo.ingredient_name}</span>
                                        <span class="ing-qty" style="font-size: 12px; color: #666;">${vo.quantity}</span>

                                        <%-- <input type="button" value="삭제" onClick="deleteItem(${vo.fridge_id})">
                                        <input type="button" value="수정" onClick="modify(${vo.fridge_id})"> --%>

                                        <div class="expire-hover">
                                            <span>유통기한</span>
                                            <strong>${vo.expire_date}</strong>
                                            <div class="card-actions">
                                                <input type="button" value="삭제" onClick="deleteItem(${vo.fridge_id})">
                                                <input type="button" value="수정" onClick="modify(${vo.fridge_id})">
                                            </div>
                                        </div>

                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <div class="divider"></div>

                    <div class="fridge-side">
                        <div class="side-title">냉장실</div>
                        <div class="item-grid">
                            <c:forEach var="vo" items="${list}">
                                <c:if test="${vo.freezer ne true}">
                                    <div class="ingredient-card">
                                        <span class="ing-name">${vo.ingredient_name}</span>
                                        <span class="ing-qty" style="font-size: 12px; color: #666;">${vo.quantity}</span>
                                        <%-- <input type="button" value="삭제" onClick="deleteItem(${vo.fridge_id})">
                                        <input type="button" value="수정" onClick="modify(${vo.fridge_id})"> --%>
                                        <div class="expire-hover">  
                                            <span>유통기한</span>
                                            <strong>${vo.expire_date}</strong>
                                            <div class="card-actions">
                                                <input type="button" value="삭제" onClick="deleteItem(${vo.fridge_id})">
                                                <input type="button" value="수정" onClick="modify(${vo.fridge_id})">
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
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