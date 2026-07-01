<%@ page import="java.util.Random" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <jsp:include page="/WEB-INF/views/common/navibar.jsp">
                    <jsp:param name="currentMenu" value="recipe" />
                </jsp:include>

                <!DOCTYPE html>
                <html>

                <head>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recipe-detail.css">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
                    <meta charset="UTF-8">
                    <title>오늘 뭐 먹지? - 레시피 상세보기</title>

                    <script>
                        const del = (commentId) => {
                            if (confirm("삭제하시겠습니까?")) {
                                console.log(commentId);
                                fetch("/api/recomment/delete", {
                                    method: "delete",
                                    headers: {
                                        "Content-Type": "application/json"
                                    },
                                    body: JSON.stringify({
                                        commentId: commentId
                                    })
                                })
                                    .then(res => res.json())
                                    .then(data => {
                                        if (data.result == "success") {
                                            alert("삭제되었습니다");
                                            location.reload();
                                        } else {
                                            alert("실패했습니다.")
                                        }
                                    })
                            }
                        }

                        const register = (f) => {
                            let content = f.content.value;
                            let member_id = f.member_id.value;
                            let recipe_id = f.recipe_id.value;

                            if (!content.trim()) {
                                alert("내용은 공백을 제외하고 1자 이상 입력해주세요");
                                return;
                            }

                            fetch("/api/recomment/insert", {
                                method: "post",
                                headers: {
                                    "Content-Type": "application/json"
                                },
                                body: JSON.stringify({
                                    content: content,
                                    recipeId: recipe_id,
                                    memberId: member_id,
                                    rating: f.rating.value
                                })
                            })
                                .then(res => res.json())
                                .then(data => {
                                    if (data.result == 'success') {
                                        alert("등록되었습니다.")
                                        location.reload();
                                    } else {
                                        alert("실패하였습니다...")
                                    }
                                })
                                .catch(err => {
                                    console.log("에러발생 " + err)
                                })
                        }

                        const modi = (commentId) => {
                            let btn = document.getElementById('send_btn' + commentId);
                            let content = document.getElementById('modi_content' + commentId);
                            btn.type = "button";
                            content.readOnly = false;
                            content.style = "border:1px solid #333;";
                            content.focus();
                        }

                        const modiFin = (commentId) => {
                            let content = document.getElementById('modi_content' + commentId);
                            content.readOnly = true;
                            fetch("/api/recomment/update", {
                                method: "post",
                                headers: {
                                    "Content-Type": "application/json"
                                },
                                body: JSON.stringify({
                                    commentId: commentId,
                                    content: content.value
                                })
                            })
                                .then(res => res.json())
                                .then(data => {
                                    if (data.result == 'success') {
                                        alert("수정되었습니다.");
                                        location.reload();
                                    } else {
                                        alert("실패하였습니다...")
                                    }
                                })
                        }

                        // 댓글 ⋮ 버튼 클릭 시 드롭다운 열고 닫기
                        const toggleCommentMenu = (commentId) => {
                            const menu = document.getElementById("commentMenu" + commentId);

                            if (menu.style.display === "none" || menu.style.display === "") {
                                menu.style.display = "block";
                            } else {
                                menu.style.display = "none";
                            }
                        }

                        document.addEventListener("click", function (e) {
                            if (!e.target.closest(".comment-menu-wrap")) {
                                document.querySelectorAll(".comment-dropdown").forEach(menu => {
                                    menu.style.display = "none";
                                });
                            }
                        });
                    </script>
                </head>

                <body>
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
                                            <img src="/upload/recipe/${dto.thumbnail}" alt="썸네일" class="thumbnail-img">
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
                                            <!-- 조리과정 이미지 삽입--> 
                                            <c:if test="${not empty vo.cook_image}"> 
                                                <img src="/upload/recipe/${vo.cook_image}" class="cook-img"> 
                                            </c:if>
                                            </td>
                                            <td class="step-num">순서 ${vo.order}</td>
                                        </tr>

                                        <tr class="step-row-bottom">
                                            <td class="step-desc">${vo.description}</td>
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

                        <!-- 작성자만 삭제 가능 -->
                        <c:if test="${not empty sessionScope.user && sessionScope.user.member_id == dto.memberId}">
                            <a href="/recipe_delete.do?recipeId=${dto.recipeId}" class="recipe-delete-btn"
                                onclick="return confirm('삭제하시겠습니까?');">
                                삭제
                            </a>
                        </c:if>

                        <div class="recipe-report-wrapx">
                            <a href="/report/form.do?target_type=레시피&recipe_id=${param.recipeId}"
                                class="recipe-report-btn">
                                신고하기
                            </a>
                        </div>

                        <div class="recipe-bookmark-wrap">
                            <a href="#" class="recipe-bookmark-btn">
                                북마크
                            </a>
                        </div>

                        <div class="recipe-review-wrap">
                            <a href="/review/insert?recipe_id=${param.recipe_id}" class="recipe-review-btn">
                                레시피 후기 작성하기
                            </a>
                        </div>

                        <c:if test="${not empty commentList}">
                            <div class="comment-main-title">레시피 댓글</div>

                            <div class="read-comment-div">
                                <c:forEach var="vo" items="${commentList}">
                                    <%-- 관리자 페이지에서 #comment-댓글번호로 이동 가능하게 id 추가 --%>
                                        <table id="comment-${vo.commentId}">
                                            <tr>
                                                <td>${vo.nickname}</td>

                                                <td>
                                                    <textarea class="comment-content" id="modi_content${vo.commentId}"
                                                        readonly>${vo.content}</textarea>

                                                    <c:set var="rates" value="${vo.rating * 20}%" />
                                                    <div class="rate">
                                                        <span style="width: ${rates};"></span>
                                                    </div>
                                                </td>

                                                <td>
                                                    <%-- 작성자만 수정 가능 --%>
                                                        <c:if test="${vo.memberId eq sessionScope.user.member_id}">
                                                            <input type="button" value="수정"
                                                                onclick="modi('${vo.commentId}')">
                                                        </c:if>

                                                        <%-- 작성자 또는 관리자 삭제 가능 --%>
                                                            <c:if
                                                                test="${vo.memberId eq sessionScope.user.member_id || sessionScope.user.role eq 'ADMIN'}">
                                                                <input type="button" value="삭제"
                                                                    onclick="del('${vo.commentId}')">
                                                            </c:if>

                                                            <div style="position:relative; display:inline-block;">
                                                                <button type="button"
                                                                    onclick="toggleCommentMenu('${vo.commentId}')">⋮</button>
                                                                <div id="commentMenu${vo.commentId}"
                                                                    style="display:none; position:absolute; right:0; background:white; border:1px solid #ccc; padding:8px;">
                                                                    <a
                                                                        href="/report/form.do?target_type=레시피 후기&recipe_id=${recipeId}&comment_id=${vo.commentId}">
                                                                        신고
                                                                    </a>
                                                                </div>
                                                            </div>
                                                </td>
                                            </tr>
                                        </table>
                                </c:forEach>
                            </div>
                        </c:if>

                        <c:if test="${empty commentList}">
                            <div class="read-comment-div">
                                <h2>댓글을 작성해 첫 댓글의 주인공이 되어보세요!</h2>
                            </div>
                        </c:if>

                        <c:if test="${not empty sessionScope.user}">
                            <%-- 로그인했을때만 댓글달기 --%>
                                <form action="/recipe_comment.do">
                                    <div class="comment-insert-div">
                                        <table>
                                            <tr>
                                                <td>
                                                    댓글 달기
                                                    <input type="button" name="rating" id="rating" value="0">

                                                    <div class="rating">
                                                        <span class="rating__result"></span>
                                                        <i class="rating__star far fa-star"></i>
                                                        <i class="rating__star far fa-star"></i>
                                                        <i class="rating__star far fa-star"></i>
                                                        <i class="rating__star far fa-star"></i>
                                                        <i class="rating__star far fa-star"></i>
                                                    </div>

                                                    <%-- 출처: https://sisiblog.tistory.com/355 [달삼쓰뱉:티스토리] --%>
                                                </td>

                                                <td>
                                                    <input type="hidden" name="member_id"
                                                        value="${sessionScope.user.member_id}">
                                                    <input type="hidden" name="recipe_id" value="${param.recipeId}">
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <textarea name="content" id="comment-content"
                                                        placeholder="비방, 욕설 등의 댓글은 무통보 삭제될 수 있습니다."></textarea>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <input type="button" value="등록" class="comment-register"
                                                        onClick="register(this.form)">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </form>
                        </c:if>

                        <jsp:include page="/WEB-INF/views/common/footer.jsp" />

                        <script>
                            const ratingStars = [...document.getElementsByClassName("rating__star")];
                            const ratingResult = document.querySelector(".rating__result");

                            function printRatingResult(result, num = 0) {
                                result.textContent = num
                                document.getElementById("rating").value = num;
                            }

                            printRatingResult(ratingResult);

                            function executeRating(stars, result) {
                                const starClassActive = "rating__star fas fa-star";
                                const starClassUnactive = "rating__star far fa-star";
                                const starsLength = stars.length;
                                let i;

                                stars.map((star) => {
                                    star.onclick = () => {
                                        i = stars.indexOf(star);

                                        if (star.className.indexOf(starClassUnactive) !== -1) {
                                            printRatingResult(result, i + 1);

                                            for (i; i >= 0; --i) {
                                                stars[i].className = starClassActive;
                                            }
                                        } else {
                                            printRatingResult(result, i);

                                            for (i; i < starsLength; ++i) {
                                                stars[i].className = starClassUnactive;
                                            }
                                        }
                                    };
                                });
                            }

                            executeRating(ratingStars, ratingResult);
                        </script>
                </body>

                </html>