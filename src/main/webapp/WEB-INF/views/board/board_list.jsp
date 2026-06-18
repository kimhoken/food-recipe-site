<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>오늘 뭐 먹지? - 레시피 공유</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css" />
        <link rel="stylesheet" href="/css/main.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/search_bar.css"> 
        <link rel="stylesheet" href="/css/chatbot.css" />
        <script src="/js/chatbot.js"></script>
        
        <script>
            function send(f) {
                f.submit();
            }
            const logout = ()=>{
                if(confirm("로그아웃 하시겠습니까?")){
                    fetch("/logout.do", {
                        method: "post",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({
                            id: "${user.member_id}"
                        })
                    })
                    .then(res => res.json())
                    .then(data => {
                        if (data.result == "success") {
                            alert("로그아웃 되었습니다.")
                            location.href = "/main_list.do";
                        }
                    })
                }
            }
            document.addEventListener("DOMContentLoaded", function() {
                const searchInput = document.getElementById("mainSearch");
                const searchDropdown = document.getElementById("searchDropdown");
                
                // 1. 검색창에 포커스가 가면 드롭다운 띄우기
                searchInput.addEventListener("focus", function() {
                    searchDropdown.style.display = "block";
                });
                
                // 2. 검색창이나 드롭다운 바깥 영역을 클릭하면 닫기
                document.addEventListener("click", function(event) {
                    // 클릭한 타겟이 검색창도 아니고 드롭다운 내부도 아니면 닫음
                    if (!searchInput.contains(event.target) && !searchDropdown.contains(event.target)) {
                        searchDropdown.style.display = "none";
                    }
                });
            });

        </script>
    </head>


    <body>
        <header>
            <div class="header-top">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/">
                        <img src="${pageContext.request.contextPath}/images/Logo.png" alt="로고"/>
                    </a>
                </div>

                <%-- 검색창 클릭시 나올 화면 --%>
                <div class="search-wrapper" style="position: relative;">
                    <form action="${pageContext.request.contextPath}/search_recipe.do" method="post" class="search-bar-form">
                        <div class="search-bar">
                            <select name="select" id="sel">
                                <option value="recipe">레시피</option>
                                <option value="review" selected>후기</option>
                            </select>
                            <input type="text" id="mainSearch" name="search" placeholder="재료, 요리명으로 검색해보세요!" autocomplete="off">
                            <button type="submit">⌕</button>
                        </div>
                    </form>

                    <div id="searchDropdown" class="search-dropdown">
                        <div class="search-section" id="recent">
                            <h4>최근 검색어</h4>
                            <c:if test="${empty sessionScope.currentSearchList}">
                                <p class="empty-text">최근 검색어가 없습니다.</p>
                            </c:if>
                            <c:if test="${!empty sessionScope.currentSearchList}">
                                <form action="${pageContext.request.contextPath}/search_recipe.do" method="post">
                                    <c:forEach var="item" items="${currentSearchList}" varStatus="status">
                                        <input type="submit" value="${item}" name="search">
                                    </c:forEach>
                                </form>
                            </c:if>
                        </div>

                        <div class="search-section" id="recommend">
                            <h4>추천 검색어</h4>
                        </div>

                        <div class="search-section">
                            <h4>급상승 검색어</h4>
                            <div class="trending-list">
                                <c:forEach var="vo" items="${sessionScope.searchList}" varStatus="status">
                                    <div class="trending-item">
                                        <!-- 상세보기 만들면 거기에 맞는 상세보기로 바로 이동 -->
                                        <a href="#"><span class="rank-num">${status.index + 1}</span> ${vo}</a>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>

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

            <ul class="nav-bar">
                <li><a href="/main_list.do">홈</a></li>
                <li><a href="/recipe_list.do">레시피</a></li>
                <li>랭킹</li>
                <li class="active"><a href="/list.do">커뮤니티</a></li>
                <li><a href="/fridge_list.do?member_id=${user.member_id}">냉장고 추천</a></li>
                <li><a href="/guide_list.do">키친가이드</a></li>
            </ul>
        </header>   
        <div class="board-area">
            <c:if test="${not empty list}">
                <table>
                    <thead>
                        <tr>
                            <th>게시글 번호</th>
                            <th>닉네임</th>
                            <th>제목</th>
                            <th>게시글 내용</th>
                            <th>조회수</th>
                            <th>작성일</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="board" items="${list}">
                            <tr>
                                <td>${board.board_id}</td>
                                <td>${board.nickname}</td>
                                <td>
                                    <a href="/view.do?board_id=${board.board_id}">
                                        ${board.title}
                                    </a>
                                </td>
                                <td>${board.content}</td>
                                <td>${board.view_count}</td>
                                <td>${board.created_date}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty list}">
                <h3 align="center">"${searchWord}"에 대한 검색 결과가 없습니다 :( </h3>
            </c:if>

            <%-- 로그인 한 경우만 버튼이 보이게 --%>
            <c:if test="${!empty sessionScope.user}">
                <div style="text-align:center; margin-top:20px;">
                <input type="button" value="나도 끄적끄적 ✍️"
                        onclick="location.href='/community_form.do'"/>
                </div>
            </c:if>

        </div>

        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

                <!-- 챗봇 -->
                <jsp:include page="/WEB-INF/views/chatbot/chatbot_main.jsp" />
            </body>

        </html>