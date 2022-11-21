<%@page import="kr.co.farmstory1.bean.TermsBean"%>
<%@page import="kr.co.farmstory1.dao.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	TermsBean tb = UserDAO.getInstance().selectTerms();
%>
<%@ include file="../_header.jsp" %>
<script>
	$(function(){
		$('.next').click(function(){
			let isCheck1 = $('input[class=terms]').is(':checked');
			let isCheck2 = $('input[class=privacy]').is(':checked');
			
			if(isCheck1 && isCheck2){
				return true;
			}else{
				alert("필수 약관에 체크해주세요.");
				return false;	
			}
		});
	});
</script>
<main id="user" class="terms">
    <table border="0">
        <caption>사이트 이용약관</caption>
        <tr>
            <td>
                <textarea class="terms" readonly><%=tb.getTerms() %></textarea>
                <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
            </td>
        </tr>
    </table>
    <table border="0">
        <caption>개인정보 취급방침</caption>
        <tr>
            <td>
                <textarea class="privacy" readonly><%=tb.getPrivacy() %></textarea>
                <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
            </td>
        </tr>
    </table>
    <p>
        <a href="./login.jsp" class="cancel">취소</a>
        <a href="./register.jsp" class="next">다음</a>
    </p>
</main>
<%@ include file="../_footer.jsp" %>