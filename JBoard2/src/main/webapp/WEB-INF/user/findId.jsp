<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
	$(function(){
		
		let regMail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		//인증코드
		let receivedCode = 0;
		let isEmailOk = false;
		
		//이메일 유효성 검사
		$('input[name=email]').keydown(function(){
			isEmailOk = false;
		});
		
		$('input[name=email]').focusout(function(){
			let email = $(this).val();
			if(!email.match(regMail)){
				alert('유효하지 않은 이메일입니다.');
				isEmailOk = false;
			}
		});
		
		//이메일 인증
		$('.btnAuth').click(function(){
			let email = $('input[name=email]').val();
			
			if(email == ''){
				alert('이메일을 입력하세요.');
				return;
			}
			
			$.ajax({
				url:'/JBoard2/user/emailAuth.do',
				method:'get',
				data:{'email':email},
				dataType:'json',
				success:function(data){
					receivedCode = data.code;
					$('input[name=auth]').attr('disabled', false);
				}
			});
		});
		
		//이메일 인증코드 확인
		$(".btnConfirm").click(function(){
			let code = $('input[name=auth]').val();
			
			if(code == ''){
				alert('인증코드를 입력하세요.');
				return;
			}
			if(code == receivedCode){
				alert('이메일이 인증 되었습니다.');
				$('input[name=auth]').attr('disabled', true);
				let isEmailOk = true;
			}else{
				let isEmailOk = false;
				alert('인증코드가 틀렸습니다.')
			}
		});
		
	});
	
</script>

<main id="user">
    <section class="find findId">
        <form action="/JBoard2/user/findIdResult.do" method="post">
            <table border="0">
                <caption>아이디 찾기</caption>
                <tr>
                    <td>이름</td>
                    <td><input type="text" name="name" placeholder="이름 입력"/></td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <div>
                            <input type="email" name="email" placeholder="이메일 입력"/>
                            <button type="button" class="btnAuth">인증번호 받기</button>
                        </div>
                        <div class="emailConfrim">
                            <input type="text" name="auth" disabled placeholder="인증번호 입력"/>
                            <button type="button" class="btnConfirm">확인</button>
                        </div>
                    </td>
                </tr>                        
            </table>                                        
        </form>
        
        <p>
            회원가입시 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.<br>
            인증번호를 입력 후 확인 버튼을 누르세요.
        </p>

        <div>
            <a href="/JBoard2/user/login.do" class="btn btnCancel">취소</a>
            <a href="#" class="btn btnNext">다음</a>
        </div>
    </section>
</main>
<jsp:include page="./_footer.jsp"/>