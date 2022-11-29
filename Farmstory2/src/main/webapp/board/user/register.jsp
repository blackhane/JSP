<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

	$(function(){
		//유효성 검사//
		let isUidOk 	= false;
		let isPassOk 	= false;
		let isNameOk 	= false;
		let isNickOk 	= false;
		let isEmailOk	= false;
		let isEmailAuthOk = false;
		let isHpOk		= false;
		
		//정규표현식
		let regUid = /^[a-z]+[a-z0-9]{4,19}$/g;
		let regMail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		let regHp = /^\d{3}-\d{3,4}-\d{4}$/;
		let regPass = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		let regName = /^[가-힣]{2,4}$/;
		let regNick = /[0-9]|[a-z]|[A-Z]|[가-힣]{2,10}/;
		
		//아이디
		$('input[name=uid]').keydown(function(){
			isUidOk = false;
			$('.uidResult').text('');
		});
		
		$('#CheckUid').click(function(){
			let uid = $('input[name=uid]').val();

			//유효성 검사
			if(!uid.match(regUid)){
				isUidOk = false;
				alert('유효하지 않은 아이디입니다.');
				$('.uidResult').css('color','red').text('X');
				return;
			}
			console.log(uid);
			//중복확인
			$.ajax({
				url : '/Farmstory2/board/user/checkUid.do',
				method : 'post',
				data : {'uid' : uid},
				dataType : 'json',
				success : function(data){
					console.log(data.result);
					if(data.result > 0){
						isUidOk = false;
						alert('이미 사용중인 아이디입니다.');
						$('.uidResult').css('color','red').text('X');
					}else{
						isUidOk = true;
						alert('사용 가능한 아이디입니다.');
						$('.uidResult').css('color','green').text('O');
					}
				}
			});
		});
		
		//비밀번호
		$('input[name=pass1]').keydown(function(){
			isPassOk = false;
			$('.pass1Result').text('');
		});
		
		$('input[name=pass2]').keydown(function(){
			isPassOk = false;
			$('.pass2Result').text('');
		});
		
		$('input[name=pass1]').focusout(function(){
			let pass1 = $(this).val();
			console.log(pass1);
			if(!pass1.match(regPass)){
				isPassOk = false;
				alert('유효하지 않은 비밀번호입니다.\n영문,숫자,특수문자 포함 5~15자리를 입력해주세요.');
				$('.pass1Result').css('color','red').text('X');
				return;
			}
			$('.pass1Result').css('color','green').text('O');
		});
		
		$('input[name=pass2]').focusout(function(){
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $(this).val();
			console.log(pass2);
			
			if(pass1 == ''){
				return;
			}
			
			if(pass2 == pass1){
				isPassOk = true;
				alert('비밀번호가 일치합니다.');
				$('.pass2Result').css('color','green').text('O');
			}else{
				isPassOk = false;
				alert('비밀번호가 일치하지 않습니다.');
				$('.pass2Result').css('color','red').text('X');
			}
		});
		
		//이름
		$('input[name=name]').keydown(function(){
			isNameOk = false;
			$('.nameResult').text('');
		});
		
		$('input[name=name]').focusout(function(){
			let name = $(this).val();
			console.log(name);
			if(!name.match(regName)){
				isNameOk = false;
				$(this).blur(); //alert 무한루프 방지
				alert('이름은 한글 2글자 이상입니다.');
				$('.nameResult').css('color','red').text('X');
			}else{
				isNameOk = true;
				$('.nameResult').css('color','green').text('O');
			}
		});
		
		//별명
		$('input[name=nick]').keydown(function(){
			isNickOk = false;
			$('.nickResult').text('');
		});
		
		$('#CheckNick').click(function(){
			let nick = $('input[name=nick]').val();

			//유효성 검사
			if(!nick.match(regNick)){
				isNickOk = false;
				alert('유효하지 않은 별명입니다.');
				$('.nickResult').css('color','red').text('X');
				return;
			}
			console.log(nick);
			//중복확인
			$.ajax({
				url : '/Farmstory2/board/user/checkNick.do',
				method : 'post',
				data : {'nick' : nick},
				dataType : 'json',
				success : function(data){
					console.log(data.result);
					if(data.result > 0){
						isNickOk = false;
						alert('이미 사용중인 별명입니다.');
						$('.nickResult').css('color','red').text('X');
					}else{
						isNickOk = true;
						alert('사용 가능한 별명입니다.');
						$('.nickResult').css('color','green').text('O');
					}
				}
			});
		});
		
		//이메일
		$('input[name=email]').keydown(function(){
			isEmailOk = false;
			$('.emailResult').text('');
		});
		
		$('#CheckEmail').click(function(){
			let email = $('input[name=email]').val();
			console.log(email);
			
			if(email == ''){
				isEmailOk = false;
				alert('이메일을 확인하십시요.');
				return;
			}
			
			if(!email.match(regMail)){
				isEmailOk = false;
				alert('유효하지 않은 메일주소입니다.');
				return;
			}
			
			$('.emailResult').css({'color':'black','font-weight':'bold'}).text('메일을 발송 중 입니다.');
			
			$.ajax({
				url : '/Farmstory2/board/user/emailAuth.do',
				method : 'post',
				data : {'email' : email},
				dataType : 'json',
				success : function(data){
					console.log(data.status);
					if(data.status > 0){
						//성공
						isEmailAuthOk = true;
						alert('메일 전송에 성공했습니다. 인증코드를 입력해주십시요.');
						$('.emailResult').text('');
						$('.auth').show();
						receivedCode = data.code;
					}else{
						//실패
						isEmailAuthOk = false;
						alert('메일 전송에 실패했습니다. 다시 시도해 주십시요.');
					}
				}
			});
			
			$('#CheckEmailCode').click(function(){
				let code = $('input[name=auth]').val();
				
				if(code == ''){
					alert('인증코드를 입력해주십시요.');
					return;
				}
				
				if(code == receivedCode){
					isEmailOk = true;
					alert('인증이 완료되었습니다.');
					$('.emailResult').css('color','green').text('O');
					$('.auth').hide();
				}else{
					isEmailOk = false;
					alert('인증코드가 틀립니다. 다시 확인해주십시요.');				
				}
				
			});
		});
		
		//휴대폰
		$('input[name=hp]').keydown(function(){
			isHpOk = false;
			$('.hpResult').text('');
		});
		
		$('input[name=hp]').focusout(function(){
			let hp = $(this).val();
			
			if(!hp.match(regHp)){
				isHpOk = false;
				alert('유효하지 않는 전화번호입니다.');
				$('.hpResult').css('color','red').text('X');
			}else{
				isHpOk = true;
				$('.hpResult').css('color','green').text('O');
			}
		});
		
		//폼 전송
		$('.register > form').submit(function(){
			if(!isUidOk){
				alert('아이디를 확인하십시요.');
				$('input[name=uid]').focus();
				return false;
			}
			if(!isPassOk){
				alert('비밀번호를 확인하십시요.');
				$('input[name=pass1]').focus();
				return false;
			}
			if(!isNameOk){
				alert('이름을 확인하십시요.');
				$('input[name=name]').focus();
				return false;
			}
			if(!isNickOk){
				alert('별명을 확인하십시요.');
				$('input[name=nick]').focus();
				return false;
			}
			if(!isEmailOk){
				alert('이메일을 확인하십시요.');
				$('input[name=email]').focus();
				return false;
			}
			if(!isEmailAuthOk){
				alert('이메일 인증을 확인하십시요.');
				$('input[name=auth]').focus();
				return false;
			}
			if(!isHpOk){
				alert('전화번호를 확인하십시요.');
				$('input[name=hp]').focus();
				return false;
			}
			
			return true;
		});
	});
	//주소
	function postcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수

	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('zip').value = data.zonecode;
	            document.getElementById("addr1").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("addr2").focus();
	        }
	    }).open();
	}
