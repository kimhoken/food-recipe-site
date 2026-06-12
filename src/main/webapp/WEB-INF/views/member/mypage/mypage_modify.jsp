<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section>
    <h2 class="join-title">회원 정보 수정</h2>

    <form action="/mypage_update.do" method="post" enctype="multipart/form-data">
        <input type="hidden" id="filechange" value="no" name="filechange"/>        
        <!-- 프로필 이미지 -->
        <div class="join-row">
            <div class="join-label">프로필</div>
            <div class="join-control">
                <img src="/upload/profile/${user.profile_img}" class="profile-preview">
                <input type="file" name="photo">
                <input type="button" value="기존이미지 삭제" onclick="status()"/>
            </div>
        </div>

        <!-- 이름 -->
        <div class="join-row">
            <div class="join-label">이름</div>
            <div class="join-control">
                <input type="text" value="${user.name}" name="name" class="input-box" readonly>
            </div>
        </div>

        <!-- 아이디 -->
        <c:if test="${user.login_id ne null}">
            <div class="join-row">
                <div class="join-label">아이디</div>
                <div class="join-control">
                    <input type="text" value="${user.login_id}" class="input-box" readonly>
                </div>
            </div>
        </c:if>

        <!-- 닉네임 -->
        <div class="join-row">
            <div class="join-label">닉네임</div>
            <div class="join-control"> <input type="text" id="nickname" name="nickname" value="${user.nickname}"
                    class="input-box" onchange="nick()">
                <div id="nick_msg" class="msg-space"></div>
            </div>
        </div>

        <!-- 이메일 -->
        <div class="join-row">
            <div class="join-label">이메일</div>
            <div class="join-control">
                <input type="email" id="email" name="email" value="${user.email}" class="input-box">
                <div id="email_msg" class="msg-space"></div>
            </div>
        </div>

        <!-- 소개글 -->
        <div class="join-row">
            <div class="join-label">소개글</div>
            <div class="join-control">
                <textarea name="member_intro" class="intro-box" maxlength="500"
                    placeholder="자신을 소개해보세요.">${user.member_intro}</textarea>
            </div>
        </div>

        <div class="btn-area"> <input type="button" value="수정하기" class="join-btn" onclick="updateMember(this.form)">
            <input type="button" value="취소" class="cancel-btn" onclick="history.back()">
        </div>

    </form>

</section>