<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <head>
            <script>
                let selcomment;
                function entersearch(e) {

                    if (e.key === "Enter") {
                        searchcomment();
                    }

                }

                function searchcomment() {
                    document.querySelector('form[action="/admin/comment"]').submit();
                }

                function comment_view(comment_id){
                    fetch("/admin/comment/view",{
                        method:'post',
                        headers:{"Content-Type": "application/x-www-form-urlencoded"},
                        body: 'comment_id='+comment_id
                    }).then(res=> res.json())
                    .then(dto =>{
                        console.log(dto);

                        setComment(dto);
                    })
                }

                function setComment(dto){

                    let status = '';

                    selcomment = dto.comment_id;

                    document.querySelector(".cm-btn-hidden").value='비공개 전환';
                    document.querySelector(".cm-btn-delete").value='삭제'

                    if(dto.status === 'ACTIVE'){
                        status='공개';
                    } else if(dto.status === 'HIDDEN'){
                        status='비공개'
                        document.querySelector(".cm-btn-hidden").value='공개 전환';
                    } 
                    if(dto.status === 'DELETE'){
                        status='삭제';
                        document.querySelector(".cm-btn-delete").value='복원';
                    }

                    setImg("model-img", "/upload/"+dto.thumbnail);
                    setText("title",dto.title);
                    setText("type",dto.type);
                    setText("nickname",dto.nickname);
                    setText("rating",dto.rating);
                    setText("content",dto.content);
                    setText("created",dto.created_date);
                    setText("status",status);
                    
                }

                function commenthidden(){
                    if(!confirm("댓글을 비공개 처리 하시겠습니까?")){
                        return;
                    }

                    fetch("/admin/comment/hidden",{
                        method :'post',
                        headers:{"Content-Type": "application/x-www-form-urlencoded"},
                        body:"comment_id=" + selcomment
                    }).then(res=> res.json())
                    .then(data=>{
                        if( data.result > 0 && data.status==='HIDDEN' ){
                            alert( "비공개 처리 되었습니다." );
                        } else if( data.result > 0 && data.status === 'ACTIVE' ){
                            alert( "공개 전환 되었습니다." );
                        } else{
                            alert("전환 할수 없습니다.");
                        }
                    })
                }

                function commentdelete(del){
                    if(!confirm("댓글을 삭제 하시겠습니까?")){
                        return;
                    }

                    fetch("/admin/comment/delete",{
                        method :'post',
                        headers:{"Content-Type": "application/x-www-form-urlencoded"},
                        body:"comment_id=" + selcomment 
                    }).then(res=> res.json())
                    .then(data=>{
                        if( data.result > 0 && data.status === 'DELETE' ){
                            alert("삭제 되었습니다.");
                        } else if(data.result > 0 && data.status === 'ACTIVE'){
                            alert("복원 되었습니다.");
                        } else {
                            alert("삭제/복원 할수 없습니다.");
                        }
                    })
                }

            </script>
        </head>

        <section class="com-home">
            <div>
                <div>
                    <h3>댓글 관리</h3>
                    <small>회원들이 작성한 댓글을 관리하세요!</small>
                </div>

                <div>
                    <div>
                        <form action="/admin/comment" method="get">

                            <div>
                                <input type="text" name="keyword" placeholder="작성자, 게시글을 입력하세요!" />

                                <select name="status" onchange="searchcomment()">

                                    <option value="">상태</option>
                                    <option value="public">공개</option>
                                    <option value="hidden">숨김</option>
                                    <option value="delete">삭제</option>

                                </select>

                                <select name="sort" onchange="searchcomment()">

                                    <option value="">정렬</option>
                                    <option value="latest">최신순</option>
                                    <option value="oldest">오래된순</option>
                                    <option value="status">상태순</option>

                                </select>
                            </div>

                            <table>
                                <tr>
                                    <th>게시글명</th>
                                    <th>댓글 내용</th>
                                    <th>작성자</th>
                                    <th>등록일</th>
                                    <th>평점</th>
                                    <th>상태</th>
                                </tr>
                                <c:forEach var="comment" items="${list}">

                                    <tr onclick="comment_view('${comment.comment_id}')">
                                        <td>
                                            <c:choose>

                                                <c:when test="${comment.thumbnail eq 'no_board.png'}">
                                                    <img src="/images/no_board.png" width="65px" height="65px" />
                                                </c:when>

                                                <c:otherwise>
                                                    <img src="/upload/${comment.thumbnail}" />
                                                </c:otherwise>

                                            </c:choose>

                                            <span>${comment.title}</span>
                                        </td>
                                        <td>
                                            ${comment.content}
                                        </td>
                                        <td>${comment.nickname}</td>
                                        <td>${comment.created_date}</td>
                                        <td>${comment.rating}</td>
                                        <td>
                                            <span>
                                                <c:choose>
                                                    <c:when test="${comment.status eq 'ACTIVE'}">
                                                        공개
                                                    </c:when>   
                                                    
                                                    <c:when test="${comment.status eq 'HIDDEN'}">
                                                        비공개
                                                    </c:when>

                                                    <c:when test="${comment.status eq 'DELETE'}">
                                                        삭제
                                                    </c:when>
                                                </c:choose>

                                            </span>
                                        </td>

                                    </tr>

                                </c:forEach>

                            </table>

                            <footer>
                                <div>총 댓글수: ${totalcount}개</div>
                                <div>
                                    <c:set var="pageUrl"
                                        value="/admin/comment?keyword=${admincomment.keyword}&status=${admincomment.status}&sort=${admincomment.sort}"
                                        scope="request" />
                                    <jsp:include page="/WEB-INF/views/common/paging.jsp" />
                                </div>
                            </footer>
                        </form>
                    </div>
                </div>

                <div class="ma-detail-panel">
                    <div class="ma-detail-header">
                        <h3>댓글 상세</h3>
                    </div>

                </div>

                <dl class="ma-detail-list">

                    <dd id="model-img" class="model-img">
                        
                        <img src="/upload/" />
                    </dd>

                    <dt>제목/</dt>
                    <dd id="model-title" class="model-title"></dd>

                    <dt>구분</dt>
                    <dd id="model-type" class="model-type"></dd>

                    <dt>작성자</dt>
                    <dd id="model-nickname" class="model-nickname"></dd>

                    <dt>작성일</dt>
                    <dd id="model-created" class="model-created"></dd>

                    <dt>평점</dt>
                    <dd id="model-rating" class="model-rating"></dd>

                    <dt>댓글 내용</dt>
                    <dd id="model-content" class="model-contnet"></dd>

                    <dt>상태</dt>
                    <dd id="model-status" class="model-status"></dd>

                </dl>

                <div class="ma-action">
                    <input type="button" class="cm-btn cm-btn-hidden" value="" onclick="commenthidden()" />
                    <input type="button" class="cm-btn cm-btn-delete" value="" onclick="commentdelete()" />
                    
                </div>

            </div>

            </div>
        </section>