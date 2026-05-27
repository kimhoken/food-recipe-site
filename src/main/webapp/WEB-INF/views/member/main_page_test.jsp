<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>

    <head>
      
    </head>

    <body>
       <div align="center">나의 소울 소사이어티에 어서와라 </div>

       <c:if test="${empty sessionScope.user}">
            <input type="button" value="LogOut" onclick="location.href='/logout.do'"/>
       </c:if>

       <c:if test="${not (empty sessionScope.user)}">
            <input type="button" value="LogIn" onclick="location.href='/login.do'"/>
       </c:if>

    </body>

</html>
