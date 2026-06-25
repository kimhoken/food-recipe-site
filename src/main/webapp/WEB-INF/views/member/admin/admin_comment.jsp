<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="com-home">
    <div>
        <div>
            <h3>댓글 관리</h3>
            <small>회원들이 작성한 댓글을 관리하세요!</small>
        </div>

        <div>
            <div>
                <form>

                    <div>
                        <input type="text" name="keyword" placeholder="작성자, 게시글을 입력하세요!"/>

                        <select name="status">

                            <option value="">상태</option>
                            <option value="public">공개</option>
                            <option value="hidden">숨김</option>
                            <option value="delete">삭제</option>

                        </select>

                        <select name="sort">

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
                            <th>상태</th>
                        </tr>
                        <c:forEach var="comment" items="${list}">

                            <tr>
                                <td>
                                    <img src="/upload/#"/>
                                    <span>${comment.title}</span>
                                </td>
                                <td>
                                    ${comment.content}
                                </td>
                                <td>${comment.nickname}</td>
                                <td>${comment.created_date}</td>
                                <td><span>${comment.status}</span></td>
    
                            </tr>

                        </c:forEach>

                    </table>

                    <footer>
                        <div>총 댓글수: ${totalcount}개</div>
                        <div>
                           <c:set var="pageUrl"
                                  value="/admin/comment?keyword=${admincomment.keyword}&status=${admincomment.status}&sort=${admincomment.sort}"
                                  scope="request"/>
                            <jsp:include page="/WEB-INF/views/common/paging.jsp"/>    
                        </div>                        
                    </footer>
                </form>
            </div>
        </div>

    </div>
</section>