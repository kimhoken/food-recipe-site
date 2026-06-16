<%@ page contentType="text/html;charset=UTF-8" %>

    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>게시글 작성</title>

        <link rel="stylesheet" href="/css/main.css">
        <link rel="stylesheet" href="/css/board_update.css">

    </head>

    <body>

        <div class="update-container">

            <h2>게시글 작성</h2>

            <form action="/community_write.do" method="post">

                <div class="form-group">

                    <label>제목</label>

                    <input type="text" name="title" required>

                </div>

                <div class="form-group">

                    <label>내용</label>

                    <textarea name="content" required></textarea>

                </div>

                <div class="btn-area">

                    <input type="button" value="취소" class="btn-cancel" onclick="location.href='/list.do'">

                    <input type="submit" value="등록" class="btn-submit">

                </div>

            </form>

        </div>

    </body>

    </html>