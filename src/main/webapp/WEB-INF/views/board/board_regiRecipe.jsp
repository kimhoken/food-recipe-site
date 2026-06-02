<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>

            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/regiRecipe.css" />

            <script>

                //내 레시피 등록 버튼
                function send(f) {

                    f.submit();
                }

                //1. 채소 추가
                function addStepV() {
                    const table = document.getElementById('ingreT');
                    const newRow = document.createElement('tr');

                    newRow.innerHTML = `
                        <td><input type="text" name="vegetableName"/></td>
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
                                <option value="뿌리">뿌리</option>
                                <option value="봉지">봉지</option>
                            </select>
                            <button type="button" onclick="removeRow(this)" class="x-btn">X</button>
                        </td>    
                    `;
                    table.appendChild(newRow);
                }


                //2. 육류 추가
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


                //3. 양념 추가
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

                //채소, 육류, 양념 원하는 줄 삭제
                function removeRow(btn) {
                    // .closest('tr')는 버튼에서 가장 가까운 줄(tr)을 찾음
                    const row = btn.closest('tr');

                    // 찾은 줄 삭제
                    row.remove();
                }


                //조리순서 번호를 1부터 다시 매기는 함수
                function updateStepNumbers(){
                    //stepBody 안에 있는 모든 .step-number 요소를 가져와 
                    //띄어쓰기-> 자식 선택!
                    const steps = document.querySelectorAll('#stepBody .step-number');

                    steps.forEach(
                        (steps, index) => {
                            //index는 0부터 시작이라 +1해서 넣어
                            steps.innerHTML = index + 1;
                        }
                    );
                }

                //조리순서 추가 함수
                function addStep() {
                    const tbody = document.getElementById('stepBody');
                    // 새로운 행(tr) 생성
                    const newRow = document.createElement('tr');

                    //처음부터 번호 계산 x, updateStepNumbers: 선 생성 번호매김 후 처리
                    newRow.innerHTML = `
                        <td align = "center"> <div class="step-number">\${ nextStep }</div> </td >
                        <td>
                            <input type="file" name="img"/>
                        </td>
                        
                        <td>
                            <div class="step-content">
                            <textarea name="step" rows="5" cols="50" 
                            placeholder="다음 조리 과정을 입력하세요."></textarea>
                            <button type="button" onclick="removeRow2(this)" class="x-btn2">X</button>
                            </div>
                        </td>
                    `;

                    // tbody에 추가
                    tbody.appendChild(newRow);

                    //추가 후 번호 갱신
                    updateStepNumbers();
                }

                //원하는 줄 삭제
                function removeRow2(btn) {
                    const row = btn.closest('tr');
                    //찾은 줄 삭제
                    row.remove();
                    //선택한 줄 삭제 후 번호 재정렬
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
            <form action="/myrecipe.do" method="post" enctype="multipart/form-data">

                <h1>제목
                    <input type="text" name="title" />
                </h1>

                <h1>대표 이미지
                    <td>
                        <input type="file" name="mainImg"/>
                    </td> 
                </h1>
                

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
                                    <button type="button" onclick="addStepV()"> 채소 추가 (+) </button>
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
                                    <button type="button" onclick="addStepM()"> 육류 추가 (+) </button>
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
                                    <button type="button" onclick="addStepS()"> 양념/장류 추가 (+) </button>
                                </div>

                </table>
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
                                <textarea name="step" rows="5" cols="50" style="resize: none;"
                                    placeholder="예) 먼저 팬에 기름을 두르고 마늘 기름을 내주세요."></textarea>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <br/>
                <div align="center">
                    <button type="button" onclick="addStep()">+</button>
                </div>

                <br/>
                <button type="submit" onclick="send(this.form)">내 레시피 등록하기</button>
            </form>
        </body>

        </html>