<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<table border="1" width="90%">
	<tr>
		<td algin='center'>
			<% if(session.getAttribute("UserId") == null) { %>
				<a href="/Book_Ch06/LoginForm.jsp">로그인</a>
			<% } else { %>
				<a href="/Book_Ch06/Logout.jsp">로그아웃</a>
			<% } %>
			&nbsp;&nbsp;&nbsp;
			<a href="/Book_Ch06/List.jsp">게시판(페이징x)</a>			
			&nbsp;&nbsp;&nbsp;
			<a href="/Book_Ch06/PagingBoard/List.jsp">게시판(페이징o)</a>
			
		</td>
	</tr>
</table>