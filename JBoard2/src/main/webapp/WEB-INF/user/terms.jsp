<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="./_header.jsp"/>
<script>
	//약관동의 체크 여부
	$(function(){
		$('.btnNext').click(function(){
			let isCheck1 = $('input[class=terms]').is(':checked');
			let isCheck2 = $('input[class=privacy]').is(':checked');
			
			if(isCheck1 && isCheck2){
				return true;
			}else{
				alert('필수항목에 체크해주십시요.');
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
                    <textarea name="terms">${requestScope.vo.terms }</textarea>
                    <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
                </td>
            </tr>
        </table>

        <table border="1">
            <caption>개인정보 취급방침</caption>
            <tr>
                <td>
                    <textarea name="privacy">${vo.privacy }</textarea>
                    <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
                </td>
            </tr>
        </table>
        
        <div>
            <a href="/JBoard2/user/login.do" class="btn btnCancel">취소</a>
            <a href="/JBoard2/user/register.do" class="btn btnNext">다음</a>
        </div>

    </section>
</main>
<jsp:include page="./_header.jsp"/>