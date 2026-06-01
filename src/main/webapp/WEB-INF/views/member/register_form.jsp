<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>

    <head>
        <title>오늘 뭐 먹지? - 회원가입</title>
        <link rel="stylesheet" href="css/register_form.css"/>
        <script>
            let id_vailed = false;
            let pwd_vailed = false;
            let email_vailed = true;
            let nickname_vailed = true;

            window.onload = function(){
                let nickname = document.getElementById("nickname");
                nickname.value = '${nickname}';
            }

            let email_authnumer;

            function status(){
                id_vailed = false;
            }

            //아이디 중복 검사
            function id_check(){

                let id = document.getElementById("id");
                let id_msg = document.getElementById("id_msg");
                
                if( id.value == ""){
                    id_msg.innerHTML = "아이디 입력하세요"; 
                    id.focus();
                    return;
                }

                fetch("/check_id.do",{
                    method:'post',
                    headers:{'Content-Type': "application/x-www-form-urlencoded"},
                    body:'login_id=' + encodeURIComponent(id.value)
                })
                .then(res => res.json())
                .then(data =>{
                    
                    if(data.id_msg == "yes"){

                        id_msg.innerHTML = data.id+"는 사용가능합니다";
                        id_vailed = true;

                    }else if(data.id_msg == 'no'){

                        id_msg.innerHTML = data.id+"는 이미 사용중인 아이디 입니다.";   
                        return;                     

                    }else{
                        id_msg.innerHTML = "오류가 발생했습니다";
                    }

                })
            }

            //비밀번호 확인 함수
            function pwd_checks(){                
                let pwd = document.getElementById("pwd").value;
                let pwd_check = document.getElementById("pwd_check").value;
                let pwd_msg = document.getElementById("pwd_msg");
                let pwd_check_msg =document.getElementById("pwd_check_msg");

                fetch("/pwd_check.do",
                    { method:'post',
                        headers:{'Content-Type': "application/x-www-form-urlencoded"},
                        body:'pwd='+ encodeURIComponent(pwd)+
                        '&pwd_check=' + encodeURIComponent(pwd_check) 
                    })
                    .then(res => res.json())
                    .then(data =>{
                        
                        if(data.pwd_msg == "no"){

                            pwd_msg.innerHTML = '영문 특수문자 포함 10자 이상 포함되야 합니다.';

                        }else if(data.pwd_msg == "yes"){
                            
                            pwd_msg.innerHTML = '사용가능합니다.';
                            document.getElementById("pwd_check").focus();

                        }else{
                            pwd_msg.innerHTML ="오류 발생";
                        }

                        if(data.pwd_check_msg == "no"){

                            pwd_check_msg.innerHTML = '일치하지 않습니다.';

                        }else if(data.pwd_check_msg == "yes"){
                            
                            pwd_check_msg.innerHTML = '일치합니다.';
                            pwd_vailed=true;

                        }else{
                            pwd_check_msg.innerHTML = "오류 발생";
                        }

                        
                    })               

            }

            //회원 가입 함수
            function send(f){

                if(!id_vailed){
                    alert("아이디 중복 검사가 필요합니다.");
                    f.login_id.focus();
                    return;
                }

                if(!pwd_vailed){
                    alert("비밀번호 입력하세요.");
                    f.password.focus();
                    return;
                }

                let name = f.name.value;
                let login_id = f.login_id.value;
                let password = f.password.value;
                let email = f.email.value;

                if(name == ""){
                    alert("이름을 입력하세요!!");
                    f.name.focus();
                    return ;
                }

                if(login_id == ""){
                    alert("아이디를 입력하세요!!");
                    f.login_id.focus();
                    return ;
                }           

                if(email == ""){
                    alert("이메일을 입력하세요!!");
                    f.email.focus();
                    return ;
                }

                let formData = new FormData(f);

                fetch('/register.do',{
                    method:'post',
                    body: formData
                }).then(res => res.json())
                .then(data => {
                    if( data.res == 1 ) {
                        alert("회원 가입 성공!!");
                        location.href = '/login.do';
                    } else {
                        alert("회원 가입 실패!!");
                    }
                })

            }

            //이메일 인증번호 전송 함수
            function mailcheck(f){
                let email = f.email.value;

                fetch("/mail_check.do",{
                    method:'post',
                    headers:{'Content-Type': "application/x-www-form-urlencoded"},
                    body: 'email='+encodeURI(email)
                })
                .then( res => res.json())
                .then( data => {
                    alert("인증번호가 발송되었습니다.");

                    email_authnumer = data.authNumber;                    
                })
            }

            // 이메일 인증번호 검사
            function change_input() {

                let authnumber = document.getElementById("authnumber").value;
                let email_msg = document.getElementById("email_msg");

                if(authnumber == email_authnumer){
                    email_msg.innerHTML = "인증되었습니다."
                    email_vailed =true;
                }else if(authnumber != email_authnumer ){
                    email_msg.innerHTML = "인증번호가 틀렸습니다."
                }else{
                    email_msg.innerHTML = "오류발생"
                }

            } 
            //닉네임 중복 처리 함수(사용자가 임의의 닉네임 입력시 )
            function nick(){
                let nickname = document.getElementById("nickname").value;
                let nick_msg = document.getElementById("nick_msg");

                fetch("/check_nickname.do",
                    {method:'post',
                    headers:{'Content-Type': "application/x-www-form-urlencoded"},
                    body:'nickname='+nickname   
                    })
                    .then(res => res.json())
                    .then(data =>{

                        if(data.nickname_msg == "yes"){

                            nick_msg.innerHTML="이미 있는 닉네임입니다.";     
                            nickname_vailed = false;              

                        }else if(data.nickname_msg == "no"){

                            nick_msg.innerHTML= data.nickname+"은 사용가능합니다.";
                            nickname_vailed = true;

                        }
                })
            }
        </script>
    </head>

    <body>
        <form>            
            <table border="1" align="center">
                <caption>회원 가입</caption>

                <tr>
                    <th>이름</th>
                    <td>
                        <input name="name"/>
                    </td>
                </tr>
                <tr>
                    <th>닉네임</th>
                    <td>
                        <input name="nickname" id="nickname" placeholder="별명을 입력하세요(ex 말랑포동푸딩)" onchange="nick()"/>
                        <div id="nick_msg"></div>
                    </td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td>
                        <input name="login_id" id="id" placeholder="아이디 입력하세요" onchange="status(); id_check()"/>
                        <div id="id_msg"></div>                        
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td>
                        <input name="password" type="password" id="pwd" placeholder="비밀번호 입력하세요" onchange="pwd_checks()"/>
                        <div id="pwd_msg"></div>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호 확인</th>
                    <td>
                        <input id="pwd_check" type="password" placeholder="비밀번호 입력하세요" onchange="pwd_checks()"/>
                        <div id="pwd_check_msg"></div>
                    </td>
                </tr>

                <tr>
                    <th>이메일</th>
                        <form>
                            <td>
                                <input name="email"/>
                                <input type="button" value="본인인증" onclick="mailcheck(this.form)"/>
        
                                <br/>
                                <input id="authnumber" type="number" placeholder="인증번호 6자리" maxlength="6"/>
                                <input type="button" value="인증번호 확인" onclick="change_input()"/>
                                <div id="email_msg"></div>
                            </td>
                        </form>
                </tr>
                
                <tr>
                    <td colspan="2" align="center">
                        <input type="button" value="회원 가입" onclick="send(this.form)" />
                        <input type="button" value="취소" onclick="history.back()" />
                    </td>
                </tr>

            </table>
        </form>
    </body>

</html>
