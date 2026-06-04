<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>
        <link rel="stylesheet" href="/css/modal.css" />

        <head>
            <script>
                let email_authnumer;
                let email_valid = false;
                let id_valid = false;
                let email_token = false;

                //아이디, 이메일 상태 함수
                function status(val) {

                    if (val == 'id') {

                        id_valid = false;

                    } else if (val == 'email') {

                        email_valid = false;

                    }
                }

                //이메일 인증번호 전송 함수
                function mailcheck(f) {
                    let email = f.email.value;
                    let authNumber = document.getElementById("authNumber");

                    fetch("/mail_check.do", {
                        method: 'post',
                        headers: { 'Content-Type': "application/x-www-form-urlencoded" },
                        body: 'email=' + encodeURI(email)
                    })
                        .then(res => res.json())
                        .then(data => {
                            alert("인증번호가 발송되었습니다.");
                            authNumber.style.display = "inline-block";
                            email_authnumer = data.authNumber;

                        })
                }

                // 이메일 인증번호 검사
                function change_input() {

                    let authnumber = document.getElementById("authnumber").value;
                    let email_msg = document.getElementById("email_msg");

                    if (authnumber == email_authnumer) {
                        email_msg.innerHTML = "인증되었습니다."
                        email_valid = true;
                    } else if (authnumber != email_authnumer) {
                        email_msg.innerHTML = "인증번호가 틀렸습니다."
                    } else {
                        email_msg.innerHTML = "오류발생"
                    }

                }

                //아이디 찾기 함수
                function findid(f) {

                    if (!email_valid) {
                        alert("이메일 입력하세요!");
                        return;
                    }

                    let formdata = new FormData(f);

                    fetch("/findid.do", {
                        method: 'post',
                        body: formdata
                    })
                        .then(res => res.text())
                        .then(data => {
                            alert("아이디는 " + data);
                        })

                }

                //이메일 유효성 검사
                function check() {
                    let email = document.getElementById("email").value;
                    let email_msg = document.getElementById("email_msg");
                    let email_send = document.getElementById("email_send");

                    if (email == "") {
                        email_msg.innerHTML = "이메일 입력하세요";
                    }

                    fetch("/emailfind.do", {
                        method: 'post',
                        headers: { 'Content-Type': "application/x-www-form-urlencoded" },
                        body: 'email=' + email
                    }).then(res => res.json())
                        .then(data => {
                            if (data.result == 'no') {
                                email_msg.innerHTML = data.email + "은 등록되지 않은 이메일입니다.";
                            } else {
                                email_msg.innerHTML = "";
                                email_send.style.display = "inline-block";

                            }
                        })
                }

                // 아이디 존재 유무 검사
                function check_id() {

                    let id = document.getElementById("id").value;
                    let id_msg = document.getElementById("id_msg");

                    if (id == "") {
                        id_msg.innerHTML = "아이디 입력하세요!!";
                        return;
                    }

                    fetch("/check_id.do", {
                        method: 'post',
                        headers: { 'Content-Type': "application/x-www-form-urlencoded" },
                        body: 'login_id=' + id
                    }).then(res => res.json())
                        .then(data => {

                            if (data.id_msg == 'no') {
                                id_msg.innerHTML = "";
                                id_valid = true;
                            } else {
                                id_msg.innerHTML = "등록되지 않은 아이디 입니다.";
                            }

                        })



                }

                // 비밀번호 재설정 이메일 함수
                function resetpwd(f) {

                    let email = f.email.value;
                    let login_id = f.login_id.value;

                    if (!id_valid) {
                        alert("아이디를 입력하세요!");
                        return;
                    }
                    if (email == '') {
                        alert("이메일을 입력하세요!");
                        return;
                    }

                    fetch("/resetpwd.do", {
                        method: "post",
                        headers: { 'Content-Type': "application/x-www-form-urlencoded" },
                        body: 'email=' + email + '&login_id=' + login_id
                    }).then(res => res.json())
                        .then(data => {
                            if (data.result == "success") {
                                alert("이메일로 전송했습니다!!");
                                location.href = 'login.do';
                            } else {
                                alert("이메일주소가 잘못되었습니다.");
                            }
                        })
                }


                function openModal(val, btn) {

                    document.querySelectorAll(".tab-btn").forEach(e => e.classList.remove("active"));
                    btn.classList.add("active");

                    document.getElementById("findModal").style.display = "block";

                    document.getElementById("id_find").style.display = "none";
                    document.getElementById("pwd_find").style.display = "none";

                    if (val == "id") {
                        document.getElementById("id_find").style.display = "block";
                    } else {
                        document.getElementById("pwd_find").style.display = "block";
                    }
                }

                function closeModal() {
                    
                    document.getElementById("findModal").style.display = "none";
                }


            </script>
        </head>

        <body>
            <div id="findModal" class="modal-wrap">

                <div id="modal-box">

                    <input type="button" class="modal-class" value="X" onclick="closeModal()" />

                    <div id="find-tab">
                        <input type="button" class="tab-btn" onclick="openModal('id',this)" value="아이디 찾기" />
    
                        <input type="button" class="tab-btn" onclick="openModal('pwd',this)" value="비밀번호 찾기" />
                    </div>
                    
                    <div id="id_find">
                        <form>
                            <table border="1" align="center">
                                <caption>아이디 찾기</caption>

                                <tr>
                                    <th>이메일</th>
                                    <td>
                                        <input name="email" id="email" oninput="status('email'); check()">
                                        <input id="email_send" type="button" value="인증번호 전송"
                                            onclick="mailcheck(this.form)" style="display: none;" />
                                        <div id="email_msg">Ex) sample@naver.com</div>
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <th></th>
                                    <td>
                                        <div id="authNumber" style="display: none;">
                                            <input id="authnumber" type="number" placeholder="인증번호 6자리" maxlength="6" />
                                            <input type="button" value="인증번호 확인" onclick="change_input()" />
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2" align="center">
                                        <input type="button" onclick="findid(this.form)" value="아이디 찾기" />
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>

                    <div id="pwd_find">
                        <form>
                            <table border="1" align="center">
                                <caption>비밀번호 찾기</caption>
                                <tr>
                                    <th>아이디</th>
                                    <td>
                                        <input name="login_id" id="id" oninput="status('id'); check_id()"
                                            placeholder="아이디 입력하세요" />
                                        <div id="id_msg"></div>
                                    </td>
                                </tr>

                                <tr>
                                    <th>이메일</th>
                                    <td>
                                        <input placeholder="이메일 입력" name="email" id="email"
                                            oninput="status('email'); check()" />
                                        <div id="email_msg"></div>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2" align="center">
                                        <input type="button" value="비밀번호 찾기" onclick="resetpwd(this.form)" />
                                    </td>
                                </tr>

                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </body>

        </html>