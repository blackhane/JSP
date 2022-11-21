<%@page import="bean.User5Bean"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String uid = request.getParameter("uid");
	User5Bean user = null;
	try{
		Connection conn = DBCP.getJava1dbConnection();
		PreparedStatement psmt = conn.prepareStatement("select * from `user5` where `uid` = ?");
		psmt.setString(1, uid);
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			user = new User5Bean();
			user.setName(rs.getString(2));
			user.setBirth(rs.getString(3));
			user.setAge(rs.getString(4));
			user.setAddress(rs.getString(5));
			user.setHp(rs.getString(6));
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
		<title>User5 Modify</title>
	</head>
	<body>
		<h3>User5 수정하기</h3>
		<a href="./list.jsp">이전으로</a>
		<form action="./modifyProc.jsp">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="uid" readonly value="<%= uid %>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%= user.getName() %>"></td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td><input type="date" name="birth" value="<%= user.getBirth() %>"></td>
				</tr>
				<tr>
					<td>나이</td>
					<td><input type="number" name="age" value="<%= user.getAge() %>"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="address" value="<%= user.getAddress() %>"></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="hp" value="<%= user.getHp() %>"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정하기" >
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>