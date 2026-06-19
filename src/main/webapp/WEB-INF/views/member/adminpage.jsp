<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="/WEB-INF/views/common/is_login.jsp" />
        <html>

        <head>
            <link rel="stylesheet" href="css/admin.css" />

            <script>
                let recipedetailrecipe;

                function openDetail() {
                    document.querySelector(".ra-detail").classList.add("active");
                }
                function closeDetail() {
                    document.querySelector(".ra-detail").classList.remove("active");
                }


                function recipe_view(recipe_id) {

                    fetch("/admin/recipe", {
                        method: "post",
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: "recipe_id=" + recipe_id
                    }).then(res => res.json())
                        .then(data => {
                            recipedetailrecipe = data.recipe.recipe_id;
                            fileRecipe(data.recipe);
                            renderCookOrders(data.list);
                            openDetail();
                        })
                }

                function fileRecipe(recipe) {
                    setText("model_title", recipe.title);
                    setText("model_nickname", recipe.nickname);
                    setText("model_category", recipe.category_name);
                    setText("model_created", recipe.created_date);
                    setText("model_modify", recipe.updated_date);
                    setText("model_count", recipe.view_count);
                    setText("model_like", recipe.like_count);
                    setText("model_status", recipe.status);

                    setImg("model_img", "/upload/recipe/" + recipe.thumbnail);
                }

                function renderCookOrders(list) {
                    console.log(list);
                    const box = document.getElementById("cookOrderBox");
                    box.innerHTML = "";

                    list.forEach(order => {
                        box.insertAdjacentHTML("beforeend", `
            <div class="ra-step">
                <img class="ra-step-img" src="/upload/recipe/\${order.cook_image}">
                <div class="ra-step-body">
                    <div class="ra-step-title">\${order.cook_order}단계</div>
                    <small class="ra-step-desc">\${order.description}</small>
                </div>
            </div>
        `);
                    });
                }

                function setText(id, value) {
                    document.getElementById(id).textContent = value ?? "-";
                }
                function setImg(id, src) {
                    document.getElementById(id).src = src;
                }

                function recipeprivate(){
                    if(confirm("정말로 비공개 처리 하시겠습니까?")){
                        fetch("/")
                    }
                }

            </script>
        </head>

        <body>
            <div class="admin-layout">

                <div class="admin-wrap">
                    <!-- 마이페이지 왼쪽 메뉴 부분 -->
                    <aside class="admin-left">

                        <div class="logo-box">
                            <a href="/main_list.do">
                                <img src="/images/logo.png" width="200px" height="50px" />
                            </a>
                        </div>

                        <div class="profile-mini">
                            <div class="profile-img">
                                <c:choose>

                                    <c:when test="${profileuser.profile_img eq 'no_file.png'}">
                                        <img src="/images/no_file.png" width="85px" height="85px" />
                                    </c:when>

                                    <c:when test="${profileuser.profile_img ne 'no_file.png'}">
                                        <img src="/upload/profile/${profileuser.profile_img}" width="85px"
                                            height="85px" />
                                    </c:when>

                                </c:choose>

                            </div>
                            <strong>${profileuser.nickname}</strong>
                            <p>맛있는 하루 되세요!</p>
                        </div>


                        <div class="menu-section">
                            <div class="sub-title">운영 관리</div>
                            <a class="admin-menu ${menu eq 'home' ? 'active'  :''}" href="/admin?menu=home">
                                대시 보드</a>
                            <a class="admin-menu ${menu eq 'user' ? 'active'  : ''}" href="/admin?menu=user">
                                회원 관리</a>
                            <a class="admin-menu ${menu eq 'recipe' ? 'active' :''}" href="/admin?menu=recipe">
                                레시피 관리</a>
                            <a class="admin-menu ${menu eq 'stats' ? 'active'  :''}" href="/admin?menu=stats">
                                통계 관리</a>
                        </div>


                        <div class="menu-section">
                            <div class="sub-title">고객지원</div>
                            <a class="admin-menu ${menu eq 'inquiry' ? 'active' :''}" href="/admin?menu=inquiry">
                                문의 관리</a>
                            <a class="admin-menu ${menu eq 'report' ? 'active' :''}" href="/admin?menu=report">
                                신고 관리</a>
                        </div>

                        <div class="menu-section">
                            <div class="sub-title">계정 관리</div>
                            <a class="admin-menu ${menu eq 'info' ? 'active'  :''}" href="/admin?menu=info">
                                내 정보</a>
                            <button type="button" onclick="logout()">
                                <img src="/images/logout.png" />
                                로그아웃</button>
                            <a class="admin-menu ${menu eq 'notice' ? 'active' :''}" href="/admin?menu=notice">
                                알림</a>

                        </div>

                    </aside>

                    <main class="admin-main">
                        <div class="admin-container">
                            <jsp:include page="${contentPage}" />
                        </div>
                    </main>

                </div>
            </div>
        </body>

        </html>