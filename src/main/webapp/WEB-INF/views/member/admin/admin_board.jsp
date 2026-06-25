<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section>
    <div>
        <div>
            <div>
                <h3>게시글 관리 페이지</h3>
                <small>회원들의 게시글을 관리 할수 있습니다.</small>
            </div>
            <div>
                <input type="text" placeholder="아이디, 게시글, 작성자를 입력하세요" name="keyword"/>

                <select>
                    <option value="">정렬</option>
                    <option value="asc">오름차순</option>
                    <option value="desc">내림차순</option>
                    <option value="writer">작성자순</option>
                </select>


            </div>

            <table>
                <tr>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>댓글수</th>
                    <th>조회수</th>
                    <th>좋아요</th>
                    <th>등록일</th>
                    <th>상태</th>                    
                </tr>

                <tr>
                    <td>
                        <img src="#"/>
                        <span>아라라라</span>
                    </td>
                    <td>라이언</td>
                    <td>10</td>
                    <td>20</td>
                    <td>2026-06-24</td>
                    <td>공개</td>                    
                </tr>
            </table>

            <div>
                <div>총 게시글: 10</div>
                <div>페이징</div>
            </div>
        </div>
    </div>
</section>