<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script>
	$(function(){
		
		let regMail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		let isEmailOk = false; 
		let isEmailAuthOk = false;
		
		
		//이메일
		$('input[name=email]').keydown(function(){
			isEmailOk = false;
			$('.emailResult').text('');
		});
		
		$('.btnAuth').click(function(){
			let email = $('input[name=email]').val();
			console.log(email);
			
			if(email == ''){
				isEmailOk = false;
				alert('이메일을 확인하십시요.');
				$('.emailResult').css({'color':'red','font-weight':'bold'}).text('X');
				return;
			}
			
			if(!email.match(regMail)){
				isEmailOk = false;
				alert('유효하지 않은 메일주소입니다.');
				$('.emailResult').css({'color':'red','font-weight':'bold'}).text('X');
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
		});	
		
		$('.btnConfirm').click(function(){
			let code = $('input[name=auth]').val();
			
			if(code == ''){
				alert('인증코드를 입력해주십시요.');
				return;
			}
			
			if(code == receivedCode){
				isEmailOk = true;
				alert('인증이 완료되었습니다.');
				$('.emailResult').css({'color':'green','font-weight':'bold'}).text('O');
				$('.auth').hide();
			}else{
				isEmailOk = false;
				alert('인증코드가 틀립니다. 다시 확인해주십시요.');				
			}
			
		});
		
		$('.btnNext').click(function(){
			let uid = $('input[name=uid]').val();
			let email = $('input[name=email]').val();
			
			let jsonData = {
				'uid':uid,
				'email':email
			};
			console.log(jsonData);
			
			if(isEmailOk && isEmailAuthOk){
				$.ajax({
					url : '/Farmstory2/board/user/findPw.do',
					method : 'post',
					data : jsonData,
					dataType : 'json',
					success : function(data){
						console.log(data.result);
						if(data.result == 1){
							location.href = "/Farmstory2/board/user/findPwChange.do?uid="+uid;
							return true;
						}else{
							alert('등록된 사용자가 존재하지 않습니다.');
							return false;
						}
					}
				});
			}else{
				alert('이메일 인증을 완료해주십시요.');
				return false;
			}
		});
	});
</script>
        <main id="user">
            <section class="find findPw">
                <form action="#">
                    <table border="0">
                        <caption>비밀번호 찾기</caption>                        
                        <tr>
                            <td>아이디</td>
                            <td><input type="text" name="uid" placeholder="아이디 입력"/></td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td>
                                <div>
                                    <input type="email" name="email" placeholder="이메일 입력"/>
                                    <button type="button" class="btnAuth">인증번호 받기</button>
                                    <span class="emailResult"></span>
                                </div>
                                <div class="auth" style="display:none">
                                    <input type="text" name="auth" placeholder="인증번호 입력"/>
                                    <button type="button" class="btnConfirm">확인</button>
                                </div>
                            </td>
                        </tr>                        
                    </table>                                        
                </form>
                
                <p>
                    비밀번호를 찾고자 하는 아이디와 이메일을 입력해 주세요.<br>                    
                    회원가입시 입력한 아이디와 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.<br>
                    인증번호를 입력 후 확인 버튼을 누르세요.
                </p>

                <div>
                    <a href="/Farmstory2/board/user/login.do" class="btn btnCancel">취소</a>
                    <a href="/Farmstory2/board/user/findPwChange.do" class="btn btnNext">다음</a>
                </div>
            </section>
        </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>