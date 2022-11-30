<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/JBoard2/js/userModify.js"></script>
<style>
	span {font-weight:bold;}
</style>
<main id="user">
    <section class="register">

        <form action="/JBoard2/user/myInfo.do" method="post">
            <table border="1">
                <caption>회원정보 설정</caption>
                <tr> 
                    <td>아이디</td>
                    <td><input type="hidden" name="uid" value="${user.uid}"/>${user.uid}</td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass1" placeholder="비밀번호 입력"/> <span class="passResult"></span></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td>
                    	<input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
                    	<button type="button" style="padding:3px; background: #2e658a; color:#fff;" class="passModify">비밀번호 수정</button>
                    </td>
                </tr>
                <tr>
                	<td>회원가입일</td>
	               	<td>${user.rdate}</td>
                </tr>
            </table>

            <table border="1">
                <caption>개인정보 수정</caption>
                <tr>
                    <td>이름</td>
                    <td>
                        <input type="text" name="name" value="${user.name}"/>
                        <span class="nameResult"></span>           
                    </td>
                </tr>
                <tr>
                    <td>별명</td>
                    <td>
                        <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                        <input type="text" name="nick" value="${user.nick}"/>
                        <button type="button" id="btnNickCheck"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                        <span class="nickResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        
                        <input type="email" name="email" value="${user.email}"/>
                        <button type="button" id="btnEmail"><img src="../img/chk_auth.gif" alt="인증번호 받기"/></button>
                        <span class="emailResult"></span>
                        <div class="auth">
                            <input type="text" name="auth" placeholder="인증번호 입력"/>
                            <button type="button" id="btnEmailConfirm"><img src="../img/chk_confirm.gif" alt="확인"/></button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>휴대폰</td>
                    <td><input type="text" name="hp" value="${user.hp}"/><span class="hpResult"></span></td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td>
                        <input type="text" name="zip" id="zip" value="${user.zip}"/>
                        <button type="button" onclick="postcode()"><img src="../img/chk_post.gif" alt="우편번호찾기"/></button>
                        <input type="text" name="addr1" id="addr1" value="${user.addr1}"/>
                        <input type="text" name="addr2" id="addr2" value="${user.addr2}"/>
                    </td>
                </tr>
                <tr>
                	<td>회원탈퇴</td>
                	<td><button type="button" style="padding:6px; background: #ed2f2f; color:#fff;" class="userDelete">탈퇴하기</button></td>
                </tr>
            </table>

            <div>
                <a href="/JBoard2/user/login.do" class="btn btnCancel">취소</a>
                <input type="submit" value="회원수정" class="btn btnRegister"/>
            </div>

        </form>

    </section>
</main>
<jsp:include page="./_footer.jsp"/>