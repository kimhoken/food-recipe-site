<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="/WEB-INF/views/common/is_login.jsp" />

        <html>

        <head>
            <link rel="stylesheet" href="/css/mypage.css" />

            <script>
                //const applicationServerKey = "BDbjVtJHaSNMMaypEcx2MeXmHvfoWISYWzTCj6Ycc7SoaucH53CzsDGAen6O4ENI9eZMmnilVr9r0F-q3OSbsiM";
                const logout = () => {
                    if (confirm("로그아웃 하시겠습니까?")) {
                        fetch("/logout.do", {
                            method: "post",
                            headers: { "Content-Type": "application/json" },
                            body: JSON.stringify({
                                id: "${user.member_id}"
                            })
                        })
                            .then(res => res.json())
                            .then(data => {
                                if (data.result == "success") {
                                    alert("로그아웃 되었습니다.")
                                    location.href = "/main_list.do";
                                }
                            })
                    }
                }

                function updateMember(f){
                    
                    let formdata = new FormData(f);

                    fetch("/mypage.do",{
                        method:'post',                        
                        body:formdata
                    }).then(res=>res.text())
                    .then(data=>{
                        if(data == "fin"){
                            alert("회원 정보가 수정되었습니다.");
                            location.href="/mypage.do?menu=account";
                        }else{
                            alert("수정 실패")
                        }
                    })

                }
            </script>
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
                            <img src="${user.profile_img}" width="85px" height="85px" />
                        </div>
                        <strong>${user.nickname}</strong>
                        <p>맛있는 하루 되세요!</p>
                    </div>

                    <div class="menu-section">
                        <div class="sub-title">회원 정보</div>
                        <div><a href="/mypage.do?menu=account&sel=info">
                                <!-- <img src="/images/user.png" width="32px" height="32px" /> -->
                                회원정보</a></div>
                        <div><a href="/mypage.do?menu=account&sel=pwd">
                                <!-- <img src="/images/padlock.png" width="32px" height="32px" /> -->
                                비밀번호 변경</a></div>
                        <div><a href="/mypage.do?menu=account&sel=del">
                                <!-- <img src="/images/delete_user.png" /> -->
                                회원 탈퇴</a></div>
                    </div>

                    <div class="menu-section">
                        <div class="sub-title">내활동</div>
                        <div><a href="/mypage.do?menu=activity&sel=document">
                                <!-- <img src="images/document2.png" /> -->
                                작성한 레시피</a></div>
                        <div><a href="/mypage.do?menu=activity&sel=comment">
                                <!-- <img src="/images/chat.png" /> -->
                                작성한 댓글</a></div>
                        <div><a href="/mypage.do?menu=activity&sel=bookmark">
                                <!-- <img src="/images/bookmark2.png" /> -->
                                북마크</a></div>
                    </div>

                    <div class="menu-section">
                        <div class="sub-title">고객지원</div>
                        <div><a href="/mypage.do?menu=inquiry">
                                <!-- <img src="/images/help.png" /> -->
                                문의 내역</a></div>
                    </div>

                    <button type="button" onclick="logout()">
                        <img src="/images/logout.png" />
                        로그아웃</button>
                </aside>

                <!-- 마이페이지 오른쪽 부분 -->
                <main class="mypage-right">

                    <div class="page-header">
                        <h2>마이페이지</h2>
                        <p>내활동 내역을 한 눈에 확인하세요!</p>
                    </div>
                    
                    <c:if test="${ sel ne 'update' }">

                        <section class="main-box">
    
                            <div class="main-left">
                                <div class="main-profile-img">
                                    <img src="${user.profile_img}" />
                                </div>
                                <div class="main-profile-text">
    
                                    <h3>${user.nickname}</h3>
                                    <div>${user.member_intro}</div>
    
                                    <!-- <a href="/mypage_info.do?sel=info">프로필 수정</a> -->
                                </div>
                            </div>
    
                            <div class="main-tag">
    
                                <div class="tag-card">
                                    <!-- <img src="/images/document.png" /> -->
                                    <a href="#" class="count-link">12</a>
                                    <span>작성한 레시피</span>
                                </div>
    
                                <div class="tag-card">
                                    <!-- <img src="/images/sms.png" /> -->
                                    <a href="#" class="count-link">12</a>
                                    <span>작성한 댓글</span>
                                </div>
    
                                <div class="tag-card">
                                    <!-- <img src="/images/bookmark.png" /> -->
                                    <a href="#" class="count-link">12</a>
                                    <span>북마크</span>
                                </div>
                            </div>
                        </section>
                    </c:if>

                   <jsp:include page="${contentPage}"/>
                </main>

            </div>


        </body>

        </html>