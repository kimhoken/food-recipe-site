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
    * 추천알고리즘
    * 1. 규칙 기반 시스템
    * 2. 콘텐츠 기반 필터링
    * 3. 협업 필터링
    * 4. 태그 스코어링
    * 5. 장바구니 알고리즘 
    */

    /*
    * 만들어야할 추천 알고리즘
    * 1. 전체 공개 상태인 레시피 중 무작위로 카드 UI 형태로 추출하여 메인에 노출한다.   -> 대충 레시피중에 몇개 뽑기 --> 완료
    * 2. 사용자들이 작성한 최신 후기나 평점 높은 후기를 메인 화면에 슬라이더 형태로 보여준다.   -> 작성날짜가 최신인걸로 뽑기
    * 3. 최근에 추가된 레시피를 기준으로 정렬해 최신 레시피를 제공  -> 이거도 작성날짜/수정날짜가 최신인걸로 뽑기(desc로)
    * 4. 레시피중에서 랜덤으로 골라서 추천한다.     -> 랜덤으로 뽑기 --> 완료
    * 5. 조회수를 기준으로 조회수가 높은 레시피를 추천한다. -> 조회수 기준으로 레시피 뽑기
    * 6. 사용자가 가진 식재료들을 체크박스나 아이콘으로 선택하면 해당 재료가 포함된 레시피를 필터링하여 보여준다.   -> 규칙기반 알고리즘으로...
    */

    /*
    * 완성한 알고리즘
    * 1. 전체 공개 상태인 레시피 중 무작위로 카드 UI 형태로 추출하여 메인에 노출한다.   -> 대충 레시피중에 몇개 뽑기
    * 4. 레시피중에서 랜덤으로 골라서 추천한다.     -> 랜덤으로 뽑기
    * 
    */
    
    //냉장고 테이블
    private final FridgeItemDAO fridgeItemDAO;

    //재료 테이블
    private final IngredientDAO ingredientDAO;

    //레시피 테이블
    private final RecipeDAO recipeDAO;

    //조리순서 테이블
    private final CookOrderDAO cookOrderDAO;

    //랜덤함수
    private Random rand = new Random();
    
    /**
     * 랜덤으로 레시피 5개 뽑아줌
     * @return List<RecipeVO> 형태의 레시피 5개
     */
    public List<RecipeVO> randomList(){
        int[] arr = new int[5];

        //레시피테이블의 갯수를 가지고옴
        int size = recipeDAO.size();

        //등록된 레시피가 5개 미만일 경우
        if(size<5){
            return recipeDAO.selectAll();
        }

        for(int i=0 ; i<arr.length ; i++){
            //배열에 랜덤값 부여
            arr[i] = rand.nextInt(size - 1);

            //값이 있는지 확인 후 있으면 다시 랜덤값 부여
            for(int j=0 ; i<i ; j++){
                if(arr[i] == arr[j]){
                    arr[i] = rand.nextInt(size - 1);
                    i--;
                    break;
                }
            }
        }

        //랜덤값으로 하나씩 불러와 리스트에 담음
        List<RecipeVO> list = new ArrayList<>();
        for(int i=0 ; i<5 ; i++){
            list.add(recipeDAO.selectOne(arr[i]));
        }

        return list;
    }//randomList

    /**
     * 현재 냉장고의 재료로 레시피 추천받는 알고리즘
     * @return 레시피VO
     */
    public RecipeVO recomedList(){
        //나중에는 파라미터로 받아서 냉장고의 재료를 불러옴
        int member_id = 1;
        List<FridgeItemVO> fridgeList = fridgeItemDAO.selectList(member_id);
        
        //냉장고의 재료가 포함된 레시피를 모두 불러옴
        List<RecipeVO> recipeList = recipeDAO.selectAny(fridgeList);
        LinkedList<Integer> scoreList = new LinkedList<>();

        //YYYY-MM-DD
        String today = LocalDate.now().toString();
        StringTokenizer st = new StringTokenizer(today, "-");
        int todayYear = Integer.parseInt(st.nextToken());
        int todayMonth = Integer.parseInt(st.nextToken());
        int todayDay = Integer.parseInt(st.nextToken());

        for(FridgeItemVO item : fridgeList){
            String expire = item.getExpire_date().toString();
            st = new StringTokenizer(expire, "-");
            int exprieYear = Integer.parseInt(st.nextToken());
            int expireMonth = Integer.parseInt(st.nextToken());
            int expireDay = Integer.parseInt(st.nextToken());

            int score = expireDay - todayDay;
            if(score <= 3){
                score = 30;
            }else if(score <= 7){
                score = 10;
            }
        }

    }//RecipeVO

}
