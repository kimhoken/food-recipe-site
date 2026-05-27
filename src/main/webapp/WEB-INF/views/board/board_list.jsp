<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

    <head>

        <!-- <link /> -->

        <script>
            function send(f){       
                f.submit();
            }
        </script>
      
    </head>

    <body>
        <form action="/search.do" method="post">
            
            <div align="center"> 
                <input type="text" name="search" value="${searchWord}"/>
                <input type="button" value="검색" onclick="send(this.form)"/>
            </div> 
            <br/>

            </form>

        <c:if test="${not empty list}">
        <table border="1" align="center"> 
            <thead>
                
                <tr>
                    <th>게시글 번호</th>
                    <th>작성 회원 번호</th>
                    <th>게시글 제목</th>
                    <th>게시글 내용</th>
                    <th>조회수</th>
                    <th>작성일</th>
                    <th>수정일</th>
                </tr>
            </thead>

            <tbody>
                
                    <c:forEach var="board" items="${list}">
                        <tr>
                            <td>${board.board_id}</td>
                            <td>${board.member_id}</td>
                            <td>${board.title}</td>
                            <td>${board.content}</td>
                            <td>${board.view_count}</td>
                            <td>${board.created_date}</td>
                            <td>${board.updated_date}</td>
                        </tr>
                    </c:forEach>         
            </tbody>
        </table>
        </c:if>

        <c:if test="${empty list}">
            <h3 align="center">'${searchWord}'에 대한 검색 결과가 없습니다 :( </h3>
        </c:if>

        <input type="button" value="레시피 등록" onclick="location.href='/regiRecipe.do'" />

    </body>

</html>