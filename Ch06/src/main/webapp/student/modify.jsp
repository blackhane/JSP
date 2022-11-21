<%@page import="bean.StudentBean"%>
<%@page import="config.JDBC"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
	String stdNo = request.getParameter("stdNo");
	StudentBean sb = null;
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		String sql = "SELECT * FROM `student` WHERE `stdNo`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, stdNo);
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
	sb = new StudentBean();
	sb.setStdName(rs.getString(2));
	sb.setStdHp(rs.getString(3));
	sb.setStdYear(rs.getString(4));
	sb.setStdAddress(rs.getString(5));
		}
		psmt.close();
		conn.close();
	} catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>modify.jsp</title>
	</head>
	<body>
		<h3>student 수정</h3>
		<form action="./modifyProc.jsp" method="post">
		<a href="list.jsp">수정 취소</a>
			<table>
				<tr>
					<td>학번</td>
					<td><input type="text" name="stdNo" readonly value=<%= stdNo %>></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdName" value=<%= sb.getStdName() %>></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="stdHp" value=<%= sb.getStdHp() %>></td>
				</tr>
				<tr>
					<td>학년</td>
					<td><input type="text" name="stdYear" value=<%= sb.getStdYear() %>></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="stdAddress" value=<%= sb.getStdAddress() %>></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록"></td>
				</tr>
			</table>
		</form>
	</body>
</html>