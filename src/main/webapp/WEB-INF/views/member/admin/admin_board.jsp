<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <head>
            <script>
                function entersearch(e) {

                    if (e.key === "Enter") {
                        searchboard();
                    }

                }

                function searchboard() {
                    document.querySelector('form[action="/admin/board"]').submit();
                }

            </script>
        </head>
        <section>
            <div>
                <div>
                    <h3>게시글 관리 페이지</h3>
                    <small>회원들의 게시글을 관리 할수 있습니다.</small>
                </div>
                <div>
                    <form action="/admin/board" method="get"> 
                        <div>
                            <input type="text" placeholder="게시글, 작성자를 입력하세요" name="keyword"
                                onkeydown="entersearch(event)" />

                            <select name="sort" onchange="searchboard()">

                                <option value="">정렬</option>
                                <option value="latest">최신순</option>
                                <option value="oldest">오래된순</option>
                                <option value="view">조회순</option>

                            </select>

                        </div>

                        <table>
                            <tr>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>댓글수</th>
                                <th>조회수</th>
                                <th>등록일</th>
                                <th>상태</th>
                            </tr>
                            <c:forEach var="board" items="${list}">

                                <tr>
                                    <td>
                                        <img src="/upload/board/#" />
                                        <span>${board.title}</span>
                                    </td>
                                    <td>${board.nickname}</td>
                                    <td>${board.comment_count}</td>
                                    <td>${board.view_count}</td>
                                    <td>${board.created_date}</td>
                                    <td>${board.status}</td>
                                </tr>

                            </c:forEach>
                        </table>

                        <div>
                            <div>총 게시글: ${totalcount}</div>
                            <div>
                                <c:set var="pageUrl"
                                    value="/admin/board?keyword=${adminboard.keyword}&status=${adminboard.status}&sort=${adminboard.sort}"
                                    scope="request" />
                                <jsp:include page="/WEB-INF/views/common/paging.jsp" />
                            </div>
                        </div>
                    </form>

                </div>
                <div class="ma-detail-panel">
                    <div class="ma-detail-header">
                        <h3>게시글 상세</h3>
                    </div>

                    <dl class="ma-detail-list">

                        <dt>제목</dt>
                        <dd class="model-title"></dd>

                        <dt>작성자</dt>
                        <dd class="model-user"></dd>
                        
                        <dt>카테고리</dt>
                        <dd class="model-category"></dd>

                        <dt>작성일</dt>
                        <dd class="model-date"></dd>

                        <dt>조회수</dt>
                        <dd class="model-view"></dd>

                        <dt>댓글수</dt>
                        <dd class="model-count"></dd>

                        <dt>좋아요수</dt>
                        <dd class="model-like"></dd>

                        <dt>상태</dt>
                        <dd class="model-status"></dd>

                        <dt>내용</dt>
                        <dd class="model-text"></dd>

                        <dt>첨부 이미지</dt>
                        <dd class="model-image"></dd>
                    </dl>

                    <div class="ma-action">
                        <input type="button" class="ma-btn ma-btn-stop" value="" onclick=""/>
                        <input type="button" class="ma-btn ma-btn-report" value="숨김"  onclick=""/>
                        <input type="button" class="ma-btn ma-btn-rank" value="" onclick=""/>
                    </div>

                </div>
            </div>
        </section>