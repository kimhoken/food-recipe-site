<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>

    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/notice_update.css">

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

        function deleteImg() {
            let image_div = document.getElementById("image_div");
            let ori_img_id = document.getElementById("ori_img_id");

            ori_img_id.value = "";
            image_div.style.display = "none";
        }
    </script>
</head>

<body>
    <jsp:include page="/WEB-INF/views/common/navibar.jsp" />

    <main class="notice-update-page">

        <section class="update-head">
            <span>NOTICE EDIT</span>
            <h2>공지사항 수정</h2>
        </section>

        <section class="update-card">
            <form action="notice_update.do" method="post" enctype="multipart/form-data">

                <input type="hidden" name="notice_id" value="${notice.notice_id}">
                <input type="hidden" name="ori_img_id" value="${notice.img_id}" id="ori_img_id">

                <div class="form-group">
                    <label>제목</label>
                    <input type="text" name="title" value="${notice.title}">
                </div>

                <div class="form-group">
                    <label>내용</label>
                    <textarea name="content">${notice.content}</textarea>
                </div>

                <div class="form-group">
                    <label>이미지</label>

                    <c:if test="${not empty img}">
                        <div id="image_div" class="current-img-box">
                            <img src="/upload/${img.image_list}">
                            <button type="button" onclick="deleteImg()">이미지 삭제</button>
                        </div>
                    </c:if>

                    <div class="file-box">
                        <input type="file" name="images">
                    </div>
                </div>

                <div class="btn-area">
                    <button type="button" class="submit-btn" onclick="send(this.form)">수정완료</button>
                    <button type="button" class="back-btn" onclick="history.back()">뒤로가기</button>
                </div>

            </form>
        </section>

    </main>
</body>
</html>