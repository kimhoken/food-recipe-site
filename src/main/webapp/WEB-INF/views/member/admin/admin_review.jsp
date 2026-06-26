<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <head>
            <script>
                function entersearch(e) {

                    if (e.key === "Enter") {
                        searchreview();
                    }

                }

                function searchreview() {
                    document.querySelector('form[action="/admin/review"]').submit();
                }        
            </script>
        </head>
        <section>
            <div>
                <form action="/admin/review" method="get">

                    <div>
                        <div>
                            <h3>레시피 후기 관리 페이지</h3>
                            <small>회원들의 레시피 후기을 관리 할수 있습니다.</small>
                        </div>
                        <div>
                            <input type="text" placeholder="게시글, 작성자를 입력하세요" name="keyword"
                                onkeydown="entersearch(event)" />

                            <select name="sort" onchange="searchreview()">
                                <option value="">정렬</option>
                                <option value="asc">오름차순</option>
                                <option value="desc">내림차순</option>
                                <option value="view">조회수순</option>
                            </select>


                        </div>

                        <table>
                            <tr>
                                <th>레시피명</th>
                                <th>후기내용</th>
                                <th>평점</th>
                                <th>작성자</th>
                                <th>등록일</th>
                                <th>상태</th>
                            </tr>
                            <c:forEach var="review" items="${list}">

                                <tr>
                                    <td>
                                        <img src="/upload/review/${review.image}" />
                                        <span>${review.main_title}</span>
                                    </td>
                                    <td>${review.content}</td>
                                    <td>${review.rating}</td>
                                    <td>${review.nickname}</td>
                                    <td>${review.created_at}</td>
                                    <td>${review.status}</td>
                                </tr>

                            </c:forEach>
                        </table>

                        <div>
                            <div>총 게시글: ${totalcount}</div>
                            <div>
                                <c:set var="pageUrl"
                                    value="/admin/review?keyword=${adminreview.keyword}&status=${adminreview.status}&sort=${adminreview.sort}"
                                    scope="request" />
                                <jsp:include page="/WEB-INF/views/common/paging.jsp" />
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </section>