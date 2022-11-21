<%@page import="bean.CustomerBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.JDBC"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//select
	ArrayList<CustomerBean> customers = new ArrayList<>();
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		String sql = "select * from `customer`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		while(rs.next()){
			CustomerBean customer = new CustomerBean();
			customer.setCustid(rs.getString(1));
			customer.setName(rs.getString(2));
			customer.setHp(rs.getString(3));
			customer.setAddr(rs.getString(4));
			customer.setRdate(rs.getString(5));
			customers.add(customer);
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
		<title>Shop</title>
	</head>
	<body>
		<h3>고객목록</h3>
		<a href="/Shop/customer.jsp">고객목록</a>
		<a href="/Shop/order.jsp">주문목록</a>
		<a href="/Shop/product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>	
				<th>이름</th>	
				<th>휴대폰</th>	
				<th>주소</th>	
				<th>가입일</th>	
			</tr>
			<% for(CustomerBean customer : customers) { %>
			<tr>
				<td><%= customer.getCustid() %></td>
				<td><%= customer.getName() %></td>
				<td><%= customer.getHp() %></td>
				<td><%= customer.getAddr() %></td>
				<td><%= customer.getRdate() %></td>
			</tr>
			<% } %>
		</table>
	</body>
</html>