<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <jsp:include page="/WEB-INF/views/common/navibar.jsp"/>
    <jsp:include page="/WEB-INF/views/common/is_login.jsp"/>

        <html>
            <head>
                <script>
                    function review_send(f){
                        let rating = f.rating.value;

                        let title = f.title.value;

                        if(rating === ''){
                            alert("평점 입력하세요!");
                            return;
                        }

                        if (title === '' ){
                            alert("후기 제목 입력하세요!");
                            return;
                        }
                        let formdata = new FormData(f);

                        fetch("/review/insert", {
                            method:'post',
                            body: formdata
                        })
                        .then(res => res.json())
                        .then(data => {
                            if(data.result == "success"){
                                alert("레시피 후기 등록 성공!");
                                location.href='/board_list.do';
                            } else if(data.result == "fail"){
                                alert("실패!!");
                            } else {
                                alert("오류 발생");
                            }
                        })

                    }
                </script>
            </head>

            <body>
                <div>

                    <div>
                        <h3>레시피 후기 페이지</h3>
                        <small>직접 만들어본 후기를 남겨 다른 사람들과 공유해보세요!!</small>
                    </div>

                    <form enctype="multipart/form-data" method="post" >
                        <input type="hidden" name="recipe_id" value="${param.recipe_id}"/>
                        
                        
                        <div>

                            <div>

                                <img src="#"/>
                                <div>${recipe.title}</div>
                                <div>카테고리</div>
                                <div>${recipe.cooking_time}</div>
                                <div>${recipe.difficulty}</div>
                                <div>레시피 소개글</div>

                            </div>
    
                            <div >
                                평점 <span>*</span>
                                <input type="number" name="rating"/>
                            </div>

                            <div>
                                후기 제목 <span>*</span>
                                <input type="text" name="title"/>                                
                            </div>

                            <div>
                                후기 내용 <span>*</span>
                                <textarea name="content"></textarea>
                            </div>

                            <div>
                                후기 사진
                                <input type="file" name="photo" multiple/>                                
                            </div>
                        </div>

                        <div>
                            <input type="button" value="취소" onclick="history.back()"/>
                            <input type="button" value="후기 등록" onclick="review_send(this.form)"/>
                        </div>

                    </form>

                </div>
            </body>

        </html>