<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Session</title>
	</head>
	<body>
		<jsp:include page="./Link.jsp"/>
		<h2>로그인 페이지</h2>
		<span style="color:red; font-size: 16px;">
			<%= request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg") %>
		</span>
		
		<%
			//로그인 상태 확인
			if(session.getAttribute("UserId") == null){
		%>
		<!-- 로그인 X -->
		<form action="./LoginProcess.jsp" method="post" name="loginFrm">
			아이디 : <input type="text" name="user_id"  required/><br/>
			패스워드 : <input type="password" name="user_pw"  required/><br/>
			<input type="submit" value="로그인">
		</form>
		<% } else { %>
		<!-- 로그인 O -->
			<%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br/>
			<a href="./Logout.jsp">[로그아웃]</a>
		<% } %>
	</body>
</html>