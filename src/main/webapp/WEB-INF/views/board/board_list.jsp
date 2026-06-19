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
        <jsp:include page="/WEB-INF/views/common/navibar.jsp">
            <jsp:param name="currentMenu" value="community" />
        </jsp:include>
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