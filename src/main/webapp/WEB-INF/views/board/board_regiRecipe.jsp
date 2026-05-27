<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

    <head>

        <!-- <link /> -->

        <script>

            function send(f){       
                f.submit();
            }

    
        function addStep() {
            const tbody = document.getElementById('stepBody');
            const rowCount = tbody.rows.length; // 현재 행 개수 확인
            const nextStep = rowCount + 1;      // 다음 순서 번호

            // 새로운 행(tr) 생성
            const newRow = document.createElement('tr');

            newRow.innerHTML = 
            `
                <td align="center" class="step-number">\${nextStep}</td>
                <td>
                    <input type="file" name="img"/>
                </td>
                <td>
                    <textarea name="step" rows="5" cols="50" 
                    placeholder="다음 조리 과정을 입력하세요."></textarea>
                </td>
            `;

            // tbody에 추가
            tbody.appendChild(newRow);
        }
        </script>

        <style>
            textarea{resize: none;}
        </style>
      
    </head>

    <body>
        <form action="/" method="post" enctype="multipart/form-data">

            <table border="1">
                
            </table>

            <h1>조리 순서</h1>
            <table border="1">
                <tbody id="stepBody">

                <tr>
                    <td align="center">1</td>

                    <td>
                        <input type="file" name="img"/>
                    </td>

                    <td>
                        <textarea name="step" rows="5" cols="50" style="resize: none;"
                        placeholder="예) 먼저 팬에 기름을 두르고 마늘 기름을 내주세요."></textarea>
                    </td>
                </tr>
                </tbody>
            </table>

            <br/>
            <button type="button" onclick="addStep()">+</button>
            <br/>
            <button type="submit">내 레시피 등록하기</button>
        </form>
    </body>

</html>