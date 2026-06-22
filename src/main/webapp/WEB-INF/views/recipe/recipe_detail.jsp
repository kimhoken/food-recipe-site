<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recipe-detail.css">
        <meta charset="UTF-8">
        <title>오늘 뭐 먹지? - 레시피 상세보기</title>
        <script>
            const del = (f)=>{
                //삭제는 fetch로 구현
            }

            const register = (f) => {
                let title = f.title.value;
                let content = f.content.value;
                let member_id = f.member_id.value;
                let recipe_id = f.recipe_id.value;

                if(!title.trim()){
                    alert("제목을 입력해주세요");
                    return;
                }

                if(!content.trim()){
                    alert("내용은 공백을 제외하고 1자 이상 입력해주세요");
                    return ;
                }

                fetch("/recipe_comment_insert.do", {
                    method:"post",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        title: title,
                        content: content,
                        recipeId: recipe_id,
                        memberId: member_id
                    })  
                })
                .then(res => res.json())
                .then(data => {
                    if(data.result == 'success'){
                        alert("등록되었습니다.")
                        location.reload();
                    }else{
                        alert("실패하였습니다...")
                    }
                })
                .catch(err => {
                    console.log("에러발생 " + err)
                })
            }
        </script>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/common/navibar.jsp"/>
        <%-- 레시피의 조리순서, 재료, 사진 등을 보여주기 --%>
        <div class="title-wrap">
            <h1>${dto.recipeTitle}</h1>
            <div class="recipe-author">작성자: ${dto.nickName}</div>
        </div>
        <div class="recipe-detail-wrap">
            <div class="recipe-top-section">
                <table class="ingredient-table">
                    <tr>
                        <td rowspan="${size + 1}" class="thumb-cell">
                            <div class="img-placeholder">썸네일 사진 들어가는 자리</div>
                        </td>
                        <th colspan="2" class="section-title-cell">필요 재료</th>
                    </tr>
                    <c:forEach var="vo" items="${ingredients}">
                        <tr class="ingredient-row">
                            <td class="ing-name">${vo.ingredient_name}</td>
                            <td class="ing-amount">${vo.quantity}${vo.unit}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <hr class="section-divider" />

            <div class="recipe-bottom-section">
                <table class="step-table">
                    <c:forEach var="vo" items="${orderList}">
                        <tr class="step-row-top">
                            <td rowspan="2" class="step-thumb-cell">
                                <div class="img-placeholder">사진 들어가는 자리</div>
                            </td>
                            <td class="step-num">순서 ${vo.order}</td>
                        </tr>
                        <tr class="step-row-bottom">
                            <td class="step-desc">${vo.description} </td>
                        </tr>
                        <tr class="step-divider-row">
                            <td colspan="2">
                                <hr class="step-line">
                            </td>
                        </tr>  
                    </c:forEach>
                </table>
            </div>
        </div>
        
        <c:if test="${not empty sessionScope.user}">
            <%-- 로그인했을때만 댓글달기 --%>
            <form action="/recipe_comment.do">
                <div class="comment-insert-div">
                    <table>
                        <tr>
                            <td>
                                <input type="hidden" name="member_id" value="${sessionScope.user.member_id}">
                                <input type="hidden" name="recipe_id" value="${param.recipeId}">
                            </td>
                        </tr>
                        <tr>
                            <td><textarea name="content" id="comment-content"></textarea></td>
                        </tr>
                        <tr>
                            <td><input type="button" value="등록" class="comment-register" onClick="register(this.form)"></td>
                        </tr>
                    </table>
                </div>
            </form>
        </c:if>
        <c:if test="${not empty commentList}">
            <div class="read-comment-div">
                <c:forEach var="vo" items="${commentList}">
                    <table>
                        <tr>
                            <td><input type="text" value="${vo.content}" readOnly="readonly"></td>
                            <td>작성자</td> 
                            <td><input type="text" value="${vo.nickname}"></td>
                            <c:if test="${vo.memberId eq sessionScope.user.member_id}">
                                <td>
                                    <input type="button" value="수정" onClick="location.href='/comment_modify.do?member_id=${vo.memberId}'" />
                                    <form>
                                        <input type="button" value="삭제" onClick="del(this.form)" />
                                    </form>
                                </td>
                            </c:if>
                        </tr>
                    </table>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty commentList}">
            <div class="read-comment-div">
                <h2>첫 댓글의 주인공이 되어보세요!</h2>
            </div>
        </c:if>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </body>
</html>