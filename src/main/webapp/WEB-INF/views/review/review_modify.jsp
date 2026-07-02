<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <jsp:include page="/WEB-INF/views/common/navibar.jsp" />
        <jsp:include page="/WEB-INF/views/common/is_login.jsp" />

        <html>

        <head>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
            <script>
                const deleteImages=[];

                document.addEventListener("DOMContentLoaded", () => {

                    console.log('${review.rating}');
                    const fileInput = document.getElementById("reviewPhotos");
                    const previewBox = document.getElementById("previewBox");
                    

                    fileInput.addEventListener("change", function () {
                        
                        Array.from(this.files).forEach(file => {
                            const img = document.createElement("img");
                            img.src = URL.createObjectURL(file);
                            img.className = "preview-img";
                            previewBox.appendChild(img);
                        })


                    });
                })

                function deleteImage() {
                    document.querySelectorAll(".delete-check:checked")
                        .forEach(check => {

                            deleteImages.push(check.value);

                            check.closest(".preview-item").remove();

                        });
                    
                    console.log(deleteImages);    
                }

                function review_modify(f){
                    const formdata = new FormData(f);

                    formdata.set("deleteImages", deleteImages.join(","));

                    fetch("/review/modify",{
                        method: 'post',
                        body:formdata
                    })
                    .then(res => res.json())
                    .then( data => {
                        
                    })

                }
            </script>
        </head>

        <body>
            <div>

                <div>
                    <h3>레시피 후기 수정 페이지</h3>
                    <small>직접 만들어본 후기를 남겨 다른 사람들과 공유해보세요!! 제발 지옥같은 여기서 날꺼내줘</small>
                </div>

                <form enctype="multipart/form-data" method="post">
                    <input type="hidden" name="recipe_id" value="${param.recipe_id}" />
                    <input type="hidden" name="deleteImages" id="deleteImages"/>


                    <div>

                        <div>

                            <img src="#" />
                            <div>${recipe.title}</div>
                            <div>카테고리</div>
                            <div>${recipe.cooking_time}</div>
                            <div>${recipe.difficulty}</div>
                            <div>레시피 소개글</div>

                        </div>

                        <div>
                            평점 <span>*</span>
                            <input type="hidden" name="rating" id="rating" value="${review.rating}">

                            <div class="rating">
                                <span class="rating__result">0</span>

                                <i class="rating__star far fa-star"></i>
                                <i class="rating__star far fa-star"></i>
                                <i class="rating__star far fa-star"></i>
                                <i class="rating__star far fa-star"></i>
                                <i class="rating__star far fa-star"></i>
                            </div>
                        </div>

                        <div>
                            후기 제목 <span>*</span>
                            <input type="text" name="title" value="${review.title}" />
                        </div>

                        <div>
                            후기 내용 <span>*</span>
                            <textarea name="content">${review.content}</textarea>
                        </div>

                        <div>
                            후기 사진
                            <input type="file" id="reviewPhotos" name="photo" multiple />
                            <div id="previewBox" class="preview-box">
                                
                                <c:forEach var="img" items="${review.imgList}">
                                    <div class="preview-item">

                                        <input type="checkbox"
                                               class="delete-check"
                                               value="${img}"/>

                                        <img src="/upload/review/${img}" class="preview-img"/>

                                    </div>
                                </c:forEach>

                                <input type="button" 
                                       value="선택 삭제"
                                       onclick="deleteImage()"/>

                            </div>
                        </div>
                    </div>

                    <div>
                        <input type="button" value="취소" onclick="history.back()" />
                        <input type="button" value="후기 수정" onclick="review_modify(this.form)" />
                    </div>

                </form>

            </div>
        </body>

        <script>
            const ratingStars = [...document.getElementsByClassName("rating__star")];
            const ratingResult = document.querySelector(".rating__result");
            const ratingInput = document.getElementById("rating");


            function printRatingResult(result, num = 0) {
                result.textContent = num
                ratingInput.value = num;
            }

            function paintStars(num) {
                ratingStars.forEach((star, index) => {
                    star.className = index < num
                        ? "rating__star fas fa-star"
                        : "rating__star far fa-star";
                });
            }

            const initialRating = Number(ratingInput.value || 0);
            printRatingResult(ratingResult, initialRating);
            paintStars(initialRating);

            function executeRating(stars, result) {
                const starsLength = stars.length;

                stars.forEach((star, index) => {
                    star.onclick = () => {
                        const currentRating = Number(ratingInput.value || 0);
                        const nextRating = currentRating === index + 1 ? index : index + 1;

                        printRatingResult(result, nextRating);
                        paintStars(nextRating);
                    };
                });
            }


            executeRating(ratingStars, ratingResult);

        </script>

        </html>
