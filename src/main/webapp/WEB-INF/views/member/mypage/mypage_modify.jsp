<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <link rel="stylesheet" href="css/mypage_account.css"/>
</head>

<section class="update-page">
    <div class="update-card">

        <h2 class="update-title">회원 정보 수정</h2>
    
        <form action="/mypage_update.do" method="post" enctype="multipart/form-data">
            <input type="hidden" id="filechange" value="no" name="filechange"/>        
            <!-- 프로필 이미지 -->
            <div class="update-row profile-rows">
                <div class="update-label">프로필</div>
                <div class="update-control profile-control">
                    <img src="/upload/profile/${profileuser.profile_img}" class="profile-preview">
                    <input type="file" name="photo" class="file-input">
                    <input type="button" value="기존이미지 삭제" class="img-delete-btn" onclick="status()"/>
                </div>
            </div>
    
            <!-- 이름 -->
            <div class="update-row">
                <div class="update-label">이름</div>
                <div class="update-control">
                    <input type="text" value="${profileuser.name}" name="name" class="update-input" readonly>
                </div>
            </div>
    
            <!-- 아이디 -->
            <c:if test="${profileuser.login_id ne null}">
                <div class="update-row">
                    <div class="update-label">아이디</div>
                    <div class="update-control">
                        <input type="text" value="${profileuser.login_id}" class="update-input" readonly>
                    </div>
                </div>
            </c:if>
    
            <!-- 닉네임 -->
            <div class="update-row">
                <div class="update-label">닉네임</div>
                <div class="update-control"> <input type="text" id="nickname" name="nickname" value="${profileuser.nickname}"
                        class="update-input" onchange="nick()">
                    <div id="nick_msg" class="msg-space"></div>
                </div>
            </div>
    
            <!-- 이메일 -->
            <div class="update-row">
                <div class="update-label">이메일</div>
                <div class="update-control">
                    <input type="email" id="email" name="email" value="${profileuser.email}" class="update-input">
                    <div id="email_msg" class="msg-space"></div>
                </div>
            </div>
    
            <!-- 소개글 -->
            <div class="update-row">
                <div class="update-label">소개글</div>
                <div class="update-control">
                    <textarea name="member_intro" class="update-textarea" maxlength="500"
                        placeholder="자신을 소개해보세요.">${profileuser.member_intro}</textarea>
                </div>
            </div>
    
            <div class="update-btn-area"> <input type="button" value="수정하기" class="update-btn" onclick="updateMember(this.form)">
                <input type="button" value="취소" class="cancel-btn" onclick="history.back()">
            </div>
    
        </form>
    </div>

</section>