//const applicationServerKey = "BDbjVtJHaSNMMaypEcx2MeXmHvfoWISYWzTCj6Ycc7SoaucH53CzsDGAen6O4ENI9eZMmnilVr9r0F-q3OSbsiM";
                const logout = () => {
                    if (confirm("로그아웃 하시겠습니까?")) {
                        fetch("/logout.do", {
                            method: "post",
                            headers: { "Content-Type": "application/json" },
                            body: JSON.stringify({
                                id: "${user.member_id}"
                            })
                        })
                            .then(res => res.json())
                            .then(data => {
                                if (data.result == "success") {
                                    alert("로그아웃 되었습니다.")
                                    location.href = "/main_list.do";
                                }
                            })
                    }
                }
                //파일 선택 유무
                function status() {
                    document.getElementById("filechange").value = "yes";
                }

                // 회원 정보 수정 함수
                function updateMember(f) {
                    //유효성 체크 추가할 예정
                    f.submit();

                }
                //비밀번호 재설정 페이지 확인 함수
                function pwdUserCheck() {

                    let pwd = document.getElementById("pwdUserCheck").value;

                    fetch("/userpwdcheck.do", {
                        method: 'post',
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: 'currpwd=' + encodeURIComponent(pwd)
                    }).then(res => res.text())
                        .then(data => {
                            alert(data);
                            if (data === "ok") {
                                document.querySelector("#pwd_box").style.display = "none";
                                document.querySelector("#pwd_reset_box").style.display = "block";
                            } else {
                                alert("현재 비밀번호가 일치 하지 않습니다.");
                            }
                        })

                }

                let pwd_valid = false;
                //비밀번호 재설정
                function send(f) {

                    if (!pwd_valid) {
                        alert("비밀번호 입력하세요!!");
                        return;
                    }

                    let pwd = f.pwd.value;
                    let pwd_check = f.pwd_check.value;

                    fetch("/resetpwdpage.do", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: 'password=' + encodeURIComponent(pwd)
                    })
                        .then(res => res.text())
                        .then(data => {

                            if (data.trim() == "success") {

                                alert("비밀번호가 재설정되었습니다.");
                                location.href = "/mypage?menu=account";

                            } else {

                                alert("비밀번호 재설정에 실패했습니다. 다시 시도해주세요.");

                            }
                        })

                }

                //비밀번호 유효성 검사
                function pwdchange() {

                    let pwd = document.getElementById("pwd").value;
                    let pwd_check = document.getElementById("pwd_check").value;
                    let pwd_msg = document.getElementById("pwd_msg");
                    let pwd_check_msg = document.getElementById("pwd_check_msg");

                    fetch("/pwd_check.do",
                        {
                            method: 'post',
                            headers: { 'Content-Type': "application/x-www-form-urlencoded" },
                            body: 'pwd=' + encodeURIComponent(pwd) +
                                '&pwd_check=' + encodeURIComponent(pwd_check)
                        })
                        .then(res => res.json())
                        .then(data => {

                            if (data.pwd_msg == "no") {

                                pwd_msg.innerHTML = '영문 특수문자 포함 10자 이상 포함되야 합니다.';

                            } else if (data.pwd_msg == "yes") {

                                pwd_msg.innerHTML = '사용가능합니다.';
                                document.getElementById("pwd_check").focus();

                            } else {
                                pwd_msg.innerHTML = "오류 발생";
                            }

                            if (data.pwd_check_msg == "no") {

                                pwd_check_msg.innerHTML = '일치하지 않습니다.';

                            } else if (data.pwd_check_msg == "yes") {

                                pwd_check_msg.innerHTML = '일치합니다.';
                                pwd_valid = true;

                            } else {
                                pwd_check_msg.innerHTML = "오류 발생";
                            }


                        })

                }

                function agree() {
                    let agree_box = document.getElementById("agree_box");
                    agree_box.checked = !agree_box.checked;
                }

                function disableuser(f) {

                    if (!agree) {
                        alert("동의 해주세요");
                        return;
                    }

                    let formdata = new FormData(f);

                    fetch("/secessionUser.do", {
                        method: 'post',
                        body: formdata
                    }).then(res => res.text())
                        .then(data => {
                            if(data == "yes"){
                                alert("계정 탈퇴 완료");
                                location.href="main_list.do";
                            }else{
                                alert("실패");
                            }
                        })
                }
