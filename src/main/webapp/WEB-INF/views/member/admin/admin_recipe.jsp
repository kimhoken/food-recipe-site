<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <head>
            <link rel="stylesheet" href="css/admin_recipe.css" />
        </head>
        <section class="ra-wrap">
            <div class="ra-main">

                <div class="ra-content">

                    <div class="ra-header">
                        <div class="ra-title-box">
                            <h3 class="ra-title">레시피 관리</h3>
                            <p class="ra-desc">등록된 레시피를 관리하고 추천 레시피를 설정할수 있습니다.</p>
                        </div>
                        <input type="button" class="ra-add-btn" value="레시피 등록" onclick="" />
                    </div>

                    <div class="ra-tabs">
                        <input class="ra-tab" type="button" value="전체 레시피" />
                        <input class="ra-tab" type="button" value="추천 레시피 설정" />
                    </div>

                    <div class="ra-filter">

                        <input type="text" class="ra-search" placeholder="레시피명, 작성자명 검색" oninput="" />

                        <select class="ra-category" onchange="">
                            <option value="">카테고리 전체</option>
                            <option value="recommend">상황별 추천</option>
                            <option value="korean">한식</option>
                            <option value="western">양식</option>
                            <option value="chinese">중식</option>
                            <option value="japense">일식</option>
                            <option value="asian">아시안</option>
                            <option value="healthy">건강식/다이어트</option>
                            <option value="quick">초간단 요리</option>
                            <option value="dessert">디저트</option>
                            <option value="baking">베이킹</option>
                            <option value="beverage">음료/차</option>
                        </select>

                        <select class="ra-status">
                            <option value="">상태</option>
                            <option value="active">정상</option>
                            <option value="reported">검토</option>
                            <option value="blocked">차단</option>
                            <option value="delete">삭제</option>
                        </select>

                        <input type="button" class="ra-reset" value="초기화" onclick="" />

                    </div>
                    <table class="ra-table">
                        <tr>
                            <th>썸네일</th>
                            <th>레시피 제목</th>
                            <th>작성자</th>
                            <th>등록일</th>
                            <th>조회수</th>
                            <th>좋아요</th>
                            <th>상태</th>
                            <th>관리</th>
                        </tr>
                        <!-- forEach문 들어갈 예정 -->
                        <c:forEach var="recipe" items="${list}">
                            <tr class="ra-row" onclick="recipe_view('${recipe.recipe_id}')">
                                <td><img class="ra-thumb" src="/upload/recipe/${recipe.thumbnail}" /></td>
                                <td class="ra-info">
                                    <div class="ra-name">
                                        ${recipe.title}
                                    </div>
                                    <small class="ra-category-label">${recipe.category_name}</small>
                                </td>
                                <td>${recipe.nickname}</td>
                                <td>${recipe.created_date}</td>
                                <td>${recipe.view_count}</td>
                                <td>${recipe.like_count}</td>
                                <td><span class="badge badge-public">정상</span></td>
                                <td>...</td>
                            </tr>

                        </c:forEach>
                        <!--  -->
                    </table>

                    <div class="ra-footer">
                        <span class="ra-total">전체 갯수: ${totalcount}</span>
                        <div class="ra-page">
                            <c:set var="pageUrl" value="/admin?menu=recipe" scope="request" />
                            <jsp:include page="/WEB-INF/views/common/paging.jsp" />
                        </div>
                        <select class="ra-size">
                            <option value="5">5개씩 보기</option>
                            <option value="10">10개씩 보기</option>
                            <option value="20">20개씩 보기</option>
                        </select>
                    </div>
                </div>

                <!-- 모달로 구현할 예정 -->
                <div class="ra-detail">

                    <div class="ra-detail-head">
                        <h4>레시피 상세 정보</h4>
                        <button type="button" class="ra-close" onclick="closeDetail()">x</button>
                    </div>


                    <img id="model_img" class="ra-cover" src="/upload/recipe/" />


                    <div class="ra-title-box">
                        <h3 id="model_title"></h3>

                        <dl class="ra-meta">

                            <dt>작성자</dt>
                            <dd id="model_nickname">관리자</dd>

                            <dt>카테고리</dt>
                            <dd id="model_category">한식</dd>

                            <dt>등록일</dt>
                            <dd id="model_created">2026-06-18</dd>

                            <dt>수정일</dt>
                            <dd id="model_modify">2026-06-18</dd>

                            <dt>조회수</dt>
                            <dd id="model_count">112</dd>


                            <dt>좋아요</dt>
                            <dd id="model_like">50</dd>

                            <dt>상태</dt>
                            <dd id="model_status">정상</dd>

                        </dl>

                    </div>

                    <div class="ra-steps">
                        <h4>조리과정</h4>
                        
                        <div id="cookOrderBox">                            
                        </div>
                        

                    </div>
                    <div class="ra-actions">
                        <input type="button" class="btn-edit" value="수정하기" onclick="recipemodify(this)" />
                        <input type="button" class="btn-private" value="비공개 전환" onclick="recipeprivate(this)" />
                        <input type="button" class="btn-delete" value="삭제하기" onclick="recipedel(this)" />
                    </div>
                </div>



        </section>