<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/css/inquiry.css">

        <script>
            function send(f) {
                const type = f.type.value.trim();
                const title = f.title.value.trim();
                const content = f.content.value.trim();

                if (type === "") {
                    alert("문의 유형을 선택하세요.");
                    f.type.focus();
                    return;
                }

                if (title === "") {
                    alert("제목을 입력하세요.");
                    f.title.focus();
                    return;
                }

                if (title.length > 100) {
                    alert("제목은 100자 이하로 입력하세요.");
                    f.title.focus();
                    return;
                }

                if (content === "") {
                    alert("내용을 입력하세요.");
                    f.content.focus();
                    return;
                }

                if (f.guest_name) {
                    const guestName = f.guest_name.value.trim();
                    const guestEmail = f.guest_email.value.trim();
                    const guestPassword = f.guest_password.value.trim();

                    const nameRegex = /^[가-힣a-zA-Z]{2,20}$/;
                    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{8,20}$/;

                    if (guestName === "") {
                        alert("이름을 입력하세요.");
                        f.guest_name.focus();
                        return;
                    }

                    if (!nameRegex.test(guestName)) {
                        alert("이름은 한글 또는 영문 2~20자로 입력하세요.");
                        f.guest_name.focus();
                        return;
                    }

                    if (guestEmail === "") {
                        alert("이메일을 입력하세요.");
                        f.guest_email.focus();
                        return;
                    }

                    if (!emailRegex.test(guestEmail)) {
                        alert("이메일 형식이 올바르지 않습니다.");
                        f.guest_email.focus();
                        return;
                    }

                    if (guestPassword === "") {
                        alert("비밀번호를 입력하세요.");
                        f.guest_password.focus();
                        return;
                    }

                    if (!passwordRegex.test(guestPassword)) {
                        alert("비밀번호는 영문과 숫자를 포함해 8~20자로 입력하세요.");
                        f.guest_password.focus();
                        return;
                    }
                }
                const agree = document.getElementById("agree");

                if (!agree.checked) {
                    alert("개인정보 수집 및 이용에 동의해주세요.");
                    agree.focus();
                    return;
                }

                f.submit();
            }
            function openAgreeModal() {
                document.getElementById("agreeModal").style.display = "flex";
            }

            function closeAgreeModal() {
                document.getElementById("agree").checked = false;
                document.getElementById("agreeModal").style.display = "none";
            }

            function agreeAndCloseModal() {
                document.getElementById("agree").checked = true;
                document.getElementById("agreeModal").style.display = "none";
            }
        </script>
    </head>

    <body>
        <div class="inquiry-page">
            <div class="inquiry-title-box">
                <span class="inquiry-label">CONTACT</span>
                <h2>문의하기</h2>
                <p>
                    궁금한 점이 있으시면 언제든지 문의해 주세요.<br>
                    빠르고 친절하게 답변드리겠습니다.
                </p>
            </div>

            <form action="/inquiry" method="post" enctype="multipart/form-data" class="inquiry-form">
                <table class="inquiry-table">
                    <tr>
                        <th>유형</th>
                        <td>
                            <select name="type">
                                <option value="">선택</option>
                                <option value="계정">계정</option>
                                <option value="레시피 문의">레시피 문의</option>
                                <option value="서비스 이용 문의">서비스 이용 문의</option>
                                <option value="기타">기타</option>
                            </select>
                        </td>
                    </tr>

                    <c:if test="${not empty sessionScope.user}">
                        <tr>
                            <th>이름</th>
                            <td>
                                <input type="text" value="${sessionScope.user.nickname}" readonly>
                                <input type="hidden" name="member_id" value="${sessionScope.user.member_id}">
                            </td>
                        </tr>
                    </c:if>

                    <c:if test="${empty sessionScope.user}">
                        <tr>
                            <th>이름</th>
                            <td>
                                <input type="text" name="guest_name" placeholder="이름을 입력하세요">
                            </td>
                        </tr>

                        <tr>
                            <th>이메일</th>
                            <td>
                                <input type="email" name="guest_email" placeholder="example@email.com">
                            </td>
                        </tr>

                        <tr>
                            <th>비밀번호</th>
                            <td>
                                <input type="password" name="guest_password" placeholder="영문과 숫자 포함 8~20자">
                            </td>
                        </tr>
                    </c:if>

                    <tr>
                        <th>제목</th>
                        <td>
                            <input type="text" name="title" maxlength="200" placeholder="제목을 입력하세요">
                        </td>
                    </tr>

                    <tr>
                        <th>내용</th>
                        <td>
                            <textarea name="content" rows="8" placeholder="문의 내용을 입력하세요"></textarea>
                        </td>
                    </tr>

                    <tr>
                        <th>파일 첨부</th>
                        <td>
                            <input type="file" name="image" multiple>
                        </td>
                    </tr>
                    
                    <tr>
                        <th>개인정보 수집</th>
                        <td>
                            <div class="agree-row">
                                <label class="agree-radio">
                                    <input type="checkbox" name="privacy_agree" value="Y" id="agree">
                                    <span></span>
                                    개인정보 수집 및 이용에 동의합니다.
                                </label>

                                <button type="button" class="agree-detail-btn" onclick="openAgreeModal()">
                                    자세히 &gt;
                                </button>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2" class="btn-area">
                            <input type="button" class="submit-btn" value="문의하기" onclick="send(this.form)"/>
                            <input type="button" class="cancel-btn" value="취소" onclick="history.back()"/>
                        </td>
                    </tr>
                </table>
            </form>
            <div class="agree-modal-bg" id="agreeModal">
                <div class="agree-modal">
                    <div class="agree-modal-header">
                        <h3>개인정보 수집 및 이용 안내</h3>
                        <button type="button" onclick="closeAgreeModal()">×</button>
                    </div>

                    <div class="agree-modal-content">
                        <p><strong>수집 항목</strong></p>
                        <p>이름, 이메일, 문의 제목, 문의 내용, 첨부파일</p>

                        <p><strong>수집 목적</strong></p>
                        <p>문의 접수, 본인 확인, 답변 제공</p>

                        <p><strong>보유 기간</strong></p>
                        <p>문의 처리 완료 후 1년간 보관 후 파기</p>

                        <p class="agree-modal-note">
                            개인정보 수집 및 이용에 동의하지 않을 경우 문의 접수가 제한될 수 있습니다.
                        </p>
                    </div>

                    <div class="agree-modal-footer">
                        <button type="button" onclick="agreeAndCloseModal()">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>