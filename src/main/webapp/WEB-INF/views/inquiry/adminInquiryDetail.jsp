<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <script>
            function sendAnswer(f) {
                const answer = f.answer_content.value.trim();

                if (answer === "") {
                    alert("답변 내용을 입력하세요.");
                    f.answer_content.focus();
                    return;
                }

                if (!confirm("답변을 등록하시겠습니까?")) {
                    return;
                }

                f.submit();
            }
        </script>
    </head>

    <body>

        <h2 align="center">문의 상세</h2>

        <table border="1" align="center">
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
                <th>내용</th>
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
                <th>작성자</th>
                <td>
                    <c:choose>
                        <c:when test="${not empty vo.member_id}">
                            회원번호 ${vo.member_id}
                        </c:when>
                        <c:otherwise>
                            ${vo.guest_name} / ${vo.guest_email}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>

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

            <c:if test="${not empty vo.inquiry_code}">
                <tr>
                    <th>문의코드</th>
                    <td>${vo.inquiry_code}</td>
                </tr>
            </c:if>
        </table>

        <br>

        <h3 align="center">관리자 답변</h3>

        <form action="/inquiry/admin/answer" method="post">

            <input type="hidden" name="inquiry_id" value="${vo.inquiry_id}">

            <table border="1" align="center">
                <tr>
                    <th>답변 내용</th>
                    <td>
                        <textarea name="answer_content" rows="8" cols="70">${vo.answer_content}</textarea>
                    </td>
                </tr>

                <c:if test="${not empty vo.answered_date}">
                    <tr>
                        <th>답변일</th>
                        <td>
                            <fmt:formatDate value="${vo.answered_date}" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                    </tr>
                </c:if>

                <tr>
                    <td colspan="2" align="center">
                        <input type="button" value="답변 등록" onclick="sendAnswer(this.form)">
                        <input type="button" value="목록" onclick="location.href='/inquiry/admin/list'">
                    </td>
                </tr>
            </table>

        </form>

    </body>
</html>