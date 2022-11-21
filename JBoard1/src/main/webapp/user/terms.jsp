<%@page import="kr.co.jboard1.dao.UserDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="kr.co.jboard1.bean.TermsBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file ="./_header.jsp" %>
<script>
	//약관동의 체크
	$(function() {
		$('.next').click(function(){
			let isCheck1 = $('input[class=terms]').is(':checked');
			let isCheck2 = $('input[class=privacy]').is(':checked');
			
			if(isCheck1 && isCheck2)
				return true;
			else
				alert('필수항목에 체크해주세요.');
				return false;
		});
	});
</script>
<%
	TermsBean term = UserDAO.getinstance().selectTerm();
%>
<main id="user" class="terms">
    <table border="0">
        <caption>사이트 이용약관 (필수)</caption>
        <tr>
            <td>
                <textarea class="terms" readonly><%= term.getTerms() %></textarea>
                <label><input type="checkbox" class="terms">&nbsp;동의합니다.</label>
            </td>
        </tr>
    </table>
    <table border="0">
        <caption>개인정보 취급방침 (필수)</caption>
        <tr>
            <td>
                <textarea class="privacy" readonly><%= term.getPrivacy() %></textarea>
                <label><input type="checkbox" class="privacy">&nbsp;동의합니다.</label>
            </td>
        </tr>
    </table>
    <p>
        <a href="/JBoard1/user/login.jsp" class="cancel">취소</a>
        <a href="/JBoard1/user/register.jsp" class="next">다음</a>
    </p>
</main>
<%@ include file ="./_footer.jsp" %>