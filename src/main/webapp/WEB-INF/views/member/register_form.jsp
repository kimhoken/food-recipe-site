<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/main.css"/>
        <link rel="stylesheet" href="css/register_from.css"/>
        <link rel="stylesheet" href="/css/chatbot.css" />

        <script src="/js/chatbot.js"></script>
        <script>
            const nickname = '${nickname}';
        </script>
        <script src="/js/register.js"></script>
    </head>

    <body>
        <jsp:include page="/WEB-INF/views/common/navibar.jsp"/>
        <form class = "join-form">      
            <div class="join-wrap">

                <!-- 왼쪽 이미지 영역 -->
                <div class="join-left">
                    <div class="join-icon">🍲</div>
                    <h2>
                        오늘의 한 끼,<br>
                        <span>맛있게 시작하세요!</span>
                    </h2>
                    <div class="join-line"></div>
                    <p>
                        다양한 레시피와 함께<br>
                        더 맛있는 하루를 만들어보세요.
                    </p>
                    <div class="join-bottom-icon">🍴 🍚</div>
                </div>
                
                <div class="join-right">
                    <h2 class="join-title">회원가입</h2>
                    <table class="join-table">
                        <tr>
                            <th>이름</th>
                            <td>
                                <input name="name" class="input-box" placeholder="이름입력하세요 Ex) 홍길동"/>
                                <div class="msg-space"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>닉네임</th>
                            <td>
                                <input name="nickname" id="nickname" onchange="nick()" class="input-box"/>
                                <div id="nick_msg" class="msg-space"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>아이디</th>
                            <td>
                                <input name="login_id" id="id" placeholder="아이디 입력하세요" 
                                    onchange="status(); id_check()" class="input-box"/>
                                <div id="id_msg" class="msg-space"></div>                        
                            </td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <td>
                                <input name="password" type="password" id="pwd" placeholder="비밀번호 입력하세요" 
                                    onchange="pwd_checks()" class="input-box"/>
                                <div id="pwd_msg" class="msg-space"></div>
                            </td>
                        </tr>
                        <tr>
                            <th>비밀번호 확인</th>
                            <td>
                                <input id="pwd_check" type="password" 
                                    placeholder="비밀번호 입력하세요" onchange="pwd_checks()"
                                    class="input-box"/>
                                <div id="pwd_check_msg" class="msg-space"></div>
                            </td>
                        </tr>
        
                        <tr>
                            <th>이메일</th>
                                <form class="email-form">
                                    <td>
                                        <div class="email-row">
                                            <input name="email" class="input-box email-input" placeholder="이메일 입력하세요 Ex) example@sample.com"/>
                                            <input type="button" value="본인인증" class="sub-btn" onclick="mailcheck(this.form)"/>
                                        </div>
                                        <div class="msg-space"></div>
                                        <div class="email-row">

                                            <input id="authnumber" type="number" placeholder="인증번호 6자리" maxlength="6" class="input-box email-input"/>
                                            <input type="button" value="인증번호 확인" class="sub-btn" onclick="change_input()"/>
                                        </div>
                                        <div id="email_msg" class="msg-space"></div>
                                    </td>
                                </form>
                        </tr>
                        
                        <tr>
                            <td colspan="2" class="btn-area">
                                <input type="button" value="회원 가입" class="join-btn" onclick="send(this.form)" />
                                <input type="button" value="취소" class="cancel-btn" onclick="history.back()" />
                            </td>
                        </tr>
        
                    </table>
                </div>

            </div> 
        </form>
        <footer>
            <div class="footer-container">
                <div class="footer-top-row">
                    <div class="cs-section">
                        <h3>고객센터</h3>
                        <div class="cs-buttons">
                            <div class="cs-btn" onClick="location.href='/hidden.do'">📞 1833-8307</div>
                            <div class="cs-btn">💬 1:1문의하기</div>
                        </div>
                        <div class="hours-info">
                            <p><strong>운영시간</strong></p>
                            <p>전화문의 - 10:00 ~ 12:00, 13:00 ~ 17:00 / 주말·공휴일 휴무</p>
                            <p>1:1 문의 - 09:00 ~ 12:00, 13:00 ~ 17:30 / 주말·공휴일 휴무</p>              
                        </div>
                    </div>
                    <div class="sns-icons">
                        <span class="sns-icon">▶</span>
                        <span class="sns-icon">★</span>
                        <span class="sns-icon">☆</span>
                        <span class="sns-icon">◆</span>
                        <span class="sns-icon">♬</span>
                    </div>
                </div>
            </div>

            <div class="footer-nav-bar">
                <div class="footer-container">
                    <div class="nav-links">
                        <a href="#"><strong>이용약관</strong></a>
                        <a href="#"><strong>개인정보처리방침</strong></a>
                        <a href="/notice.do">공지사항</a>
                        <a href="#">자주묻는질문</a>
                        <span class="partner-mail">광고/제휴 문의: kh@culture.net</span>
                    </div>
                </div>
            </div>

            

            <div class="footer-container">
                <div class="footer-bottom-row">
                    <div class="company-info">
                        <h4>주식회사 코코짱짱</h4>
                        <p>
                            <span>상호 : KH 개발</span>
                            <span>대표자 : 장승연</span>
                            <span>개인정보관리책임자 : 장승연</span>
                            <span>사업자 등록번호 : 111-01-31111</span>
                        </p>
                        <p>
                            <span>통신판매업 신고 : 제 2015-경기성남-1940 호</span>
                            <span>전화 : 1833-1234</span>
                            <span>팩스 : 031-8017-1800</span>
                        </p>
                        <p>주소 : 경기도 성남시 분당구 판교로 216길 92, kh타워 22층 2201호( 삼평동, 판교 에이치스퀘어 ) &nbsp;&nbsp; 이메일: kh@culture.net</p>
                    </div>
                    
                    <div class="footer-logo-area">
                        <p class="copyright">© 2026 by Khculture. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>
        
        <!-- 챗봇 -->
        <jsp:include page="/WEB-INF/views/chatbot/chatbot_main.jsp" />
    </body>

</html>