</script>
<style>
	span {font-weight : bold;}
</style>
        <main id="user">
            <section class="register">
                <form action="/Farmstory2/board/user/register.do" method="post">
                    <table border="1">
                        <caption>사이트 이용정보 입력</caption>
                        <tr>
                            <td>아이디</td>
                            <td>
                                <input type="text" name="uid" placeholder="아이디 입력"/>
                                <button type="button" id="CheckUid"><img src="/Farmstory2/board/img/chk_id.gif" alt="중복확인"/></button>
                                <span class="uidResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td>
	                            <input type="password" name="pass1" placeholder="비밀번호 입력"/>
	                            <span class="pass1Result"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호 확인</td>
                            <td>
	                            <input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
	                            <span class="pass2Result"></span>
                            </td>
                        </tr>
                    </table>

                    <table border="1">
                        <caption>개인정보 입력</caption>
                        <tr>
                            <td>이름</td>
                            <td>
                                <input type="text" name="name" placeholder="이름 입력"/>
                                <span class="nameResult"></span>                      
                            </td>
                        </tr>
                        <tr>
                            <td>별명</td>
                            <td>
                                <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                                <input type="text" name="nick" placeholder="별명 입력"/>
                                <button type="button" id="CheckNick"><img src="/Farmstory2/board/img/chk_id.gif" alt="중복확인"/></button>
                                <span class="nickResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>
                                
                                <input type="email" name="email" placeholder="이메일 입력"/>
                                <button type="button" id="CheckEmail"><img src="/Farmstory2/board/img/chk_auth.gif" alt="인증번호 받기"/></button>
                                <span class="emailResult"></span>
                                <div class="auth">
                                    <input type="text" name="auth" placeholder="인증번호 입력"/>
                                    <button type="button" id="CheckEmailCode"><img src="/Farmstory2/board/img/chk_confirm.gif" alt="확인"/></button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>휴대폰</td>
                            <td>
	                            <input type="text" name="hp" placeholder="휴대폰 입력"/>
	                            <span class="hpResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td>
                                <input type="text" name="zip" id="zip" placeholder="우편번호"/>
                                <button type="button" onclick="postcode()"><img src="/Farmstory2/board/img/chk_post.gif" alt="우편번호찾기"/></button>
                                <input type="text" name="addr1" id="addr1" placeholder="주소 검색"/>
                                <input type="text" name="addr2" id="addr2" placeholder="상세주소 입력"/>
                            </td>
                        </tr>
                    </table>

                    <div>
                        <a href="/Farmstory2/board/user/login.do" class="btn btnCancel">취소</a>
                        <input type="submit" value="회원가입" class="btn btnRegister"/>
                    </div>

                </form>

            </section>
        </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>