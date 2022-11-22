<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script src="http://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function () {
		
		//정규표현식
		let regUid = /^[a-z]+[a-z0-9]{4,19}$/g;
		let regMail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		let regHp = /^\d{3}-\d{3,4}-\d{4}$/;
		let regPass = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		let regName = /^[가-힣]{2,4}$/;
		let regNick = /[0-9]|[a-z]|[A-Z]|[가-힣]{2,10}/;
		
		//유효성 검사
		let isUidOk 	= false;
		let isPassOk 	= false;
		let isNameOk 	= false;
		let isNickOk 	= false;
		let isEmailOk	= false;
		let isEmailAuthOk = false;
		let isHpOk		= false;
		
		//아이디 중복체크
		$('input[name=uid]').keydown(function(){
			let isUidOk = false;
		});
		$('#btnUidCheck').click(function() {
			let uid = $('input[name=uid]').val();
			
			if(isUidOk){
				return;
			}
			
			//유효성 검사
			if(!uid.match(regUid)){
				isUidOk = false;
				$('.uidResult').css('color','red').text('유효하지 않은 아이디 입니다.');
				return;
			}
			
			setTimeout(function(){
			$.ajax({
				url:'/JBoard2/user/checkUid.do',
				method:'get',
				data:{"uid":uid},
				dataType:'json',
				success:function(data){
					if(data.result > 0){
						isUidOk = false;
						$('.uidResult').css('color','red').text('이미 사용중인 아이디 입니다.');
					}else{
						isUidOk = true;
						$('.uidResult').css('color','green').text('사용 가능한 아이디 입니다.');
					}
				}
			});
			},1000);
		});
		
		//비밀번호 일치 체크
		$('input[name=pass2]').focusout(function(){
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $(this).val();
			console.log(pass1);
			console.log(pass2);
			
			if(pass1 == pass2){
				if(pass2.match(regPass)){
					isPassOk = true;
					$('.passResult').css({'color':'green','font-size':'12px'}).text('비밀번호가 일치합니다.');
				}else{
					//유효성 검사
					isPassOk = false;
					$('.passResult').css({'color':'red','font-size':'11px'}).text('영문,숫자,특수문자 조합 최소 5자리 이상 이어야 합니다.');
				}
			}else{
				isPassOk = false;
				$('.passResult').css({'color':'red','font-size':'12px'}).text('비밀번호가 일치하지 않습니다.');
			}
		});
		
		//이름 유효성 검사
		$('input[name=name]').focusout(function(){
			let name = $(this).val();
			if(!name.match(regName)){
				isNameOk = false;
				$('.nameResult').css('color','red').text('유효하지 않은 이름입니다.');
			}else{
				isNameOk = true;
				$('.nameResult').text('');
			}
		});
		
		//별명 중복체크
		$('input[name=nick]').keydown(function(){
			let isNickOk = false;
		});
		$('#btnNickCheck').click(function(){
			let nick = $('input[name=nick]').val();
			
			if(isNickOk){
				return;
			}
			
			//유효성 검사
			if(!nick.match(regNick)){
				isNickOk = false;
				$('.nickResult').css('color','red').text('유효하지 않은 별명입니다.');
				return;
			}
			
			setTimeout(function(){
			$.ajax({
				url:'/JBoard2/user/checkNick.do',
				method:'get',
				data:{"nick":nick},
				dataType:'json',
				success:function(data){
					console.log(data.result);
					if(data.result > 0){
						isNickOk = false;
						$('.nickResult').css('color','red').text('이미 사용중인 별명 입니다.');
					}else{
						isNickOk = true;
						$('.nickResult').css('color','green').text('사용 가능한 별명 입니다.');
					}
				}
			});
			},1000);
		});
		
		//이메일 유효성 검사
		$('input[name=email]').keydown(function(){
			isEmailOk = false;
			isEmailAuthOk = false;
		});
		$('input[name=email]').focusout(function(){
			let email = $(this).val();
			if(!email.match(regMail)){
				isEmailOk = false;
				$('.emailResult').css('color','red').text('유효하지 않은 이메일 입니다.');
				$('.auth').hide();
			}else{
				isEmailOk = true;
				$('.emailResult').text('');
			}
		});
		
		let receivedCode = 0;
		
		//이메일 인증
		$('#btnEmail').click(function(){
			//이메일 인증코드 발송
			let email = $('input[name=email]').val();
			
			if(email == ''){
				alert('이메일을 확인하세요.');
				return;
			}
			
			if(isEmailAuthOk){
				return;
			}
			isEmailAuthOk = true;
			
			$('.emailResult').css('color','black').text('인증코드 전송 중...');
			
			setTimeout(function(){
				$.ajax({
					url:'/JBoard2/user/emailAuth.do',
					method:'get',
					data:{"email":email},
					dataType:'json',
					success:function(data){
						if(data.status > 0){
							//메일전송 성공
							isEmailAuthOk = true;
							$('.emailResult').css('color','red').text('인증코드를 확인 후 입력하세요.');
							$('.auth').show();
							$(this).hide();
							receivedCode = data.code;
						}else{
							//메일전송 실패
							isEmailAuthOk = false;
							$('.emailResult').text('');
							alert('메일전송이 실패했습니다.\n다시 시도하시기 바랍니다.');
							$('.auth').hide();
						}
					}
				});
			}, 1000);
			
			//이메일 인증코드 확인
			$("#btnEmailConfirm").click(function(){
				let code = $('input[name=auth]').val();
				
				if(code == ''){
					alert('이메일 확인 후 인증코드를 입력하세요.');
				}
				if(code == receivedCode){
					alert('이메일이 인증 되었습니다.');
					$('.emailResult').css('color','green').text('이메일이 인증 되었습니다.');
					$('.auth').hide();
				}else{
					alert('인증코드가 틀립니다.')
				}
			});
		});
		
		//핸드폰 유효성 검사
		$('input[name=hp]').focusout(function(){
			let hp = $(this).val();
			if(!hp.match(regHp)){
				isHpOk = false;
				$('.hpResult').css('color','red').text('유효하지 않은 전화번호 입니다.');
			}else{
				isHpOk = true;
				$('.hpResult').text('');
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
				$('input[name=email]').focus();
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
<main id="user">
    <section class="register">

        <form action="/JBoard2/user/register.do" method="post">
            <table border="1">
                <caption>사이트 이용정보 입력</caption>
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="uid" placeholder="아이디 입력"/>
                        <button type="button" id="btnUidCheck"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                        <span class="uidResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass1" placeholder="비밀번호 입력"/> <span class="passResult"></span></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td><input type="password" name="pass2" placeholder="비밀번호 입력 확인"/></td>
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
                        <button type="button" id="btnNickCheck"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                        <span class="nickResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        
                        <input type="email" name="email" placeholder="이메일 입력"/>
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
                    <td><input type="text" name="hp" placeholder="휴대폰 입력"/><span class="hpResult"></span></td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td>
                        <input type="text" name="zip" id="zip" placeholder="우편번호"/>
                        <button type="button" onclick="postcode()"><img src="../img/chk_post.gif" alt="우편번호찾기"/></button>
                        <input type="text" name="addr1" id="addr1" placeholder="주소 검색"/>
                        <input type="text" name="addr2" id="addr2" placeholder="상세주소 입력"/>
                    </td>
                </tr>
            </table>

            <div>
                <a href="/JBoard2/user/login.do" class="btn btnCancel">취소</a>
                <input type="submit" value="회원가입" class="btn btnRegister"/>
            </div>

        </form>

    </section>
</main>
<jsp:include page="./_footer.jsp"/>