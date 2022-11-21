<%@page import="bean.StudentBean"%>
<%@page import="config.JDBC"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
ArrayList<StudentBean> std = null;
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `student`");
		std = new ArrayList<>();
		while(rs.next()){
	StudentBean stdb = new StudentBean();
	stdb.setStdNo(rs.getString(1));
	stdb.setStdName(rs.getString(2));
	stdb.setStdHp(rs.getString(3));
	stdb.setStdYear(rs.getString(4));
	stdb.setStdAddress(rs.getString(5));
	std.add(stdb);
		}
		rs.close();
		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>list.jsp</title>
	</head>
	<body>
		<h3>student 목록</h3>
		<a href="./register.jsp">student 등록</a>
		
		<table>
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>학년</th>
				<th>주소</th>
			</tr>
				<% for(StudentBean student : std) { %>
			<tr>
				<td><%= student.getStdNo() %></td>
				<td><%= student.getStdName() %></td>
				<td><%= student.getStdHp() %></td>
				<td><%= student.getStdYear() %></td>
				<td><%= student.getStdAddress() %></td>
				<td>
					<a href="./modify.jsp?stdNo=<%= student.getStdNo() %>">수정</a>
					<a href="./delete.jsp?stdNo=<%= student.getStdNo() %>">삭제</a>
				</td>
			</tr>
				<% } %>
		</table>
	</body>
</html>