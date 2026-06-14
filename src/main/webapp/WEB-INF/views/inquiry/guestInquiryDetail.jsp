<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        
    </head>

    <body>

    <h2>문의 답변 확인</h2>

    <table border="1">
        <tr>
            <th>문의번호</th>
            <td>${vo.inquiry_id}</td>
        </tr>

        <tr>
            <th>유형</th>
            <td>${vo.type}</td>
        </tr>

        <tr>
            <th>제목</th>
            <td>${vo.title}</td>
        </tr>

        <tr>
            <th>문의 내용</th>
            <td>${vo.content}</td>
        </tr>

        <c:if test="${not empty imgList}">
            <tr>
                <th>첨부 이미지</th>
                <td>
                    <c:forEach var="img" items="${imgList}">
                        <img src="/upload/${img.image_list}"
                             style="max-width:300px; margin:6px;">
                    </c:forEach>
                </td>
            </tr>
        </c:if>

        <tr>
            <th>작성일</th>
            <td>
                <fmt:formatDate value="${vo.created_date}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
        </tr>

        <tr>
            <th>답변상태</th>
            <td>
                <c:choose>
                    <c:when test="${vo.status eq 'y'}">
                        답변 완료
                    </c:when>
                    <c:otherwise>
                        답변 대기
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>

        <tr>
            <th>관리자 답변</th>
            <td>
                <c:choose>
                    <c:when test="${not empty vo.answer_content}">
                        ${vo.answer_content}
                    </c:when>
                    <c:otherwise>
                        아직 답변이 등록되지 않았습니다.
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>

        <tr>
            <th>답변일</th>
            <td>
                <fmt:formatDate value="${vo.answered_date}" pattern="yyyy-MM-dd HH:mm"/>
            </td>
        </tr>

        <tr>
            <td colspan="2" align="center">
                <input type="button" value="메인으로" onclick="location.href='/main_list.do'">
            </td>
        </tr>
    </table>

    </body>
</html>