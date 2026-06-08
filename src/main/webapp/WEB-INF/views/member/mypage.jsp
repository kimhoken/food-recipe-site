<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/is_login.jsp"/>    

        <html>

        <head>
            <link rel="stylesheet" href="/css/mypage.css"/>
        </head>

        <body>
            <div class="mypage-wrap">

                <!-- 마이페이지 왼쪽 메뉴 부분 -->
                <aside class="mypage-left">

                    <div class="logo-box">
                        <a href="main_list.do">
                            <img src="/images/logo.png" width="200px" height="50px" />
                        </a>
                    </div>
                    
                    <div class="profile-mini">
                        <div class="profile-img">
                            <img src="/images/no_file.png" width="85px" height="85px"/>
                        </div>
                        <strong>${user.nickname}</strong>
                        <p>맛있는 하루 되세요!</p>
                    </div>
                        
                    <div class="menu-section">
                        <div class="sub-title">회원 정보</div>
                        <div><a href="/mypage_info.do?sel=info">
                            <img src="/images/user.png" width="32px" height="32px"/>
                            회원정보</a></div>
                        <div><a href="/mypage_info.do?sel=pwd">
                            <img src="/images/padlock.png" width="32px" height="32px"/>
                            비밀번호 변경</a></div>
                        <div><a href="/mypage_info.do?sel=del">
                            <img src="/images/delete_user.png"/>
                            회원 탈퇴</a></div>
                    </div>
                    
                    <div class="menu-section">
                        <div class="sub-title">내활동</div>
                        <div><a href="#">
                            <img src="images/document2.png"/>
                            작성한 레시피</a></div>
                        <div><a href="#">
                            <img src="/images/chat.png"/>
                            작성한 댓글</a></div>
                        <div><a href="#">
                            <img src="/images/bookmark2.png"/>
                            북마크</a></div>
                    </div>
                    
                    <div class="menu-section">
                        <div class="sub-title">고객지원</div>
                        <div><a href="#">
                            <img src="/images/help.png"/>
                            문의 내역</a></div>
                    </div>

                    <button type="button" onclick="location.href='/logout.do'">
                        <img src="/images/logout.png"/>
                        로그아웃</button>
                </aside>

                <!-- 마이페이지 오른쪽 부분 -->
                <main class="mypage-right">

                    <div class="page-header">
                        <h2>마이페이지</h2>
                        <p>내활동 내역을 한 눈에 확인하세요!</p>
                    </div>

                    <section class="main-box">

                        <div class="main-left">
                            <div class="main-profile-img">
                                <img src="/images/no_file.png"/>
                            </div>
                            <div class="main-profile-text">

                                <h3>${user.nickname}</h3>
                                <div>소개글 해주세요!</div>
                                
                                <a href="#">프로필 수정</a>
                            </div>
                        </div>

                        <div class="main-tag">

                            <div class="tag-card">
                                <img src="/images/document.png"/>
                                <a href="#" class="count-link">12</a>
                                <span>작성한 레시피</span>
                            </div>

                            <div class="tag-card">
                                <img src="/images/sms.png"/>
                                <a href="#" class="count-link">12</a>
                                <span>작성한 댓글</span>
                            </div>

                            <div class="tag-card">
                                <img src="/images/bookmark.png"/>
                                <a href="#" class="count-link">12</a>
                                <span>북마크</span>
                            </div>
                        </div>
                    </section>

                </main>

            </div>


        </body>

        </html>