<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/guestInquiryDetail.css">
</head>

<body>

<div class="inquiry-page">

    <div class="inquiry-form">

        <div class="inquiry-title-box">
            <span class="inquiry-label">INQUIRY ANSWER</span>
            <h2>문의 답변 확인</h2>
            <p>
                문의 내용과 관리자 답변을 확인할 수 있습니다.
            </p>
        </div>

        <table class="inquiry-table">

            <tr>
                <th>문의번호</th>
                <td>${vo.inquiry_id}</td>
            </tr>

            <tr>
                <th>문의유형</th>
                <td>${vo.type}</td>
            </tr>

            <tr>
                <th>제목</th>
                <td>${vo.title}</td>
            </tr>

            <tr>
                <th>문의내용</th>
                <td class="content-box">
                    ${vo.content}
                </td>
            </tr>

            <c:if test="${not empty imgList}">
                <tr>
                    <th>첨부이미지</th>
                    <td>

                        <div class="image-list">

                            <c:forEach var="img" items="${imgList}">
                                <img src="/upload/${img.image_list}" alt="">
                            </c:forEach>

                        </div>

                    </td>
                </tr>
            </c:if>

            <tr>
                <th>작성일</th>
                <td>
                    <fmt:formatDate
                        value="${vo.created_date}"
                        pattern="yyyy-MM-dd HH:mm"/>
                </td>
            </tr>

            <tr>
                <th>답변상태</th>
                <td>

                    <c:choose>

                        <c:when test="${vo.status eq 'y'}">
                            <span class="status-complete">
                                답변 완료
                            </span>
                        </c:when>

                        <c:otherwise>
                            <span class="status-wait">
                                답변 대기
                            </span>
                        </c:otherwise>

                    </c:choose>

                </td>
            </tr>

            <tr>
                <th>관리자 답변</th>

                <td>

                    <div class="answer-box">

                        <c:choose>

                            <c:when test="${not empty vo.answer_content}">
                                ${vo.answer_content}
                            </c:when>

                            <c:otherwise>
                                아직 답변이 등록되지 않았습니다.
                            </c:otherwise>

                        </c:choose>

                    </div>

                </td>
            </tr>

            <tr>
                <th>답변일</th>
                <td>

                    <c:if test="${not empty vo.answered_date}">
                        <fmt:formatDate
                            value="${vo.answered_date}"
                            pattern="yyyy-MM-dd HH:mm"/>
                    </c:if>

                </td>
            </tr>

        </table>

        <div class="btn-area">
            <input type="button"
                   value="메인으로"
                   class="cancel-btn"
                   onclick="location.href='/main_list.do'">
        </div>

    </div>

</div>

</body>
</html>