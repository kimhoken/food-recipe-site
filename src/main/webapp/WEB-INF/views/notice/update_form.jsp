<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

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

        <form action="notice_update.do" method="post" enctype="multipart/form-data">

            <input type="hidden" name="notice_id" value="${notice.notice_id}">
            <input type="hidden" name="img_id" value="${notice.img_id}">

            <table border="1">
                <tr>
                    <th>공지사항 제목</th>
                    <td>
                        <input type="text" name="title" value="${notice.title}">
                    </td>
                </tr>

                <tr>
                    <th>공지사항 내용</th>
                    <td>
                        <textarea name="content" rows="10" cols="50">${notice.content}</textarea>
                    </td>
                </tr>

                <tr>
                    <td>
                        <c:if test="${not empty img}">
                            <img src="/upload/${img.image_list}" style="max-width:200px; max-height:200px;">
                        </c:if>
                    </td>
                </tr>

                <tr>
                    <th>새 이미지</th>
                    <td>
                        <input type="file" name="images" >
                    </td>
                </tr>

                <tr>
                    <td colspan="2" align="center">
                        <input type="button" value="수정완료" onclick="send(this.form)">
                        <input type="button" value="뒤로가기" onclick="history.back()">
                    </td>
                </tr>
            </table>
        </form>

    </body>
</html>