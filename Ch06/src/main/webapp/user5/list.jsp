<%@page import="bean.User5Bean"%>
<%@page import="config.DBCP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<User5Bean> user5 = null;
	try{
		Connection conn = DBCP.getJava1dbConnection();
		PreparedStatement psmt = conn.prepareStatement("select * from `user5`");
		ResultSet rs = psmt.executeQuery();
		user5 = new ArrayList<>();
		while(rs.next()){
			User5Bean user = new User5Bean();
			user.setUid(rs.getString(1));
			user.setName(rs.getString(2));
			user.setBirth(rs.getString(3));
			user.setAge(rs.getString(4));
			user.setAddress(rs.getString(5));
			user.setHp(rs.getString(6));
			user5.add(user);
		}
		rs.close();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>User5 List</title>
	</head>
	<body>
		<h3>User5 리스트</h3>
		<a href="/Ch06/2_DBCPTest.jsp">처음으로</a>
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>나이</th>
				<th>주소</th>
				<th>전화번호</th>
				<th>비고</th>
			</tr>
			<% for(User5Bean user : user5) { %>
			<tr>
				<td><%= user.getUid() %></td>
				<td><%= user.getName() %></td>
				<td><%= user.getBirth() %></td>
				<td><%= user.getAge() %></td>
				<td><%= user.getAddress() %></td>
				<td><%= user.getHp() %></td>
				<td>
					<a href="./modify.jsp?uid=<%= user.getUid() %>">수정</a>
					<a href="./delete.jsp?uid=<%= user.getUid() %>">삭제</a>
				</td>
			</tr>
			<% } %>
			<tr>
				<td colspan="7" align="center"><a href="./register.jsp">등록하기</a></td>
			</tr>
		</table>
	</body>
</html>