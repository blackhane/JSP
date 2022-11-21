<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="JDBC.JDBC"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<%
			JDBC jdbc = new JDBC();
		
			String sql = "select * from `member`";
			Statement stmt = jdbc.conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				String id = rs.getString(1);
				String pw = rs.getString(2);
				String name = rs.getString(3);
				String date = rs.getString(4);
				
				out.println(id + pw + name + date + "<br>");
			}
			jdbc.close();
		%>
	</body>
</html>