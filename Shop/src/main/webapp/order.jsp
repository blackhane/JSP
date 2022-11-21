<%@page import="bean.OrderBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="config.JDBC"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//select
	ArrayList<OrderBean> orders = new ArrayList<>();
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		String sql = "SELECT a.*, b.`name`, c.`prodName` FROM `order` AS a "
				+ "JOIN `customer` AS b ON a.`orderId` = b.`custid` "
				+ "JOIN `product` AS c ON a.`orderProduct` = c.`prodNo` ";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		while(rs.next()){
			OrderBean order = new OrderBean();
			order.setOrderNo(rs.getInt(1));
			order.setOrderId(rs.getString(2));
			order.setOrderProduct(rs.getInt(3));
			order.setOrderCount(rs.getInt(4));
			order.setOrderDate(rs.getString(5));
			order.setName(rs.getString(6));
			order.setProdName(rs.getString(7));
			orders.add(order);
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
		<h3>주문목록</h3>
		<a href="/Shop/customer.jsp">고객목록</a>
		<a href="/Shop/order.jsp">주문목록</a>
		<a href="/Shop/product.jsp">상품목록</a>
		
		<table border="1">
			<tr>
				<th>주문번호</th>	
				<th>주문자</th>	
				<th>주문상품</th>	
				<th>주문수량</th>	
				<th>주문일</th>	
			</tr>
			<% for(OrderBean order: orders) { %>
			<tr>
				<td><%= order.getOrderNo() %></td>
				<td><%= order.getName() %></td>
				<td><%= order.getProdName() %></td>
				<td><%= order.getOrderCount() %></td>
				<td><%= order.getOrderDate().substring(0,16) %></td>
			</tr>
			<% } %>
		</table>
	</body>
</html>