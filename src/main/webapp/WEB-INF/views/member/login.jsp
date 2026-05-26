<%@ page contentType="text/html;charset=UTF-8" language="java"%>


<!DOCTYPE html>
<html>

    <head>
      <script>
            function send(f){
                let login_id = f.login_id.value;
                let password = f.password.value;

                if(login_id == ""){
                    alert("아이디 입력하세요!!");
                    return;
                }

                if(password == ""){
                    alert("비밀번호 입력하세요!!");
                    return;
                }
                ;
                let formdata= new FormData(f);
                fetch("/login.do", {method:"post", body:formdata})
                .then(res => res.json())
                .then(data =>{
             

                    if(data.res == "no_id"){
                        alert("Wrong id");

                    }else if(data.res == "no_pwd"){
                        alert("Wrong pwd.");

                    }else if(data.res == "login"){
                        alert("welcome "+data.nick+"!!");
                        location.href="/main_page.do";

                    }else{
                        alert("esteregg");
                    }
                })

            }
      </script>
    </head>

    <body>
       <form>
            <table border="1" align="center">
                <caption>LOGIN</caption>
                <tr>
                    <th>ID</th>
                    <td>
                        <input name="login_id" />
                    </td>
                </tr>
                <tr>
                    <th>Password</th> 
                    <td>
                        <input type="password" name="password"/>
                    </td>                
                </tr>
                <tr>
                    <td colspan="2" align="center">

                        <input type="button" value="LOGIN" onclick="send(this.form)"/><br/>

                        <input type="button" value="Register" onclick="location.href='/register_form.do'"/>
                        <input type="button" value="Find ID/PWD" onclick=""/>
                    </td>
                </tr>
            </table>
       </form>
    </body>

</html>
