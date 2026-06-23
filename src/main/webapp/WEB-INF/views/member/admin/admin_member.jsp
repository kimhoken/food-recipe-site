<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <head>
            <link rel="stylesheet" href="${pageContent.request.contentPath}/css/admin_member.css" />

            <script>
                function member_view(member_id) {
                    fetch("/admin/member/info", {
                        method: 'post',
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: 'member_id=' + member_id
                    }).then(res => res.json())
                        .then(dto => {
                            console.log(dto);

                            filemember(dto);

                            // 회원 정지 상태 변경 함수
                            document.querySelector(".ma-btn-stop").onclick=
                            ()=> memberStop(dto.member_id);
                            
                            // 신고 내역 보려 가는 함수 추가할 예정
                            document.querySelector(".ma-btn-report").onclick=
                            ()=> memberReport(dto.member_id);
                        })
                }

                function filemember(dto) {
                    setImg(dto.profile_img);
                    setText(dto.name, "name");
                    setText(dto.member_intro, "intro");
                    setText(dto.nickname, "nickname");
                    setText(dto.login_id, "id");
                    setText(dto.email, "email");
                    setText(dto.report_count, "report");                    
                    setText(dto.created_date, "date");
                    setText(dto.recipe_count, "recipe");
                    setText(dto.comment_count, "comment");
                    setText(dto.bookmark_count, "bookmark");
                    setText(dto.like_count, "like");
                    setText("신고 구현후 추가 예정", "up-report");

                    if(dto.status === 'ACTIVE'){
                        document.querySelector(".model-status").textContent = "정상";
                        document.querySelector(".ma-btn-stop").value = "회원 정지";
                    }else if(dto.status === 'SUSPEND'){
                        document.querySelector(".model-status").textContent = "정지";
                        document.querySelector(".ma-btn-stop").value = "회원 정지 해제";
                    }

                    if(dto.role === 'ADMIN'){
                        document.querySelector(".ma-btn-rank").value = "일반 회원 변경";
                    }else if(dto.role === 'USER'){
                        document.querySelector(".ma-btn-rank").value = "관리자 회원 변경";
                    }

                }

                function setText(value, element) {
                    document.querySelector(".model-" + element).textContent = value;
                }
                function setImg(value) {
                    document.querySelector(".ma-detail-img").src = "/upload/profile/" + value;
                }

                function searchmember() {
                    document.querySelector('form[action="/admin/member"]').submit();
                }

                function entersearch(e) {

                    if (e.key === "Enter") {
                        searchmember();
                    }

                }
                
                function memberStop(id){
                    if(!confirm("정지 시키시겠습니까?")){
                        return;
                    }

                    fetch("/admin/member/stop",{
                        method:'post',
                        headers:{"Content-Type": "application/x-www-form-urlencoded"},
                        body: 'member_id='+id
                    }).then(res=> res.json())
                    .then(data =>{
                        if(data.status === "SUSPEND" && data.result > 0){
                            alert(data.nickname+"은 정지되었습니다.");
                        }else if(data.status === "ACTIVE" && data.result > 0){
                            alert(data.nickname+"은 정지 해제 되었습니다.");
                        }else{
                            alert("이스터 에그 발견!");
                        }
                    })
                }

            </script>
        </head>
        <section class="ma-container">
            <div class="ma-wrap">
                <div class="ma-header">
                    <h3 class="ma-title">회원 관리</h3>
                    <small class="ma-subtitle">전체 회원 목록 및 상세 정보를 확인 할수 있습니다.</small>
                </div>

                <div class="ma-content">
                    <div class="ma-list-panel">
                        <form action="/admin/member" method="get">

                            <div class="ma-filter">

                                <input type="text" class="ma-search" name="keyword" placeholder="아이디, 닉네임, 이메일 검색"
                                    onkeydown="entersearch(event)" />

                                <select class="ma-status" name="status" onchange="searchmember()">
                                    <option value="">상태</option>
                                    <option value="ACTIVE" ${adminmember.status eq 'ACTIVE' ? 'selected' : '' }>정상</option>
                                    <option value="SUSPEND" ${adminmember.status eq 'SUSPEND' ? 'selected' : '' }>정지</option>
                                    <option value="WITHDRAW" ${adminmember.status eq 'WITHDRAW' ? 'selected' : '' }>탈퇴</option>
                                </select>

                                <select class="ma-role" name="role" onchange="searchmember()">
                                    <option value="">등급</option>
                                    <option value="ADMIN" ${adminmember.role eq 'ADMIN' ? 'selected' : '' }>관리자</option>
                                    <option value="USER" ${adminmember.role eq 'USER' ? 'selected' : '' }>회원</option>
                                </select>

                            </div>

                            <table class="ma-table">
                                <tr>
                                    <th>프로필</th>
                                    <th>닉네임</th>
                                    <!-- 아이디 일반 회원은 실제 아이디 출력, 소셜 회원은 가입한 플랫폼 출력  -->
                                    <th>아이디</th>
                                    <th>이메일</th>
                                    <th>등급</th>
                                    <th>신고수</th>
                                    <th>상태</th>
                                    <th>가입일</th>
                                </tr>

                                <!-- forEach문으로 회원 출력 -->
                                <tbody>
                                    <c:forEach var="member" items="${list}">

                                        <tr class="ma-row" onclick="member_view('${member.member_id}')">
                                            <td>
                                                <img class="ma-profile-img"
                                                    src="/upload/profile/${member.profile_img}" />
                                            </td>
                                            <td>${member.nickname}</td>
                                            <td>
                                                <c:if test="${!member.provider}">
                                                    ${member.provider}
                                                </c:if>
                                                <c:if test="${!member.login_id}">
                                                    ${member.login_id}
                                                </c:if>
                                            </td>
                                            <td>${member.email}</td>
                                            <td>
                                                <c:if test="${member.role eq 'ADMIN'}">
                                                    관리자
                                                </c:if>
                                                <c:if test="${member.role eq 'USER'}">
                                                    일반 회원
                                                </c:if>
                                            </td>
                                            <td>
                                                <span class="ma-report-count">${member.report_count}</span>
                                            </td>
                                            <td>
                                                <c:if test="${member.status eq 'ACTIVE'}">
                                                    <span class="ma-badge ma-active">정상</span>
                                                </c:if>

                                                <c:if test="${member.status eq 'SUSPEND'}">
                                                    <span class="ma-badge ma-active">정지</span>
                                                </c:if> 

                                                <c:if test="${member.status eq 'WITHDRAW'}">
                                                    <span class="ma-badge ma-active">탈퇴</span>
                                                </c:if>
                                            </td>
                                            <td>${member.created_date}</td>
                                        </tr>

                                    </c:forEach>


                                </tbody>
                            </table>

                            <footer class="ma-footer">
                                <div class="ma-total">총 회원수: ${totalcount}명</div>
                                <div class="ma-paging">
                                    <c:set var="pageUrl"
                                        value="/admin/member?keyword=${admin.keyword}&status=${admin.status}&role=${admin.role}"
                                        scope="request" />
                                    <jsp:include page="/WEB-INF/views/common/paging.jsp" />
                                </div>
                            </footer>
                        </form>

                    </div>
                </div>

                <div class="ma-detail-panel">
                    <div class="ma-detail-header">
                        <h3>프로필</h3>
                    </div>

                    <div class="ma-profile-box">
                        <img class="ma-detail-img" src="" />
                        <div class="ma-profile-info">
                            <strong class="model-name">라이언</strong>
                            <small class="model-intro">자기소개</small>
                        </div>

                    </div>

                    <dl class="ma-detail-list">

                        <dt>닉네임</dt>
                        <dd class="model-nickname"></dd>

                        <dt>아이디</dt>
                        <dd class="model-id"></dd>

                        <dt>이메일</dt>
                        <dd class="model-email"></dd>

                        <dt>신고수</dt>
                        <dd class="model-report"></dd>

                        <dt>상태</dt>
                        <dd class="model-status"></dd>

                        <dt>가입일</dt>
                        <dd class="model-date"></dd>

                        <dt>작성 레시피 수</dt>
                        <dd class="model-recipe"></dd>

                        <dt>작성 댓글 수</dt>
                        <dd class="model-comment"></dd>

                        <dt>북마크 수</dt>
                        <dd class="model-bookmark"></dd>

                        <dt>좋아요 수</dt>
                        <dd class="model-like"></dd>

                        <dt>신고 누적 수</dt>
                        <dd class="model-up-report"></dd>



                    </dl>

                    <div class="ma-action">
                        <input type="button" class="ma-btn ma-btn-stop" value="" onclick=""/>
                        <input type="button" class="ma-btn ma-btn-report" value="신고 내역 보기"  onclick=""/>
                        <input type="button" class="ma-btn ma-btn-rank" value="" onclick=""/>
                    </div>

                </div>

            </div>
        </section>