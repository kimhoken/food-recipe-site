package com.project.foodsite.util;

import org.springframework.stereotype.Service;

import com.project.foodsite.dao.*;
import com.project.foodsite.vo.*;

import java.time.LocalDate;
import java.util.*;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class Recommand {
    /*
    * 만들어야할 추천 알고리즘
    * 1. 전체 공개 상태인 레시피 중 무작위로 카드 UI 형태로 추출하여 메인에 노출한다.   -> 대충 레시피중에 몇개 뽑기 --> 완료
    * 2. 사용자들이 작성한 최신 후기나 평점 높은 후기를 메인 화면에 슬라이드 형태로 보여준다.   -> 일단 평점을 기준으로 뽑고 나중에 댓글기능 생기면 댓글 어쩌구 저쩌구
    * 3. 최근에 추가된 레시피를 기준으로 정렬해 최신 레시피를 제공  -> 이거도 작성날짜/수정날짜가 최신인걸로 뽑기(desc로)
    * 4. 레시피중에서 랜덤으로 골라서 추천한다.             -> 랜덤으로 뽑기 --> 완료
    * 5. 조회수를 기준으로 조회수가 높은 레시피를 추천한다. -> 조회수 기준으로 레시피 뽑기
    * 6. 사용자가 가진 식재료들을 체크박스나 아이콘으로 선택하면 해당 재료가 포함된 레시피를 필터링하여 보여준다. -> 점수 시스템 알고리즘으로 구현
    */
    
    /*
    * 완성한 알고리즘
    * 1. 전체 공개 상태인 레시피 중 무작위로 카드 UI 형태로 추출하여 메인에 노출한다.   -> 대충 레시피중에 몇개 뽑기
    * 4. 레시피중에서 랜덤으로 골라서 추천한다.     -> 랜덤으로 뽑기
    * 6. 사용자가 가진 식재료들을 체크박스나 아이콘으로 선택하면 해당 재료가 포함된 레시피를 필터링하여 보여준다. -> 점수 시스템 알고리즘으로 구현
    * 3. 최근에 추가된 레시피를 기준으로 정렬해 최신 레시피를 제공  -> 이거도 작성날짜/수정날짜가 최신인걸로 뽑기(desc로)
    * 5. 조회수를 기준으로 조회수가 높은 레시피를 추천한다. -> 조회수 기준으로 레시피 뽑기
    * 2. 사용자들이 작성한 최신 후기나 평점 높은 후기를 메인 화면에 슬라이드 형태로 보여준다.   -> 일단 평점을 기준으로 뽑고 댓글 기눙 추가되면 변경예정
    */
    
    //냉장고 테이블
    private final FridgeItemDAO fridgeItemDAO;

    //레시피 테이블
    private final RecipeDAO recipeDAO;

    //랜덤함수
    private Random rand = new Random();
    
    public RecipeVO randomList(){
        //레시피의 갯수를 불러옴
        int size = recipeDAO.size();
        return recipeDAO.selectOne(rand.nextInt(1, size));
    }//randomList

    private int getScore(LocalDate Date){
        //날짜를 '-'기준으로 분리
        StringTokenizer st = new StringTokenizer(Date.toString(), "-");
        int score = 0;
        int year = Integer.parseInt(st.nextToken());
        int month = Integer.parseInt(st.nextToken());
        int day = Integer.parseInt(st.nextToken());

        score = getDate(month);
        score += (year*12);     //ex) 2026 * 12 = 24,312 + (30 || 28 || 31)
        score += day;           //위 값 + 오늘 날짜 -> ex) 2026-06-04 -> (24312 + 30) + 4 = 24316
        
        //윤년이면서 2월인 경우 하루가 늘어나므로
        if((year % 4 == 0 && year % 100 != 0 || year % 400 == 0) && month == 2){
            score++;
        }

        return score;   
    }

    private int getDate(int month){
        switch(month){
            case 1: case 3: case 5: case 7: 
            case 8: case 10: case 12:
                return 31;
            case 4: case 6:
            case 9: case 11:
                return 30;
            case 2:
                return 28;
        }
        //잘못된 값이 들어왔을 경우
        return -1;
    }

    /**
     * 현재 냉장고의 재료로 레시피 추천받는 알고리즘
     * @return 레시피VO
     */
    public List<RecipeVO> recomedList(int member_id){
        //불용어 필터링을 위한 배열
        String[] stopWords = {"얼린", "냉동", "다진", "썬", "국거리", "구이용", "볶음용", "손질", "슬라이스"};
        List<FridgeItemVO> fridgeList = fridgeItemDAO.selectList(member_id);
        Map<Integer, RecipeVO> map = new HashMap<>();

        //뽑아낸 재료중 유통기한이 얼마 안남은 음식에 점수를 높게 주어 유통기한이 얼마 안남은 제품을 먼저 소비할 수 있게해줌
        int now = getScore(LocalDate.now());

        //재료 하나의 유통기한을 가져와 그 재료가 포함된 레시피에 점수를 줌
        for(FridgeItemVO item : fridgeList){
            String ingredient = item.getIngredient_name();
            
            //재료 이름에 불용어가 있을 경우 제거하고 재료중에서 검색
            for(String word : stopWords){
                ingredient = ingredient.replace(word, "");
            }
            ingredient = ingredient.trim();

            //이 재료가 포함된 레시피를 불러오기
            List<RecipeVO> list = recipeDAO.selectAny(ingredient);
            int score = getScore(item.getExpire_date());

            //유통기한이 3일 이하이면 30점, 일주일 이하면 20점, 그 외는 10점
            int diff = score - now <= 3 ? 30 : score-now <= 7 ? 20 : 10;

            for(RecipeVO recipe : list){
                int recipeId = recipe.getRecipe_id();
                //기존에 맵에 있는 레시피라면 점수만 추가하고 없는 레시피이면 점수 추가 후 맵에 추가
                if(map.containsKey(recipeId)){
                    map.get(recipeId).addScore(diff);
                }else{
                    recipe.addScore(diff);
                    map.put(recipeId, recipe);
                }
            }
        }//for

        //추천된 레시피를 담을 리스트 맵의 값(레시피)을 배열리스트에 담음
        List<RecipeVO> recipeList = new ArrayList<>(map.values());

        //점수 높은 순으로 정렬
        Collections.sort(recipeList, (e1, e2) -> {
            //점수가 같으면 조회수가 높은 순으로 정렬
            if(e1.getScore() == e2.getScore()){
                //조회수가 같으면 좋아요가 높은 순으로 정렬
                if(e1.getLike_count() == e2.getLike_count())
                    return e2.getLike_count() - e1.getLike_count();
                return e2.getView_count() - e1.getView_count();
            }
            return e2.getScore() - e1.getScore();
        });

        System.out.println("------------------------레시피 불러오기 성공------------------------");
        System.out.println("size: " + recipeList.size());
        //점수가 높은 레시피 10개 추천 10개 보다 적으면 그거까지만 추천
        return recipeList.subList(0, Math.min(10, recipeList.size()));
    }//RecipeVO

    public List<RecipeVO> recentlyList(){
        return recipeDAO.selectRecently();
    }

    public List<RecipeVO> viewCountList(){
        return recipeDAO.selectViewCount();
    }

}
