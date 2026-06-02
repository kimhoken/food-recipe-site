<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${empty sessionScope.user}">
    <script>
        alert("로그인후 이용해주세요.")
        location.href="/login.do";
    </script>
</c:if>

<!DOCTYPE html>
<html>
<head>
    <title>오늘 뭐먹지? - 레시피 작성하기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/regiRecipe.css" />

    <script>
        function send(f) {
            f.submit();
        }

        // 1. 채소 추가
        function addStepV() {
            const table = document.getElementById('ingreT');
            const newRow = document.createElement('tr');

            newRow.innerHTML = `
                <td><input type="text" name="vegetableName" placeholder="예: 양파"/></td>
                <td class="qty-cell">
                    <input type="text" name="amountV" placeholder="수량" />
                    <select name="unit">
                        <option value="개">개</option>
                        <option value="쪽">쪽 (예: 마늘)</option>
                        <option value="대">대 (예: 대파)</option>
                        <option value="통">통 (예: 양배추)</option>
                        <option value="줌">줌 (예: 시금치)</option>
                        <option value="g">g (그램)</option>
                        <option value="약간">약간</option>
                        <option value="뿌리">뿌리</option>
                        <option value="봉지">봉지</option>
                    </select>
                    <button type="button" onclick="removeRow(this)" class="x-btn">X</button>
                </td>    
            `;
            table.appendChild(newRow);
        }

        // 2. 육류 추가
        function addStepM() {
            const table = document.getElementById('meatT');
            const newRow = document.createElement('tr');

            newRow.innerHTML = `
                <td><input type="text" name="meatName" /></td>
                <td class="qty-cell">
                    <input type="text" name="amountM" />
                    <select name="unit">
                        <option value="g">g (그램)</option>
                        <option value="kg">kg (킬로그램)</option>
                        <option value="근">근 (600g)</option>
                        <option value="마리">마리 (예: 닭고기)</option>
                        <option value="팩">팩</option>
                        <option value="장">장 (예: 슬라이스 햄)</option>
                        <option value="토막">토막 (예: 생선)</option>
                        <option value="적당량">적당량</option>
                    </select>
                    <button type="button" onclick="removeRow(this)" class="x-btn">X</button>
                </td>
            `;
            table.appendChild(newRow);
        }

        // 3. 양념 추가
        function addStepS() {
            const table = document.getElementById('seasoningT');
            const newRow = document.createElement('tr');

            newRow.innerHTML = `
                <td><input type="text" name="seasoningName" /></td>
                <td class="qty-cell">
                    <input type="text" name="amountS" />
                    <select name="unit">
                        <option value="큰술">큰술 (tbsp)</option>
                        <option value="작은술">작은술 (tsp)</option>
                        <option value="컵">컵 (Cup)</option>
                        <option value="ml">ml (밀리리터)</option>
                        <option value="꼬집">꼬집</option>
                        <option value="적당량">적당량</option>
                        <option value="약간">약간</option>
                        <option value="방울">방울</option>
                    </select> 
                    <button type="button" onclick="removeRow(this)" class="x-btn">X</button>
                </td>
            `;
            table.appendChild(newRow);
        }

        // 채소, 육류, 양념 원하는 줄 삭제
        function removeRow(btn) {
            const row = btn.closest('tr');
            row.remove();
        }

        // 조리순서 번호를 1부터 다시 매기는 함수
        function updateStepNumbers(){
            const steps = document.querySelectorAll('#stepBody .step-number');
            steps.forEach((step, index) => {
                step.innerHTML = index + 1;
            });
        }

        // 조리순서 추가 함수
        function addStep() {
            const tbody = document.getElementById('stepBody');
            const newRow = document.createElement('tr');

            // 기존 코드에서 nextStep 변수가 정의되지 않아 에러가 나던 부분을 수정했어.
            // 어차피 바로 밑에서 updateStepNumbers()를 실행하니까 여기선 일단 빈 값으로 둬도 돼!
            newRow.innerHTML = `
                <td align="center"> <div class="step-number"></div> </td>
                <td>
                    <input type="file" name="img"/>
                </td>
                <td>
                    <div class="step-content">
                        <textarea name="step" rows="5" cols="50" placeholder="다음 조리 과정을 입력하세요."></textarea>
                        <button type="button" onclick="removeRow2(this)" class="x-btn2">X</button>
                    </div>
                </td>
            `;

            tbody.appendChild(newRow);
            updateStepNumbers();
        }

        // 원하는 조리순서 줄 삭제
        function removeRow2(btn) {
            const row = btn.closest('tr');
            row.remove();
            updateStepNumbers();
        }
    </script>

    <style>
        textarea {
            resize: none;
        }
    </style>
</head>

