<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>

    <head>
      
        <script>
            function send(f){
                let pwd = f.pwd.value;
                let pwd_check = f.pwd_check.value;
                if(pwd == "" || pwd_check == ""){
                    alert("비밀번호를 입력하세요");
                    return;
                }
                if(pwd != pwd_check){
                    alert("비밀번호가 일치하지 않습니다.");
                    return;
                }
                fetch("/repwd.do",{
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: 'password=' + encodeURIComponent(pwd) + '&member_id=' + '${member.member_id}'
                    }).then(res => res.text())
                .then(data => {
                    if(data.trim() == "success"){
                        alert("비밀번호가 재설정되었습니다.");
                        location.href = "/login.do";
                    }else{
                        alert("비밀번호 재설정에 실패했습니다. 다시 시도해주세요.");
                    }
                })
            }
        </script>

    </head>

    <body>
       <c:if test="${not empty msg}">
            <script>
                alert("${msg}");
            </script>
        </c:if>
        <form>
            <table border="1" align="center">
                <caption><h2>비밀번호 재설정</h2></caption>
                <tr>
                    <th>비밀번호</th>
                    <td><input type="password" name="pwd" placeholder="비밀번호 입력하세요"/></td>
                </tr>
                <tr>
                    <th>비밀번호 확인</th>
                    <td><input type="password" name="pwd_check" placeholder="비밀번호 확인 입력하세요"/></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="button" value="비밀번호 재설정" onclick="send(this.form)"/>
                    </td>
                </tr>
        </form>
    </body>

</html>