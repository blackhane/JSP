<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<main id="user" class="register">
    <form action="/Farmstory1/user/proc/registerProc.jsp">
        <table border="1">
            <caption>사이트 이용정보 입력</caption>
            <tr>
                <th>아이디</th>
                <td>
                    <input type="text" name="uid" placeholder="아이디 입력">
                    <button type="button"><img src="./img/chk_id.gif" alt="중복확인"></button>
                    <span class="resultUid"></span>
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>
                    <input type="password" name="pass1" placeholder="비밀번호 입력">
                    <span class="resultPass"></span>
                </td>
            </tr>
            <tr>
                <th>비밀번호 확인</th>
                <td>
                    <input type="password" name="pass2" placeholder="비밀번호 확인 입력">
                </td>
            </tr>
        </table>
        <table border="1">
            <caption>개인정보 입력</caption>
            <tr>
                <th>이름</th>
                <td>
                    <input type="text" name="name" placeholder="이름 입력">
                </td>
            </tr>
            <tr>
                <th>별명</th>
                <td>
                    <p>공백없이 한글, 영문, 숫자만 입력가능</p>
                    <input type="text" name="nick" placeholder="별명 입력">
                    <button type="button"><img src="./img/chk_id.gif" alt="중복확인"></button>
                    <span class="resultNick"></span>
                </td>
            </tr>
            <tr>
                <th>E-Mail</th>
                <td>
                    <input type="email" name="email" placeholder="이메일 입력">
                </td>
            </tr>
            <tr>
                <th>휴대폰</th>
                <td>
                    <input type="tel" name="phone" placeholder="- 포함 13자리 입력">
                </td>
            </tr>
            <tr>
                <th>주소</th>
                <td>
                    <input type="text" name="zip" placeholder="우편번호" readonly>
                    <button type="button"><img src="./img/chk_post.gif" alt="우편번호찾기"></button>
                    <input type="text" name="add1" placeholder="주소를 검색하세요." readonly>
                    <input type="text" name="add2" placeholder="상세주소를 입력하세요.">
                </td>
            </tr>
        </table>
        <div>
            <a href="./login.jsp" class="btnCancel">취소</a>
            <input type="submit" class="btnRegister" value="회원가입">
        </div>
    </form>
</main>
<%@ include file="../_footer.jsp" %>