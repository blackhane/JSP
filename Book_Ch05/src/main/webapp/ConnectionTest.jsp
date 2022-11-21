<%@page import="DBCP.DBConnPool"%>
<%@page import="JDBC.JDBC"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JDBC</title>
	</head>
	<body>
		<h1>JDBC 테스트1</h1>
		<%
			JDBC jdbc1 = new JDBC();
			jdbc1.close();
		%>
		<h1>JDBC 테스트2</h1>
		<%
			String driver = application.getInitParameter("MySqlDriver");
			String url = application.getInitParameter("MySqlURL");
			String id = application.getInitParameter("MySqlId");
			String pwd= application.getInitParameter("MySqlPwd");
			
			JDBC jdbc2 = new JDBC(driver,url,id,pwd);
			jdbc2.close();
		%>
		<h1>JDBC 테스트3</h1>
		<%
			JDBC jdbc3 = new JDBC(application);
			jdbc3.close();
		%>
		<h2>커넥션 풀 테스트</h2>
		<%
			DBConnPool pool = new DBConnPool();
			pool.close();
		%>
	</body>
</html>