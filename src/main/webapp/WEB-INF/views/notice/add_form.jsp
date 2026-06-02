<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
    <head>

        <script>
            function send(f) {
                let title = f.title.value.trim();
                let content = f.content.value.trim();

                if (title === "") {
                    alert("공지사항 제목을 입력하세요.");
                    f.title.focus();
                    return;
                }

                if (content === "") {
                    alert("공지사항 내용을 입력하세요.");
                    f.content.focus();
                    return;
                }

                f.submit();
            }
        </script>
    </head>

    <body>

    <h2>공지사항 등록</h2>

    <form action="notice_add.do" method="post" enctype="multipart/form-data">
        <table border="1">
            <tr>
                <th>공지사항 제목</th>
                <td>
                    <input type="text" name="title" />
                </td>
            </tr>

            <tr>
                <th>공지사항 내용</th>
                <td>
                    <textarea name="content" rows="10" cols="50"></textarea>
                </td>
            </tr>

            <tr>
                <td>
                    <input type="file" name="images" />
                </td>
            </tr>

            <tr>
                <td colspan="2" align="center">
                    <input type="button" value="공지사항 등록" onclick="send(this.form)" />
                    <input type="button" value="뒤로가기" onclick="history.back()" />
                </td>
            </tr>
        </table>
    </form>

    </body>
</html>