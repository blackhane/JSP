<%@page import="bean.Customer"%>
<%@page import="config.DBCP"%> 
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String custId = request.getParameter("custId");
	Customer bean = null;
	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `customer` WHERE `custId`=?");
		psmt.setString(1, custId);
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			bean = new Customer();
			bean.setName(rs.getString(2));
			bean.setAddress(rs.getString(3));
			bean.setPhone(rs.getString(4));
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
		<title>Customer Modify</title>
	</head>
	<body>
		<h3>고객수정</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./list.jsp">고객목록</a>
		<form action="./proc/modifyProc.jsp" method="post">
			<table border="1">				
				<tr>
					<td>고객번호</td>
					<td><input type="number" name="custId" readonly value=<%= custId %>></td>
				</tr>
				<tr>
					<td>고객명</td>
					<td><input type="text" name="name" value=<%= bean.getName() %>></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="address" value=<%= bean.getAddress() %>></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="phone" value=<%= bean.getPhone() %>></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>