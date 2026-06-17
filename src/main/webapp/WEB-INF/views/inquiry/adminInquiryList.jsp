<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/adminInquiryList.css">
</head>

<body>

<div class="inquiry-list-page">

    <div class="inquiry-list-wrap">

        <div class="inquiry-title-box">
            <span class="inquiry-label">ADMIN INQUIRY</span>
            <h2>문의 관리</h2>
            <p>회원 및 비회원 문의 내역을 확인하고 답변을 관리합니다.</p>
        </div>

        <table class="inquiry-list-table">

            <thead>
                <tr>
                    <th>번호</th>
                    <th>유형</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>상태</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="vo" items="${list}">
                    <tr>

                        <td>${vo.inquiry_id}</td>

                        <td>${vo.type}</td>

                        <td class="title-cell">
                            <a href="/inquiry/admin/detail?inquiry_id=${vo.inquiry_id}">
                                ${vo.title}
                            </a>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${not empty vo.member_id}">
                                    회원 #${vo.member_id}
                                </c:when>

                                <c:otherwise>
                                    ${vo.guest_name}
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <fmt:formatDate
                                    value="${vo.created_date}"
                                    pattern="yyyy-MM-dd"/>
                        </td>

                        <td>

                            <c:choose>

                                <c:when test="${vo.status eq 'y'}">
                                    <span class="status-complete">
                                        답변완료
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="status-wait">
                                        답변대기
                                    </span>
                                </c:otherwise>

                            </c:choose>

                        </td>

                    </tr>
                </c:forEach>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>