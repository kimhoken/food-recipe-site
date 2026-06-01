<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

    <head> 
        <title>오늘 뭐 먹지? - 레시피 공유</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/board.css"/> 
        <link rel="stylesheet" href="/css/main.css">
        <script>
            function send(f){       
                f.submit();
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
                <li ><a href="/main_list.do">홈</a></li>
                <li class="active">
                    <a href="/list.do"> 레시피</a>
                </li>
                <li>카테고리</li>
                <li>랭킹</li>
                <li>커뮤니티</li>
                <li>
                    <a href="/fridge_list.do">냉장고 추천</a>
                </li>
                <li>이벤트</li>
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
                                    <td>${board.title}</td>
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

            <input type="button" value="레시피 등록" onclick="location.href='/regiRecipe.do'" />
        </div>
    </body>

</html>