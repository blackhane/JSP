<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<table border="1" width="90%">
	<tr>
		<td align='center'>
			<% if(session.getAttribute("UserId") == null) { %>
				<a href="./Login.jsp">로그인</a>
			<% } else { %>
				<a href="./Logout.jsp">로그아웃</a>
			<% } %>
			&nbsp;&nbsp;&nbsp;
			<a href="./List1.jsp">게시판(페이징x)</a>			
			&nbsp;&nbsp;&nbsp;
			<a href="./List2.jsp">게시판(페이징o)</a>
			
		</td>
	</tr>
</table>