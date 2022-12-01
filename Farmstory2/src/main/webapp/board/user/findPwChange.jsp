<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script>
	let regPass = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

	$(function(){
		$('.btnNext').click(function(e){
			e.preventDefault();
			
			let uid = $('.uid').text();
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			
			if(pass1 != pass2){
				alert('비밀번호가 일치하지 않습니다.');
				return;
			}
			if(!pass2.match(regPass)){
				alert('영문,숫자,특수문자 조합 최소 5자리 이상 이어야 합니다.');
				return;
			}

			let jsonData = {
					'uid':uid,
					'pass':pass2
			};
			console.log(jsonData);
			
			$.ajax({
				url:'/Farmstory2/board/user/findPwChange.do',
				method:'post',
				data:jsonData,
				dataType:'json',
				success:function(data){
					console.log(data.result);
					if(data.result > 0){
						alert('새로운 비밀번호로 변경했습니다.');
						location.href = '/Farmstory2/board/user/login.do';
					}
				}
			});
		});
	});
</script>
        <main id="user">
            <section class="find findPwChange">
                <form action="#">
                    <table border="0">
                        <caption>비밀번호 변경</caption>                        
                        <tr>
                            <td>아이디</td>
                            <td class="uid">${uid}</td>
                        </tr>
                        <tr>
                            <td>새 비밀번호</td>
                            <td>
                                <input type="password" name="pass1" placeholder="새 비밀번호 입력"/>
                            </td>
                        </tr>
                        <tr>
                            <td>새 비밀번호 확인</td>
                            <td>
                                <input type="password" name="pass2" placeholder="새 비밀번호 확인"/>
                            </td>
                        </tr>
                    </table>                                        
                </form>
                
                <p>
                    비밀번호를 변경해 주세요.<br>
                    영문, 숫자, 특수문자를 사용하여 8자 이상 입력해 주세요.                    
                </p>

                <div>
                    <a href="/Farmstory2/board/user/login.do" class="btn btnCancel">취소</a>
                    <a href="/Farmstory2/board/user/login.do" class="btn btnNext">다음</a>
                </div>
            </section>
        </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>