<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/member/findmodal.jsp"%>

    <!DOCTYPE html>
    <html>

    <head>
        <title>오늘 뭐 먹지? - 로그인</title>
        <link rel="stylesheet" href="/css/login.css" />
        
        <script>
            //로그인 유효성 및 로그인 상태
            function send(f) {
                let login_id = f.login_id.value;
                let password = f.password.value;

                if (login_id == "") {
                    alert("아이디 입력하세요!!");
                    return;
                }

                if (password == "") {
                    alert("비밀번호 입력하세요!!");
                    return;
                }
                ;
                let formdata = new FormData(f);
                fetch("/login.do", { method: "post", body: formdata })
                    .then(res => res.json())
                    .then(data => {

                        if (data.res == "no_id") {
                            alert("아이디가 없거나 틀렸습니다.");

                        } else if (data.res == "no_pwd") {
                            alert("비밀번호가 틀렸습니다.");

                        } else if (data.res == "login") {
                            alert("환영합니다 " + data.nick + "님!!");
                            location.href = "/main_list.do";

                        } else {
                            alert("esteregg");
                        }
                    })
            }

            function viewpwd() {

                let pwd = document.getElementById("pwd");
                let visual = document.getElementById("visual");
                let unvisual = document.getElementById("unvisual");

                if (pwd.type === "password") {
                    pwd.type = "text";
                    visual.style.display = "none";
                    unvisual.style.display = "block";
                } else {
                    pwd.type = "password";
                    visual.style.display = "block";
                    unvisual.style.display = "none";
                }
            }

            
        </script>
    </head>

    <body>
        <form>
            <table class="login-wrap" align="center">
                <tr>
                    <td class="login-left">
                        <img src="/images/login_bg.png" class="login-img" />
                    </td>

                    <td class="login-right">
                        <table class="login-table" align="left">
                            <caption>로그인</caption>
                            <tr>
                                <th>아이디</th>
                            </tr>

                            <tr>
                                <td>
                                    <input name="login_id" placeholder="아이디를 입력하세요" />
                                </td>
                            </tr>

                            <tr>
                                <th>비밀번호</th>
                            </tr>

                            <tr>
                                <td>
                                    <div class="pwd-warp">

                                        <input type="password" name="password" id="pwd" placeholder="비밀번호를 입력하세요" />
    
                                        <button type="button" id="visual" class="toggle" onclick="viewpwd()">
                                            <img src="/images/visibility.png"/>
                                        </button>
        
                                        <button type="button" id="unvisual" class="toggle" onclick="viewpwd()">
                                            <img src="/images/unvisibility.png"/>
                                        </button>

                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td class="idpwd-area">
                                    <button class="sub-btn" type="button"
                                        onclick="openModal('id',this)">아이디</button>
                                    <span>/</span>
                                    <input class="sub-btn" type="button" value="비밀번호 찾기"
                                        onclick="openModal('pwd',this)" />
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2" align="center">
                                    <input class="login-btn" type="button" value="로그인" onclick="send(this.form)" />
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <!-- 소셜 로그인  -->
                                    <div class="line-area">
                                        <div class="line"></div>
                                        <span>또는</span>
                                        <div class="line"></div>
                                    </div>

                                    <button type="button" class="social-btn" type="button" onclick="location.href='/oauth2/authorization/naver'">
                                        <img src="images/naver.png" />
                                        <span>네이버로 로그인</span>
                                    </button>

                                    <button type="button" class="social-btn" type="button" onclick="location.href='/oauth2/authorization/kakao'">
                                        <img src="images/kakao.png" />
                                        <span>카카오로 로그인</span>
                                    </button>

                                    <button type="button" class="social-btn" type="button" onclick="location.href='/oauth2/authorization/google'">
                                        <img src="images/google.png" />
                                        <span>구글로 로그인</span>
                                    </button>
                                </td>
                            </tr>

                            <!-- 회원가입  -->
                            <tr>
                                <td colspan="2" align="center" class="sub-btn-area">
                                    <span>계정이 없으신가요?</span>
                                    <input class="regi-btn" type="button" value="회원가입"
                                        onclick="location.href='/register_form.do'" />
                                </td>
                            </tr>
                        </table>
                    </td>

                </tr>
            </table>
        </form>

        
    </body>

    </html>