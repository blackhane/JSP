<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String ErrCode = request.getParameter("ErrCode");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>모델1 게시판</title>
		<script>
			let ErrCode = <%=ErrCode %>;
			if(ErrCode == "100"){
				alert("등록되지 않은 회원입니다.");
			}
			if(ErrCode == "101"){
				alert("로그인 후 사용가능한 기능입니다.");
			}
			
			function checkForm(){
				if(loginFrm.user_id.value == ""){
					alert("아이디를 입력해주세요.");
					return false;
				}
				if(loginFrm.user_pw.value == ""){
					alert("비밀번호를 입력해주세요.");
					return false;
				}
			}
		</script>
	</head>
	<body>
		<jsp:include page="./Link.jsp"/>
		<h2>로그인 페이지</h2>
		<%
			//로그인상태확인
			if(session.getAttribute("UserId") == null){
		%>
				<!-- 로그아웃 상태 -->
				<form action="./proc/LoginProcess.jsp" method="post" name="loginFrm" onsubmit="return checkForm();">
					아이디 : <input type="text" name="user_id"/><br/>
					패스워드 : <input type="password" name="user_pw"/><br/>
					<input type="submit" value="로그인">
				</form>
		<% } else { %>
				<!-- 로그인 상태 -->
				<%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br/>
				<a href="./Logout.jsp">[로그아웃]</a>
		<% } %>
	</body>
</html>