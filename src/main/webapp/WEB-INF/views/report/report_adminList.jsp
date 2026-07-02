<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <script>
        function openUserModal(name, nickname, email, profileImg) {
            document.getElementById("modalName").innerText = name;
            document.getElementById("modalNickname").innerText = nickname;
            document.getElementById("modalEmail").innerText = email;

            const img = document.getElementById("modalProfileImg");
            const fileName = profileImg ? profileImg.trim() : "";

            if (fileName !== "" && fileName !== "null" && fileName !== "no_file.png") {
                img.src = "/upload/profile/" + fileName;
            } else {
                img.src = "/images/no_file.png";
            }

            document.getElementById("userModal").style.display = "block";
        }

        function closeUserModal() {
            document.getElementById("userModal").style.display = "none";
        }

        function openReportDetailModal(reportId) {
            document.getElementById("detailModalTarget").innerText =
                document.getElementById("reportTarget-" + reportId).innerText;

            document.getElementById("detailModalStatus").innerText =
                document.getElementById("reportStatus-" + reportId).innerText;

            document.getElementById("detailModalReason").innerText =
                document.getElementById("reportReason-" + reportId).innerText;

            document.getElementById("detailModalTitle").innerText =
                document.getElementById("reportTitle-" + reportId).innerText;

            document.getElementById("detailModalContent").innerText =
                document.getElementById("reportDetail-" + reportId).innerText;

            document.getElementById("reportDetailModal").style.display = "block";
        }

        function closeReportDetailModal() {
            document.getElementById("reportDetailModal").style.display = "none";
        }
    </script>
</head>

<body>

<c:if test="${empty sessionScope.user or sessionScope.user.role ne 'ADMIN'}">
    <script>
        alert("관리자만 이용 가능한 페이지입니다.");
        location.href = "/main_list.do";
    </script>
</c:if>

<c:if test="${not empty sessionScope.user and sessionScope.user.role eq 'ADMIN'}">

    <h2>신고 관리</h2>

    <table border="1">
        <tr>
            <th>번호</th>
            <th>신고 대상</th>
            <th>신고받은 대상</th>
            <th>신고 사유</th>
            <th>신고 제목</th>
            <th>상태</th>
            <th>신고일</th>
            <th>신고자</th>
            <th colspan="2">경고여부</th>
        </tr>

        <c:forEach var="vo" items="${list}">
            <tr>
                <td>${vo.report_id}</td>

                <td>
                    <c:choose>
                        <c:when test="${vo.target_type eq '리뷰'}">
                            후기
                        </c:when>
                        <c:otherwise>
                            ${vo.target_type}
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <c:choose>

                        <c:when test="${vo.target_type eq '커뮤니티'}">
                            <a href="/view.do?board_id=${vo.board_id}">
                                게시글 보러가기
                            </a>
                        </c:when>

                        <c:when test="${vo.target_type eq '커뮤니티 댓글'}">
                            <a href="/view.do?board_id=${vo.board_id}#comment-${vo.comment_id}">
                                게시글 댓글 보러가기
                            </a>
                        </c:when>

                        <c:when test="${vo.target_type eq '레시피'}">
                            <a href="/recipe_detail.do?recipe_id=${vo.recipe_id}">
                                레시피 보러가기
                            </a>
                        </c:when>

                        <c:when test="${vo.target_type eq '레시피 댓글'}">
                            <a href="/recipe_detail.do?recipe_id=${vo.recipe_id}#comment-${vo.comment_id}">
                                레시피 댓글 보러가기
                            </a>
                        </c:when>

                        <c:when test="${vo.target_type eq '리뷰'}">
                            <a href="/list.do?btn=review">
                                후기 보러가기
                            </a>
                        </c:when>

                        <c:otherwise>
                            -
                        </c:otherwise>

                    </c:choose>
                </td>

                <td>${vo.reason}</td>

                <td>
                    <button type="button"
                            onclick="openReportDetailModal('${vo.report_id}')">
                        ${vo.report_title}
                    </button>

                    <span id="reportTarget-${vo.report_id}" style="display:none;">
                        <c:choose>
                            <c:when test="${vo.target_type eq '리뷰'}">후기</c:when>
                            <c:otherwise>${vo.target_type}</c:otherwise>
                        </c:choose>
                    </span>
                    <span id="reportStatus-${vo.report_id}" style="display:none;">${vo.status}</span>
                    <span id="reportReason-${vo.report_id}" style="display:none;">${vo.reason}</span>
                    <span id="reportTitle-${vo.report_id}" style="display:none;">${vo.report_title}</span>
                    <span id="reportDetail-${vo.report_id}" style="display:none;">${vo.detail}</span>
                </td>

                <td>${vo.status}</td>

                <td>
                    <fmt:formatDate value="${vo.created_date}" pattern="yyyy-MM-dd HH:mm"/>
                </td>

                <td>
                    <button type="button"
                            onclick="openUserModal('${vo.name}', '${vo.nickname}', '${vo.email}', '${vo.profile_img}')">
                        ${vo.nickname}
                    </button>
                </td>

                <td>
                    <form action="/report/admin/warning.do" method="post" style="display:inline;">
                        <input type="hidden" name="report_id" value="${vo.report_id}">
                        <input type="submit" value="경고부여"
                               onclick="return confirm('해당 신고 대상 작성자에게 경고 1회를 부여하시겠습니까?');">
                    </form>

                    <input type="button" value="신고취소">
                </td>
            </tr>
        </c:forEach>
    </table>

</c:if>

<div id="userModal"
     style="display:none; position:fixed; left:0; top:0; width:100%; height:100%;
            background:rgba(0,0,0,0.4); z-index:9999;">

    <div style="background:white; width:350px; margin:150px auto; padding:25px; border-radius:10px;">

        <h3>회원 정보</h3>

        <img id="modalProfileImg"
             src="/images/no_file.png"
             alt="프로필 이미지"
             style="width:90px; height:90px; border-radius:50%; object-fit:cover;">

        <p>이름: <span id="modalName"></span></p>
        <p>닉네임: <span id="modalNickname"></span></p>
        <p>이메일: <span id="modalEmail"></span></p>

        <input type="button" value="닫기" onclick="closeUserModal()">
    </div>
</div>

<div id="reportDetailModal"
     style="display:none; position:fixed; left:0; top:0; width:100%; height:100%;
            background:rgba(0,0,0,0.4); z-index:9999;">

    <div style="background:white; width:460px; margin:160px auto; padding:25px; border-radius:10px;">

        <h3>신고 상세 내용</h3>

        <p>신고 대상: <span id="detailModalTarget"></span></p>
        <p>상태: <span id="detailModalStatus"></span></p>
        <p>신고 사유: <span id="detailModalReason"></span></p>
        <p>신고 제목: <span id="detailModalTitle"></span></p>

        <div id="detailModalContent"
             style="min-height:100px; padding:15px; border:1px solid #ddd; background:#fafafa;
                    white-space:pre-wrap; word-break:keep-all; line-height:1.7;">
        </div>

        <br>

        <input type="button" value="닫기" onclick="closeReportDetailModal()">
    </div>
</div>

</body>
</html>