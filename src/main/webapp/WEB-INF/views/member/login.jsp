<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <!DOCTYPE html>
    <html>

    <head>
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
                            alert("Wrong id");

                        } else if (data.res == "no_pwd") {
                            alert("Wrong pwd.");

                        } else if (data.res == "login") {
                            alert("welcome " + data.nick + "!!");
                            location.href = "/main_list.do";

                        } else {
                            alert("esteregg");
                        }
                    })

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
                                    <input type="password" name="password" placeholder="비밀번호를 입력하세요" />
                                </td>
                            </tr>

                            <tr>
                                <td class="idpwd-area">
                                    <button class="sub-btn" type="button" onclick="">아이디</button>/<input class="sub-btn" type="button" value="비밀번호 찾기" onclick="" />                                    
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

                                    <button type="button" class="social-btn" type="button"  onclick="" >

                                        <img src="images/naver.png" />
                                        
                                        <span>네이버로 로그인</span>
                                        
                                    </button>
                                    
                                    
                                    
                                    <button type="button" class="social-btn" type="button"  onclick="" >
                                        
                                        <img src="images/kakao.png"/>
                                        
                                        <span>카카오로 로그인</span>
                                    </button>
                                    
                                    
                                    <button type="button" class="social-btn" type="button"  onclick="" >
                                        
                                        <img src="images/google.png" />
                                        <span>구글로 로그인</span>
                                    </button>
                                    

                                </td>
                            </tr>
                            <!-- 회원가입  -->
                            <tr>
                                <td colspan="2" align="center" class="sub-btn-area">
                                    <span>계정이 없으신가요?</span>
                                    <input class="regi-btn" type="button" value="회원가입" onclick="location.href='/register_form.do'" />
                                </td>
                            </tr>
                        </table>
                    </td>
                        
                </tr>
            </table>
        </form>
    </body>

    </html>