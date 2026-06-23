<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 레시피 탭 -->

<!-- 페이지 렌더링 전에 로그인 여부를 먼저 보여주기-->
<c:if test="${empty sessionScope.user}">
    <script>
        alert("로그인후 이용해주세요.")
        location.href = "/login.do";
    </script>
</c:if>
<jsp:include page="/WEB-INF/views/common/navibar.jsp" />
<!DOCTYPE html>
<html>

    <head>
        <title>오늘 뭐먹지? - 레시피 작성하기</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/regiRecipe.css" />

        <script>
            function send(f) {
                const ingredients = document.getElementsByName("ingredientName");
                const steps = document.getElementsByName("step");
                
                if (f.title.value.trim() === "") {
                    alert("제목을 입력하세요.");
                    f.title.focus();
                    return;
                }
                
                if (f.mainImg.value.trim() === "") {
                    alert("대표 이미지를 선택하세요.");
                    return;
                }
                
                if (ingredients[0].value.trim() === "") {
                    alert("재료를 입력하세요.");
                    ingredients[0].focus();
                    return;
                }
                
                if (steps[0].value.trim() === "") {
                    alert("조리순서를 입력하세요.");
                    return;
                }
                
                f.submit();
            }
            
            
            //썸네일 미리보기
            function previewImage(input) {
                
                const file = input.files[0];
                if (!file) {
                    return;
                }
                
                const reader = new FileReader();
                reader.onload = function (e) {
                    const preview = document.getElementById('thumbnailPreview'); //<img id="thumbnailPreview">
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                
                reader.readAsDataURL(file);
            }
            
            //조리순서 이미지 미리보기
            function previewStep(input) {
                
                console.log("조리순서 이미지 미리보기 함수 실행됨");
                
                const file = input.files[0];
                if (!file) {
                    return;
                }
                
                const reader = new FileReader();
                reader.onload = function (e) {
                    const preview = input.parentElement.querySelector("img"); //파일 선택한 바로 아래 <img> 태그 찾아
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                
                reader.readAsDataURL(file);
            }
            
            
            //재료 추가 함수
            function addIngredient() {
                const table = document.getElementById('ingredientTable');
                const newRow = table.insertRow();
                
                
                newRow.innerHTML = `
                <td><input type="text" name="ingredientName"></td>
                <td><input type="number" name="amount" min="0.1" step="0.1"></td>
                <td>
                <select name="unit" onchange="changeUnit(this)">
                <option value="개">개</option>
                <option value="g">g</option>
                <option value="kg">kg</option>
                <option value="ml">ml</option>
                <option value="큰술">큰술</option>
                <option value="작은술">작은술</option>
                <option value="컵">컵</option>
                <option value="direct">직접입력</option>
                </select>
                
                <input type="text"
                name="customUnit"
                placeholder="단위 입력"
                style="display:none;"
                />
                
                <button type="button" onclick="removeRow(this)" class="x-btn">
                X
                </button>
                </td>
                `;
                
            }
            
            //'직접입력' 선택시 그 자리에서 입력하기
            function changeUnit(select) {
                if (select.value === "direct") {
                    
                    // input 생성
                    const input = document.createElement("input");
                    input.type = "text";
                    input.name = "unit";
                    input.placeholder = "단위 입력";
                    
                    // 엔터나 포커스 해제 시 다시 select로 복구
                    input.onblur = function () {
                        if (input.value.trim() === "") {
                            select.selectedIndex = 0;
                        } else {
                            const option = document.createElement("option");
                            option.value = input.value;
                            option.text = input.value;
                            option.selected = true;
                            
                            select.appendChild(option);
                        }
                        
                        input.replaceWith(select);
                    };
                    
                    // select를 input으로 교체
                    select.replaceWith(input);
                    input.focus();
                }
            }
            
            //재료 줄 삭제
            function removeRow(btn) {
                const table = document.getElementById("ingredientTable");
                
                if (table.rows.length <= 2) {
                    alert("재료는 최소 1개 이상 필요합니다.");
                    return;
                }
                
                btn.closest("tr").remove();
            }
            
            
            //조리순서 번호를 1부터 다시 매기는 함수
            function updateStepNumbers() {
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
                
                <td align = "center">
                <div class="step-number">1</div>
                </td >
                
                <td>
                <input type="file" name="stepImg" onchange="previewStep(this)" />
                <br/>
                <img class="step-image" src="#" alt="조리순서 이미지 미리보기"/>
                </td>
                
                <td>
                <div class="step-content">
                <textarea name="step" rows="5" cols="50"
                placeholder="다음 조리 과정을 입력하세요."></textarea>
                <button type="button" onclick="removeRow2(this)" class="x-btn2">X</button>
                </div>
                </td>
                `;
                
                //tbody에 추가
                tbody.appendChild(newRow);
                
                //추가 후 번호 갱신
                updateStepNumbers();
            }
            
            
            
            //원하는 줄 삭제
            function removeRow2(btn) {
                const row = btn.closest('tr');
                const rows = document.querySelectorAll('#stepBody tr');
                
                if (rows.length <= 1) {
                    alert("조리순서는 최소 1개 이상 필요합니다.");
                    return;
                }
                
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
            <input type="hidden" name="memberId" value="${sessionScope.user.member_id}" />

            <h1>제목</h1>
            <input type="text" name="title" class="recipe-title" placeholder="레시피 제목을 입력하세요">


            <h1>대표 이미지</h1>

            <!--파일 선택 시 미리보기 함수 호출-->
            <input type="file" name="mainImg" onchange="previewImage(this)" />
            <br />
            <!--미리보기 이미지 태그-->
            <img id="thumbnailPreview" src="#" alt="썸네일 미리보기" />

            <!-- 카테고리 -->
            <div class="section">
                <h2>음식 선택</h>

                    <select name="foodId" required>
                        <option value="">음식을 선택하세요</option>

                        <c:forEach var="food" items="${foodList}">
                            <option value="${food.foodId}">
                                ${food.foodName}
                            </option>
                        </c:forEach>

                    </select>
                </div>

                <div class="section">
                    <h1>필요한 재료</h1>
                </div>

                <table id="ingredientTable">
                    <tr>
                        <th>재료명</th>
                        <th>수량</th>
                        <th>단위</th>
                    </tr>

                    <tr>
                        <td><input type="text" name="ingredientName"></td>
                        <td><input type="number" name="amount" min="0.1" step="0.1"></td>
                        <td>
                            <select name="unit" onchange="changeUnit(this)">
                                <option>개</option>
                                <option>g</option>
                                <option>kg</option>
                                <option>ml</option>
                                <option>큰술</option>
                                <option>작은술</option>
                                <option>컵</option>
                                <option value="direct">직접입력</option>
                            </select>
                            <input type="text" name="customUnit" placeholder="단위 입력" style="display:none;" />
                        </td>
                    </tr>
                </table>

                <div class="btn-wrap">
                    <button type="button" onclick="addIngredient()">
                        + 재료 추가
                    </button>
                </div>

                <br />
                <div class="section">
                    <h1>조리 순서</h1>
                </div>

                <table class="step-table">
                    <tbody id="stepBody">

                        <tr>
                            <td align="center">
                                <div class="step-number">1</div>
                            </td>

                            <td>
                                <!--파일 선택 시 미리보기 함수 호출 -->
                                <input type="file" name="stepImg" onchange="previewStep(this)" />
                                <br />
                                <!--미리보기 이미지 태그-->
                                <img class="step-image" src="#" alt="조리순서 이미지 미리보기" />

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

                <br />

                <div class="btn-wrap">
                    <button type="button" onclick="addStep()">+ 조리순서 추가</button>
                </div>

                <div class="btn-wrap">
                    <button type="button" onclick="send(this.form)">내 레시피 등록!</button>
                </div>
        </form>
    </body>
</html>