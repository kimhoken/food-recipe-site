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
        </script>
      
    </head>

    <body>
        <form action="/" method="post" enctype="multipart/form-data">

            <table border="1">
                
            </table>

            <table border="1">
                <h1>조리 순서</h1>

                <tr>
                    <td align="center">1</td>

                    <td>
                        <input type="file" name="img"/>
                    </td>

                    <td>
                        <textarea name="step" rows="5" cols="50" 
                        placeholder="예) 먼저 팬에 기름을 두르고 마늘 기름을 내주세요."></textarea>
                    </td>
                </tr>
            </table>
            <br/>
            <button type="submit">내 레시피 등록하기</button>
        </form>
    </body>

</html>