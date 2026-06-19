<%@ page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recipe-detail.css">
        <meta charset="UTF-8">
        <title>오늘 뭐 먹지? - 레시피 상세보기</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/views/common/navibar.jsp"/>
        <%-- 레시피의 조리순서, 재료, 사진 등을 보여주기 --%>
        <div class="recipe-detail-wrap">
            <div class="recipe-author">작성자: ${dto.nickName}</div>
            
            <div class="recipe-top-section">
                <table class="ingredient-table">
                    <tr>
                        <td rowspan="${size + 1}" class="thumb-cell">
                            <div class="img-placeholder">썸네일 사진 들어가는 자리</div>
                        </td>
                        <th colspan="2" class="section-title-cell">필요 재료</th>
                    </tr>
                    <c:forEach var="vo" items="${ingredients}">
                        <tr class="ingredient-row">
                            <td class="ing-name">${vo.ingredient_name}</td>
                            <td class="ing-amount">${vo.quantity}${vo.unit}</td>
                            
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <hr class="section-divider" />

            <div class="recipe-bottom-section">
                <table class="step-table">
                    <c:forEach var="vo" items="${orderList}">
                        <tr class="step-row-top">
                            <td rowspan="2" class="step-thumb-cell">
                                <div class="img-placeholder">사진 들어가는 자리</div>
                            </td>
                            <td class="step-num">순서 ${vo.order}</td>
                        </tr>
                        <tr class="step-row-bottom">
                            <td class="step-desc">${vo.description} </td>
                        </tr>
                        <tr class="step-divider-row">
                            <td colspan="2">
                                <hr class="step-line">
                            </td>
                        </tr>  
                    </c:forEach>
                </table>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </body>
</html>