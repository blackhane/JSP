<%@page import="bean.CustomerBean"%>
<%@page import="config.DBCP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<CustomerBean> customer = null;
	try{
		//1단계,2단계
		Connection conn = DBCP.getCustomerConnection();
		//3단계
		PreparedStatement psmt = conn.prepareStatement("select * from `customer`");
		//4단계
		ResultSet rs =  psmt.executeQuery();
		//5단계
		customer = new ArrayList<>();
		
		while(rs.next()){
			CustomerBean bean = new CustomerBean();
			bean.setCustId(rs.getString(1));
			bean.setName(rs.getString(2));
			bean.setHp(rs.getString(3));
			bean.setAddr(rs.getString(4));
			bean.setrDate(rs.getString(5));
			customer.add(bean);
		}
		//6단계
		rs.close();
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
		<title>Customer List</title>
	</head>
	<body>
		<h3>리스트</h3>
		
		<a href="/Ch06/2_DBCPTest.jsp">처음으로</a><br>
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>등록일</th>
				<th>비고</th>
			</tr>
			<% for(CustomerBean cust : customer) { %>
			<tr>
				<td><%= cust.getCustId() %></td>
				<td><%= cust.getName() %></td>
				<td><%= cust.getHp() %></td>
				<td><%= cust.getAddr() %></td>
				<td><%= cust.getrDate() %></td>
				<td>
					<a href="./modify.jsp?custId=<%= cust.getCustId() %>">수정</a>
					<a href="./delete.jsp?custId=<%= cust.getCustId() %>">삭제</a>
				</td>
			</tr>
			<% } %>
			<tr>
				<td colspan="6" align="center"><a href="./register.jsp">등록하기</a></td>
			</tr>
		</table>
		
	</body>
</html>