<body>
    <header>
            <div class="header-top">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/">
                        <img src="${pageContext.request.contextPath}/images/Logo.png" alt="로고">
                    </a>
                </div>
                
                <form action="${pageContext.request.contextPath}/search.do" method="post" class="search-bar-form">
                    <div class="search-bar">
                        <input type="text" id="mainSearch" name="search" placeholder="재료, 요리명으로 검색해보세요!">
                    </div>
                </form>
                
                <div class="user-menu">
                    <%-- 로그인/로그아웃으로 session에 값에 따라 변경 --%>
                    <c:if test="${empty user}">
                        <a href="/login.do" class="menu-item" id="login">
                            <span class="menu-icon">
                                <img src="${pageContext.request.contextPath}/images/login.png">
                            </span>
                            <div>로그인</div>
                        </a>
                    </c:if>
                    <c:if test="${!empty user}">
                        <a href="#" class="menu-item" id="login" onClick="logout(); return false;" >
                            <span class="menu-icon">
                                <img src="${pageContext.request.contextPath}/images/login.png">
                            </span>
                            <div>로그아웃</div>
                        </a>
                    </c:if>
                    <%-- ------------------------------------------ --%>

                    <a href="/register_form.do" class="menu-item">
                        <span class="menu-icon">
                            <img src="${pageContext.request.contextPath}/images/login.png">
                        </span>
                        <div>회원가입</div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/mypage.do" class="menu-item">
                        <span class="menu-icon">
                            <img src="${pageContext.request.contextPath}/images/mypage.png">
                        </span>
                        <div>마이페이지</div>
                    </a>
                </div>
            </div>

            <%-- 레시피에 접속시 class="active"를 레시피 li에 적용하게 전부 변경 --%>
            <ul class="nav-bar">
                <li >홈</li>
                <li>
                    레시피
                </li>
                <li>카테고리</li>
                <li>랭킹</li>
                <li class="active"><a href="/list.do">커뮤니티</a> </li>
                <li>
                    <a href="/fridge_list.do?member_id=${user.member_id}">냉장고 추천</a>
                </li>
                <li>이벤트</li>
            </ul>       
        </header>
    <div class="container-main-page">
        <div class="recipe-regi-container">
            
            <form action="/myrecipe.do" method="post" enctype="multipart/form-data">

                <h1>제목</h1>
                <input type="text" name="title" />

                <h1>대표 이미지</h1>
                <input type="file" name="mainImg"/>
                
                <h1>필요한 재료</h1>
                <table>
                    <tbody id="ingredients">
                        <tr>
                            <td>
                                <table id="ingreT">
                                    <tr>
                                        <th>채소</th>
                                        <th>수량</th>
                                    </tr>
                                    <tr>
                                        <td><input type="text" name="vegetableName" placeholder="예: 마늘" /></td>
                                        <td class="qty-cell">
                                            <input type="text" name="amountV" />
                                            <select name="unit">
                                                <option value="개">개</option>
                                                <option value="쪽">쪽 (예: 마늘)</option>
                                                <option value="대">대 (예: 대파)</option>
                                                <option value="통">통 (예: 양배추)</option>
                                                <option value="줌">줌 (예: 시금치)</option>
                                                <option value="g">g (그램)</option>
                                                <option value="약간">약간</option>
                                                <option value="뿌리">뿌리 (예: 쪽파)</option>
                                                <option value="봉지">봉지 (예: 숙주)</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <div align="center">
                                    <button type="button" class="add-btn" onclick="addStepV()">+ 채소 추가</button>
                                </div>

                                <br />
                                <table id="meatT">
                                    <tr>
                                        <th>육류</th>
                                        <th>수량/중량</th>
                                    </tr>
                                    <tr>
                                        <td><input type="text" name="meatName" placeholder="예: 소고기(양지)" /></td>
                                        <td class="qty-cell">
                                            <input type="text" name="amountM" />
                                            <select name="unit">
                                                <option value="g">g (그램)</option>
                                                <option value="kg">kg (킬로그램)</option>
                                                <option value="근">근 (600g)</option>
                                                <option value="마리">마리 (예: 닭고기)</option>
                                                <option value="팩">팩</option>
                                                <option value="장">장 (예: 슬라이스 햄)</option>
                                                <option value="토막">토막 (예: 생선)</option>
                                                <option value="적당량">적당량</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <div align="center">
                                    <button type="button" class="add-btn" onclick="addStepM()">+ 육류 추가</button>
                                </div>

                                <br />
                                <table id="seasoningT">
                                    <tr>
                                        <th>양념/장류</th>
                                        <th>사용량</th>
                                    </tr>
                                    <tr>
                                        <td><input type="text" name="seasoningName" placeholder="예: 간장" /></td>
                                        <td class="qty-cell">
                                            <input type="text" name="amountS" />
                                            <select name="unit">
                                                <option value="큰술">큰술 (tbsp)</option>
                                                <option value="작은술">작은술 (tsp)</option>
                                                <option value="컵">컵 (Cup)</option>
                                                <option value="ml">ml (밀리리터)</option>
                                                <option value="꼬집">꼬집</option>
                                                <option value="적당량">적당량</option>
                                                <option value="약간">약간</option>
                                                <option value="방울">방울 (예: 참기름)</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                                <div align="center">
                                    <button type="button" class="add-btn" onclick="addStepS()">+ 양념/장류 추가</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <h1>조리 순서</h1>
                <table>
                    <tbody id="stepBody">
                        <tr>
                            <td align="center">
                                <div class="step-number">1</div>
                            </td>
                            <td>
                                <input type="file" name="img" />
                            </td>
                            <td>
                                <div class="step-content">
                                    <textarea name="step" rows="5" cols="50" placeholder="예) 먼저 팬에 기름을 두르고 마늘 기름을 내주세요."></textarea>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <br/>
                <div align="center">
                    <button type="button" class="add-btn" onclick="addStep()">+ 순서 추가</button>
                </div>

                <br/>
                <button type="submit" class="submit-btn" onclick="send(this.form)">내 레시피 등록하기</button>
            </form>
            
        </div>
    </div>
    <footer>
            <div class="footer-container">
                <div class="footer-top-row">
                    <div class="cs-section">
                        <h3>고객센터</h3>
                        <div class="cs-buttons">
                            <div class="cs-btn">📞 1833-8307</div>
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