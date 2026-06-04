<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 목록</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/recipe.css">

</head>
<body>

<div class="recipe-container">

    <!-- 왼쪽 -->

    <aside class="filter-area">

        <form action="${pageContext.request.contextPath}/recipe_list.do" method="get"></form>
              

            <div class="filter-title">
                필터
            </div>

            <hr><br>

            <div class="filter-section">

                <h4>카테고리</h4>

                <label><input type="radio" name="category" value="상황별추천"> ⭐ 상황별 추천</label>

                <label><input type="radio" name="category" value="한식"> 🍚 한식</label>

                <label><input type="radio" name="category" value="양식"> 🍝 양식</label>

                <label><input type="radio" name="category" value="중식"> 🍳 중식</label>

                <label><input type="radio" name="category" value="일식"> 🍣 일식</label>

                <label><input type="radio" name="category" value="아시안"> 🌏 아시안</label>

                <label><input type="radio" name="category" value="건강식/다이어트"> 🥗 건강식/다이어트</label>

                <label><input type="radio" name="category" value="초간단요리"> ⏱️ 초간단요리</label>

                <label><input type="radio" name="category" value="디저트"> 🍰 디저트</label>

                <label><input type="radio" name="category" value="베이킹"> 🍞 베이킹</label>

                <label><input type="radio" name="category" value="음료/차"> ☕ 음료/차</label>

            </div>

            <hr><br>

            <div class="filter-section">

                <h4>조리시간</h4>

                <label>
                    <input type="checkbox"
                           name="cookTimes"
                           value="10">
                    10분 이하
                </label>

                <label>
                    <input type="checkbox"
                           name="cookTimes"
                           value="20">
                    10~20분
                </label>

                <label>
                    <input type="checkbox"
                           name="cookTimes"
                           value="30">
                    20~30분
                </label>

                <label>
                    <input type="checkbox"
                           name="cookTimes"
                           value="60">
                    30~60분
                </label>

                <label>
                    <input type="checkbox"
                           name="cookTimes"
                           value="61">
                    60분 이상
                </label>

            </div>

            <button class="filter-btn"
                    type="submit">
                적용하기
            </button>

        </form>

    </aside>

    <!-- 오른쪽 -->

    <section class="recipe-area">

        <div class="recipe-header">

            <h2>전체 레시피</h2>

            <select class="sort-select"
                    name="sort">

                <option value="latest">
                    최신순
                </option>

                <option value="name">
                    가나다순
                </option>

                <option value="view">
                    조회수순
                </option>

                <option value="like">
                    좋아요순
                </option>

            </select>

        </div>

        <div class="recipe-list">

            <c:forEach items="${recipeList}"
                       var="recipe">

                <div class="recipe-card">

                    <img src="${recipe.thumbnail}">

                    <div class="recipe-info">

                        <div class="recipe-title">
                            ${recipe.title}
                        </div>

                        <div class="recipe-meta">

                            ⏱ ${recipe.cooking_time}
                            <br>

                            👁 ${recipe.view_count}
                            &nbsp;&nbsp;

                            ❤️ ${recipe.like_count}

                        </div>

                    </div>

                </div>

            </c:forEach>

        </div>

    </section>

</div>

</body>
</html>