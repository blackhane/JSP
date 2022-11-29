<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<script>
	$(function(){
		
		$('.btnNext').click(function(){
			let check1 = $('input[class=terms]').is(':checked');
			let check2 = $('input[class=privacy]').is(':checked');
			
			if(check1 && check2){
				return true;
			}else{
				alert('약관에 동의해주십시요.');
				return false;
			}
		});
	});
</script>
        <main id="user">
            <section class="terms">
                <table border="1">
                    <caption>사이트 이용약관</caption>
                    <tr>
                        <td>
                            <textarea name="terms" readonly>${terms.terms }</textarea>
                            <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
                        </td>
                    </tr>
                </table>

                <table border="1">
                    <caption>개인정보 취급방침</caption>
                    <tr>
                        <td>
                            <textarea name="privacy" readonly>${terms.privacy }</textarea>
                            <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
                        </td>
                    </tr>
                </table>
                
                <div>
                    <a href="/Farmstory2/board/user/login.do" class="btn btnCancel">취소</a>
                    <a href="/Farmstory2/board/user/register.do" class="btn btnNext">다음</a>
                </div>

            </section>
        </main>
<jsp:include page="/WEB-INF/_footer.jsp"/>