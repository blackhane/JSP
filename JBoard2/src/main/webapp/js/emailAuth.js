/**
 * 
 */
$(function(){
	let regMail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	//인증번호
	let receivedCode = 0;
	let isEmailAuthOk = false;
	
	//이메일 유효성 검사
	$('input[name=email]').keydown(function(){
		isEmailAuthOk = false;
	});
	
	$('input[name=email]').focusout(function(){
		let email = $(this).val();
		if(!email.match(regMail)){
			alert('유효하지 않은 이메일입니다.');
			isEmailAuthOk = false;
		}
	});
	
	//이메일 인증번호 받기
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
	
	//이메일 인증번호 확인
	$(".btnConfirm").click(function(){
		let code = $('input[name=auth]').val();
		
		if(code == ''){
			alert('인증코드를 입력하세요.');
			return;
		}
		if(code == receivedCode){
			alert('이메일이 인증 되었습니다.');
			$('input[name=auth]').attr('disabled', true);
			isEmailAuthOk = true;
		}else{
			isEmailAuthOk = false;
			alert('인증코드가 틀렸습니다.')
		}
	});
	
	//다음 버튼 클릭시 (아이디)
	$('.btnNextId').click(function(){
		if(isEmailAuthOk){
			let name = $('input[name=name]').val();
			let email = $('input[name=email]').val();
			
			let jsonData = {
				"name":name,
				"email":email
			};
			
			$.ajax({
				url:'/JBoard2/user/findId.do',
				type:'post',
				data:jsonData,
				dataType:'json',
				success:function(data){
					console.log(data.result);
					if(data.result == 1){
						location.href="/JBoard2/user/findIdResult.do";
					}else{
						alert('등록된 사용자가 없습니다.\n이름과 이메일을 다시 확인하십시요.');
					}
				}
			});
			
			return false;
		}else{
			alert('인증을 완료해주십시요.');
			return false;
		}
	});
	
	//다음 버튼 클릭시 (비밀번호)
	$('.btnNextPw').click(function(){
		if(isEmailAuthOk){
			let uid = $('input[name=uid]').val();
			let email = $('input[name=email]').val();
			
			let jsonData = {
				"uid":uid,
				"email":email
			};
			
			$.ajax({
				url:'/JBoard2/user/findPw.do',
				type:'post',
				data:jsonData,
				dataType:'json',
				success:function(data){
					console.log(data.result);
					if(data.result == 1){
						location.href="/JBoard2/user/findPwChange.do?uid=" + uid;
					}else{
						alert('등록된 사용자가 없습니다.\n아이디와 이메일을 다시 확인하십시요.');
					}
				}
			});
			
			return false;
		}else{
			alert('인증을 완료해주십시요.');
			return false;
		}
	});
	
});