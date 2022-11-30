<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
	$(function(){
		
		let passChk = false;
		
		$('.btnMyInfo').click(function(){
			
			let uid = $('input[name=uid]').val();
			let pass = $('input[name=pass]').val();
			
			let jsonData = {
				'uid' : uid,
				'pass' : pass
			};
			
			console.log(jsonData);
			
			if(pass == ''){
				passChk = false;
				alert('비밀번호를 입력해주세요.');
				return false;
			}else{
				passChk = true;
			}
			
			if(passChk){
				
				$.ajax({
					url : '/JBoard2/user/info.do',
					method : 'post',
					data : jsonData,
					dataType : 'json',
					success : function(data){
						console.log(data.result);
						if(data.result == 1){
							location.href = "/JBoard2/user/myInfo.do";
						}else{
							alert("비밀번호가 일치하지 않습니다.\n다시 확인해주십시요.");
						}
					}
				});
			}
			
			return false;
		});
		
		//input 엔터키 금지
		$('input[type="password"]').keydown(function() {
			  if (event.keyCode === 13) {
			    event.preventDefault();
			  };
		});
		
	});
</script>
<main id="user">
    <section class="find findId">
        <form action="#" method="post">
        <input type="hidden" name="uid" value="${sessUser.uid}"/>
            <table border="0">
                <caption>비밀번호 확인</caption>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass" placeholder="비밀번호 입력"/></td>
                </tr>                       
            </table>                                        
        </form>
        
        <p>
            회원님의 정보를 보호하기 위해 비밀번호를 다시 확인합니다.
        </p>

        <div>
            <a href="/JBoard2/list.do" class="btn btnCancel">취소</a>
            <a href="/JBoard2/user/myInfo.do" class="btn btnMyInfo">다음</a>
        </div>
    </section>
</main>
<jsp:include page="./_footer.jsp"/>