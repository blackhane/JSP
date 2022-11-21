<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>1_forward</title>
		<!-- 
			날짜 : 2022 10 07
			이름 : 박진휘
			내용 : JSP 액션태그 forward 실습
		-->
	</head>
	<body>
		<h3>forward 액션태그</h3>
		
		<%
			//pageContext.forward("./2_include.jsp");
		%>
		<jsp:forward page="./2_include.jsp"></jsp:forward>
		
	</body>
</html>