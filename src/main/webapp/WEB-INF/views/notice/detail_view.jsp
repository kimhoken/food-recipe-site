<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/notice_detail.css">

    <script>
        function deleteNotice() {
            if (confirm("삭제하시겠습니까?")) {
                location.href = "notice_delete.do?notice_id=${notice.notice_id}";
            }
        }
    </script>
</head>

<body>
    <jsp:include page="/WEB-INF/views/common/navibar.jsp" />

    <main class="notice-detail-page">

        <section class="detail-head">
            <span>NOTICE DETAIL</span>
            <h2>공지사항</h2>
        </section>

        <section class="detail-card">

            <div class="detail-title-area">
                <p class="detail-no">NO. ${notice.notice_id}</p>
                <h3>${notice.title}</h3>

                <div class="detail-meta">
                    <span>작성자 ${notice.member_id}</span>
                    <span>
                        <fmt:formatDate value="${notice.created_date}" pattern="yyyy-MM-dd HH:mm:ss" />
                    </span>
                    <span>조회수 ${notice.view_count}</span>
                </div>
            </div>

            <div class="detail-content">
                <c:if test="${not empty img}">
                    <div class="detail-img-box">
                        <img src="/upload/${img.image_list}" />
                    </div>
                </c:if>

                <p>${notice.content}</p>
            </div>

            <div class="detail-btn-area">
                <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                    <input type="button"
                           class="edit-btn"
                           value="수정"
                           onclick="location.href='notice_update.do?notice_id=${notice.notice_id}'">

                    <input type="button"
                           class="delete-btn"
                           value="삭제"
                           onclick="deleteNotice()">
                </c:if>

                <input type="button"
                       class="list-btn"
                       value="목록"
                       onclick="location.href='notice.do'">
            </div>

        </section>

    </main>
</body>
</html>