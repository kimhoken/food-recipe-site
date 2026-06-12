<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <title>오늘 뭐 먹지? - 레시피 공유</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css" />
            <link rel="stylesheet" href="/css/main.css">
            <link rel="stylesheet" href="/css/chatbot.css" />
            <script src="/js/chatbot.js"></script>
            <script>
                function send(f) {
                    f.submit();
                }
                //로그아웃에 사용하는 함수
                const logout = () => {
                    if (confirm("로그아웃 하시겠습니까?")) {
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
                                    location.href = "/list.do";
                                }
                            })
                    }
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

                    <form action="${pageContext.request.contextPath}/search.do" method="post" class="search-bar-form">
                        <div class="search-bar">
                            <input type="text" id="mainSearch" name="search" placeholder="재료, 요리명으로 검색해보세요!">
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
                                <a href="#" class="menu-item" id="login" onClick="logout(); return false;">
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
                <li><a href="/main_list.do">홈</a></li>
                <li><a href="/recipe_list.do">레시피</a></li>
                <li>카테고리</li>
                <li>랭킹</li>
                <li class="active"><a href="/list.do">커뮤니티</a> </li>
                <li>
                    <a href="/fridge_list.do?member_id=${user.member_id}">냉장고 추천</a>
                </li>
                <li>키친가이드</li>
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
                <input type="button" value="리뷰 등록" onclick="location.href='#'" />
            </c:if>
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
                        <div class="sns-icons">
                            <span class="sns-icon">▶</span>
                            <span class="sns-icon">★</span>
                            <span class="sns-icon">☆</span>
                            <span class="sns-icon">◆</span>
                            <span class="sns-icon">♬</span>
                        </div>
                    </div>
                </div>

                <div class="footer-nav-bar">
                    <div class="footer-container">
                        <div class="nav-links">
                            <a href="#"><strong>이용약관</strong></a>
                            <a href="#"><strong>개인정보처리방침</strong></a>
                            <a href="/notice.do">공지사항</a>
                            <a href="#">자주묻는질문</a>
                            <span class="partner-mail">광고/제휴 문의: kh@culture.net</span>
                        </div>
                    </div>
                </div>

                <div class="footer-container">
                    <div class="footer-bottom-row">
                        <div class="company-info">
                            <h4>주식회사 코코짱짱</h4>
                            <p>
                                <span>상호 : KH 개발</span>
                                <span>대표자 : 장승연</span>
                                <span>개인정보관리책임자 : 장승연</span>
                                <span>사업자 등록번호 : 111-01-31111</span>
                            </p>
                            <p>
                                <span>통신판매업 신고 : 제 2015-경기성남-1940 호</span>
                                <span>전화 : 1833-1234</span>
                                <span>팩스 : 031-8017-1800</span>
                            </p>
                            <p>주소 : 경기도 성남시 분당구 판교로 216길 92, kh타워 22층 2201호( 삼평동, 판교 에이치스퀘어 ) &nbsp;&nbsp; 이메일:
                                kh@culture.net</p>
                        </div>

                        <div class="footer-logo-area">
                            <p class="copyright">© 2026 by Khculture. All rights reserved.</p>
                        </div>
                    </div>
                </div>
            </footer>

            <!-- 챗봇 -->
            <jsp:include page="/WEB-INF/views/chatbot/chatbot_main.jsp" />
        </body>

        </html>