<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>

<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/board_update.css">

</head>
<body>

<div class="update-container">

    <h2>게시글 수정</h2>

    <form action="/update.do" method="post">

        <input type="hidden"
               name="board_id"
               value="${board.board_id}">

        <div class="form-group">

            <label>제목</label>

            <input type="text"
                   name="title"
                   value="${board.title}"
                   required>

        </div>

        <div class="form-group">

            <label>내용</label>

            <textarea name="content"
                      required>${board.content}</textarea>

        </div>

        <div class="btn-area">

            <input type="button"
                   value="취소"
                   class="btn-cancel"
                   onclick="history.back()">

            <input type="submit"
                   value="수정완료"
                   class="btn-submit">

        </div>

    </form>

</div>

</body>
</html>