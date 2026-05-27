<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>

    <head>
      
    </head>

    <body>
       <form>
            <table border="1" align="center">
                <caption>회원 가입</caption>
                <tr>
                    <th>별명</th>
                    <td>
                        <input name="nickname"/>
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
                        <input type="button" value="인증번호 전송" onclick="sendnum()"/>
                    </td>
                </tr>
                <tr>
                    <th>인증번호</th>
                    <td>
                        <input id="authnum" type="number" placeholder="인증번호 입력하세요!!" maxlength="8"  />
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
