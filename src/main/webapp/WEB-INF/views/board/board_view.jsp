<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--로그인 체크-->
<c:if test="${not empty sessionScope.user and sessionScope.user.member_id == board.member_id}"></c:if>

    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>게시글 상세보기</title>

        <link rel="stylesheet" href="/css/main.css">
        <link rel="stylesheet" href="/css/board_view.css">
    </head>

    <body>

        <div class="board-view">

            <h2>${board.title}</h2>

            <hr>

            <div class="board-info">
                <span>작성자 : ${board.nickname}</span>
                <span>조회수 : ${board.view_count}</span>
                <span>작성일 : ${board.created_date}</span>
            </div>

            <hr>

            <div class="content">${board.content}</div>

            <br>

            <div class="btn-area">
                <div class="btn-center">
                    <input type="button" value="목록으로" onclick="location.href='/list.do'">
                </div>

                <div class="btn-right">
                    <c:if test="${sessionScope.user.member_id == board.member_id}">
                    
                    <input type="button" value="수정" onclick="location.href='/update_form.do?board_id=${board.board_id}'">
                    <input type="button" value="삭제" 
                           onclick="if(confirm('삭제하시겠습니까?')){location.href='/delete.do?board_id=${board.board_id}'}">
                     
                    </c:if>       
                    <a href="/report/form.do?target_type=게시판&board_id=${param.board_id}">
                        신고하기
                    </a>
                    
                </div>
            </div>

        </div> 

    </body>

    </html>