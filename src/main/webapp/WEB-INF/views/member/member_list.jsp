<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>

    <head>
      
    </head>

    <body>

       <table border="1" align="center">
            <tr>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>별명</th>
                <th>신고횟수</th>
            </tr>
            <c:forEach var="vo" items="${list}">
                <tr>
                    <td>${vo.login_id}</td>
                    <td>${vo.password}</td>
                    <td>${vo.nickname}</td>
                    <td>${vo.report_count}</td>
                </tr>
            </c:forEach>
       </table>

    </body>

</html>
