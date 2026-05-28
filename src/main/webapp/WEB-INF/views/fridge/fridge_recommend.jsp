<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
    </head>
    <body>
        ${param.id} 냉장고 재료로 레시피 추천 사이트 <br>
        이런건 어떨까요?? 같은 멘트도 넣고          <br>
        오늘 기분? 그런거 선택해서 하면.... ㅋㅋ    <br>
        <input type="button" value="돌아가기" onClick="location.href='/fridge_list.do'">
    </body>
</html>