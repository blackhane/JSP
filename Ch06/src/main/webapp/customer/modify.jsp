<%@page import="bean.CustomerBean"%>
<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String custId = request.getParameter("custId");
	
	CustomerBean customer = null;
	try{
		Connection conn = DBCP.getCustomerConnection();
		String sql = "select * from `customer` where `custId` = ?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, custId);
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			customer = new CustomerBean();
			customer.setName(rs.getString(2));
			customer.setHp(rs.getString(3));
			customer.setAddr(rs.getString(4));
			customer.setrDate(rs.getString(5));
		}
		rs.close();
		psmt.close();
		conn.close();
	}catch(Exception e) {
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
		<h3>Customer 수정하기</h3>
		
		<a href="./list.jsp">이전으로</a>
		
		<form action="./modifyProc.jsp" method="post">
			<table border="1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="custId" readonly value="<%= custId %>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%= customer.getName() %>"></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="hp" value="<%= customer.getHp() %>"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" value="<%= customer.getAddr() %>"></td>
				</tr>
				<tr>
					<td>수정일</td>
					<td><input type="date" name="rDate" value="<%= customer.getrDate() %>"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="submit" value="수정하기">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>