<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- 왜인지는 모르겠는데 import로 쓰면 session을 인식을 못하는지 로그인상태에서도 무조건 로그인하라 뜨니 복붙으로 이용해주세요.... --%>
<c:if test="${empty sessionScope.user}">
    <script>
        console.log('${user.member_id}')
        alert("로그인후 이용해주세요.")
        location.href="/login.do";
    </script>
</c:if>

