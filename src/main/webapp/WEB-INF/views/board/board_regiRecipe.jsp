<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

{%
    <c:if test="${empty sessionScope.user}">
        <script>
            alert("로그인 후 작성가능합니다.")
            location.href="/login.do"
        </script>
    </c:if>
%}

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
                    <select name="vegeUnit">
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
                <td><input type="text" name="meatName" placeholder="예: 돼지고기"/></td>
                <td class="qty-cell">
                    <input type="text" name="amountM" placeholder="수량" />
                    <select name="meatUnit">
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
                <td><input type="text" name="seasoningName" placeholder="예: 고추장"/></td>
                <td class="qty-cell">
                    <input type="text" name="amountS" placeholder="수량" />
                    <select name="seasoningUnit">
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

        // 원하는 줄 삭제
        function removeRow(btn) {
            const row = btn.closest('tr');
            row.remove();
        }

        // 조리 순서 추가
        function addStep() {
            const tbody = document.getElementById('stepBody');
            const rowCount = tbody.rows.length;
            const nextStep = rowCount + 1;

            const newRow = document.createElement('tr');
            newRow.innerHTML = `
                <td align="center"><div class="step-number">\${nextStep}</div></td>
                <td><input type="file" name="img"/></td>
                <td style="display:flex; align-items:center; gap:10px;">
                    <textarea name="step" rows="4" placeholder="다음 조리 과정을 입력하세요."></textarea>
                    <button type="button" onclick="removeRow(this)" class="x-btn">X</button>
                </td>
            `;
            tbody.appendChild(newRow);
        }
    </script>
</head>

<body>
    <header>
        <div class="header-top">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/">
                    <img src="${pageContext.request.contextPath}/images/Logo.png" alt="로고">
                </a>
            </div>
            
            <form action="${pageContext.request.contextPath}/search" method="get" class="search-bar-form">
                <div class="search-bar">
                    <input type="text" id="mainSearch" name="keyword" placeholder="재료, 요리명으로 검색해보세요!">
                </div>
            </form>
            
            <div class="user-menu">
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

        <ul class="nav-bar">
            <li>
                <a href="/main_list.do">홈</a>
            </li>
            <li class="active">
                <a href="/list.do"> 레시피</a>
            </li>
            <li>카테고리</li>
            <li>랭킹</li>
            <li>커뮤니티</li>
            <li>
                <a href="/fridge_list.do">냉장고 추천</a>
            </li>
            <li>이벤트</li>
        </ul>    
    </header>

    <div class="container main-page">
        <div class="recipe-regi-container">
            <form action="/myrecipe.do" method="post" enctype="multipart/form-data">
                
                <h1>레시피 제목</h1>
                <input type="text" name="title" placeholder="레시피의 이름을 입력해주세요 (예: 초간단 크림 파스타)" />

                <h1 style="margin-top: 30px;">대표 이미지</h1>
                <input type="file" name="img" style="margin-bottom: 20px;" />

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
                                            <input type="text" name="amountV" placeholder="수량" />
                                            <select name="vegeUnit">
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
                                            <input type="text" name="amountM" placeholder="수량" />
                                            <select name="meatUnit">
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
                                        <td><input type="text" name="seasoingName" placeholder="예: 간장" /></td>
                                        <td class="qty-cell">
                                            <input type="text" name="amountS" placeholder="수량" />
                                            <select name="seasoningUnit">
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
                <table style="margin-top: 15px;">
                    <tbody id="stepBody">
                        <tr>
                            <td align="center" width="60">
                                <div class="step-number">1</div>
                            </td>
                            <td width="220">
                                <input type="file" name="img" />
                            </td>
                            <td>
                                <textarea name="step" rows="4" placeholder="예) 먼저 팬에 기름을 두르고 마늘 기름을 내주세요."></textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div align="center" style="margin-top: 15px;">
                    <button type="button" class="add-btn" onclick="addStep()">+ 조리 순서 추가</button>
                </div>

                <button type="submit" class="submit-btn">내 레시피 등록하기</button>
            </form>
        </div>
    </div>
</body>
</html>