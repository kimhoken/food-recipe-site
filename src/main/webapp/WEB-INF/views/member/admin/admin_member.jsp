<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section>
    <div>
        <div>
            <h3>회원 관리</h3>
        </div>
        <small>전체 회원 목록 및 상세 정보를 확인 할수 있습니다.</small>

        <div>
            <div>
                <input type="text" placeholder="아이디, 닉네임, 이메일 검색"/>
                <select>
                    <option value="">상태</option>
                    <option value="active">정상</option>
                    <option value="suspend">정지</option>
                    <option value="withdraw">탈퇴</option>
                </select>
               
            </div>
            <table border="1">
                <tr>
                    <th>프로필</th>
                    <th>닉네임</th>
                    <!-- 아이디 일반 회원은 실제 아이디 출력, 소셜 회원은 가입한 플랫폼 출력  -->
                    <th>아이디</th>    
                    <th>이메일</th>
                    <th>신고수</th>
                    <th>상태</th>
                    <th>가입일</th>
                </tr>

                <!-- forEach문으로 회원 출력 -->
                 <tr>
                    <td>
                        <img src="#"/>
                    </td>
                    <td>라이언</td>
                    <td>kakao</td>
                    <td>kakaosample@kakao.com</td>
                    <td>10</td>
                    <td>active</td>
                    <td>2026-06-22</td>
                 </tr>
            </table>

            <div>
                <div>총 회원수: 12</div>
                <div>페이징</div>
                
            </div>

        </div>

    </div>
</section>
