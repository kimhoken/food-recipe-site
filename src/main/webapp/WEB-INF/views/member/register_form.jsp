<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>

    <head>
        <script>
            function send(f){

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

                if(password == ""){
                    alert("비밀번호를 입력하세요!!");
                    f.password.focus();
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
                    if(data.res== 1){
                        alert("회원 가입 성공!!");
                        location.href = '/login.do';
                    } else {
                        alert("회원 가입 실패!!");
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
                        <input name="nickname" placeholder="별명을 입력하세요(ex 말랑포동푸딩)"/>
                        <div id="nick_msg"></div>
                    </td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td>
                        <input name="login_id" id="id"/>
                        <input type="button" value="중복검사" onclick="" placeholder="아이디 입력하세요!!"/>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td>
                        <input name="password" type="password" id="pwd"/>
                        <div id="pwd_str"></div>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호 확인</th>
                    <td>
                        <input name="pwd" id="pwd_check" type="password" placeholder="비밀번호 입력하세요"/>
                    </td>
                </tr>

                <tr>
                    <th>이메일</th>
                    <td>
                        <input id="email" name="email"/>
                        <input type="button" value="본인인증" onclick="mailcheck()"/>

                        <br/>
                        <input id="authnum" type="number" placeholder="인증번호 6자리" maxlength="6"/>
                        <input type="button" value="인증번호 확인" onclick="change_input()"/>
                    </td>
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
