<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" href="/css/mypageinquiry.css">

<script>
    function toggleInquiry(id) {
        const item = document.getElementById("inquiry-" + id);

        if (item.classList.contains("open")) {
            item.classList.remove("open");
        } else {
            item.classList.add("open");
        }
    }
</script>

<div class="my-inquiry-wrap">

    <div class="my-inquiry-top">
        <div>
            <h2>문의 내역</h2>
            <p>전체 <strong>${inquiryList.size()}</strong>건</p>
        </div>

        <button type="button" onclick="location.href='/inquiry'">
            ✎ 문의 작성
        </button>
    </div>

    <div class="inquiry-filter-row">
        <button type="button" class="active">전체</button>
        <button type="button">접수</button>
        <button type="button">처리중</button>
        <button type="button">답변완료</button>
    </div>

    <div class="inquiry-list">

        <c:choose>
            <c:when test="${empty inquiryList}">
                <div class="empty-box">
                    작성한 문의가 없습니다.
                </div>
            </c:when>

            <c:otherwise>
                <c:forEach var="vo" items="${inquiryList}">
                    <div class="inquiry-card" id="inquiry-${vo.inquiry_id}">

                        <div class="inquiry-summary"
                             onclick="toggleInquiry('${vo.inquiry_id}')">

                            <span class="arrow">›</span>

                            <span class="status ${vo.status eq 'y' ? 'done' : 'wait'}">
                                <c:choose>
                                    <c:when test="${vo.status eq 'y'}">답변완료</c:when>
                                    <c:otherwise>접수</c:otherwise>
                                </c:choose>
                            </span>

                            <strong class="title">${vo.title}</strong>

                            <span class="date">
                                <fmt:formatDate value="${vo.created_date}" pattern="yyyy.MM.dd"/>
                            </span>
                        </div>

                        <div class="inquiry-detail">
                            <div class="question-box">
                                <p>${vo.content}</p>
                            </div>

                            <c:if test="${vo.status eq 'y'}">
                                <div class="answer-box">
                                    <div class="answer-title">
                                        💬 관리자 답변

                                        <span>
                                            답변일 :
                                            <fmt:formatDate value="${vo.answered_date}" pattern="yyyy.MM.dd"/>
                                        </span>
                                    </div>

                                    <p>${vo.answer_content}</p>
                                </div>
                            </c:if>

                            <c:if test="${vo.status ne 'y'}">
                                <div class="answer-box waiting">
                                    아직 답변이 등록되지 않았습니다.
                                </div>
                            </c:if>
                        </div>

                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>

    </div>

</div>