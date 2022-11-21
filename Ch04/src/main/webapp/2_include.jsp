<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>2_include</title>
		<!-- 
			날짜 : 2022 10 07
			이름 : 박진휘
			내용 : JSP 액션태그 include 실습
		-->
	</head>
	<body>
		<h3>include 액션태그</h3>
		
		<h4>include 지시자</h4>
		<%@ include file="/inc/_header.jsp" %>
		<%@ include file="/inc/_footer.jsp" %>
		<%@ include file="/inc/_config1.jsp" %>
		<%
			//정적타임에 삽입
			out.print(num1 +"<br>");
			out.print(num2 +"<br>");
			out.print(num3 +"<br>");
		%>
		
		<h4>include 태그</h4>
		<jsp:include page="./inc/_header.jsp">
		<jsp:include page="./inc/_footer.jsp">
		<jsp:include page="./inc/_config2.jsp">
		<%
			//동적타임에 삽입
			//out.print(var1 +"<br>");
			//out.print(var2 +"<br>");
			//out.print(var3 +"<br>");
		%>
		
		<h4>include 메서드</h4>
		<%
			pageContext.include("./inc/_header.jsp");
			pageContext.include("./inc/_footer.jsp");
		%>
	</body>
</html>