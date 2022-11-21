<%@page import="bean.ProductBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.JDBC"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//select
	ArrayList<ProductBean> products = new ArrayList<>();
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		String sql = "select * from `product`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		while(rs.next()){
			ProductBean product = new ProductBean();
			product.setProdNo(rs.getInt(1));
			product.setProdName(rs.getString(2));
			product.setStock(rs.getInt(3));
			product.setPrice(rs.getInt(4));
			product.setCompany(rs.getString(5));
			products.add(product);
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
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				$('.ord').click(function(){
					let prodNo = $(this).val();
					$('section').show().find('input[name=orderProduct]').val(prodNo);
				});
				
				$('.btnClose').click(function(){
					$('section').hide();
				});
				
				$('input[type=submit]').click(function(){
					let orderProduct = $('input[name=orderProduct]').val();
					let orderCount= $('input[name=orderCount]').val();
					let orderId = $('input[name=orderId]').val();

					let jsonData = {
							'orderProduct' : orderProduct,
							'orderCount' : orderCount,
							'orderId' : orderId
					}
					$.ajax({
						url:'./proc/orderProc.jsp',
						type:'post',
						data:jsonData,
						dataType:'json',
						success:function(data){
							if(data){
								alert('주문완료!');
								$('section').hide();
							}
						}
					});
				});
				
			});
		</script>
	</head>
	<body>
		<h3>상품목록</h3>
		<a href="/Shop/customer.jsp">고객목록</a>
		<a href="/Shop/order.jsp">주문목록</a>
		<a href="/Shop/product.jsp">상품목록</a>
		
		<table border="1" id="tt">
			<tr>
				<th>상품번호</th>	
				<th>상품명</th>	
				<th>재고량</th>	
				<th>가격</th>	
				<th>제조사</th>	
				<th>주문</th>	
			</tr>
			<% for(ProductBean product : products) { %>
			<tr>
				<td><%= product.getProdNo() %></td>
				<td><%= product.getProdName() %></td>
				<td><%= product.getStock() %></td>
				<td><%= product.getPrice() %></td>
				<td><%= product.getCompany() %></td>
				<td><button class="ord" value=<%=product.getProdNo() %>>주문</button></td>
			</tr>
			<% } %>
		</table>
		<section style="display:none">
			<h4>주문하기</h4>
				<table border='1'>
					<tr>
						<td>상품번호</td>
						<td>
							<input type='text'  name='orderProduct' readonly>
						</td>
					</tr>
					<tr>
						<td>수량</td>
						<td><input type='number' name='orderCount'></td>
					</tr>
					<tr>
						<td>주문자</td>
						<td><input type='text' name='orderId'></td>
					</tr>
					<tr>
						<td colspan='2' align='right'>
							<input type='submit' value='주문하기'>
						</td>
					</tr>
				</table>
				<button class="btnClose">닫기</button>
		</section>
	</body>
</html>