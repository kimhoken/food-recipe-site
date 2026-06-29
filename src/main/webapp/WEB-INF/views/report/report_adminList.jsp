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
                <td>${vo.target_type}</td>

                <td>
                    <c:choose>

                        <c:when test="${vo.target_type eq '게시판'}">
                            <a href="/view.do?board_id=${vo.board_id}">
                                게시글 보러가기
                            </a>
                        </c:when>

                        <c:when test="${vo.target_type eq '게시판 댓글'}">
                            <a href="/view.do?board_id=${vo.board_id}#comment-${vo.comment_id}">
                                게시판 댓글 보러가기
                            </a>
                        </c:when>

                        <c:when test="${vo.target_type eq '레시피'}">
                            <a href="/recipe_detail.do?recipeId=${vo.recipe_id}">
                                레시피 보러가기
                            </a>
                        </c:when>

                        <%-- 수정: 레시피 후기는 comment_id를 commentId 파라미터로 전달 --%>
                        <c:when test="${vo.target_type eq '레시피 후기'}">
                            <a href="/recipe_detail.do?recipeId=${vo.recipe_id}&commentId=${vo.comment_id}">
                                레시피 댓글 보러가기
                            </a>
                        </c:when>

                        <c:otherwise>
                            -
                        </c:otherwise>

                    </c:choose>
                </td>

                <td>${vo.reason}</td>
                <td>${vo.report_title}</td>
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
                    <input type="button" value="경고부여">
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

</body>
</html>