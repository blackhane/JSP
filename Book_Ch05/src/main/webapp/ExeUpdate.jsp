<%@page import="java.sql.PreparedStatement"%>
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

			String id = "test1";
			String pass = "1111";
			String name = "테스트회원";
			
			String sql = "insert into `member` values (?,?,?,now())";
			PreparedStatement psmt = jdbc.conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, pass);
			psmt.setString(3, name);
			int inResult = psmt.executeUpdate();
			out.println(inResult +"행이 입력되었습니다.");
			jdbc.close();
		%>
	</body>
</html>