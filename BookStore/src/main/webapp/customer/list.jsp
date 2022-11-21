<%@page import="bean.Customer"%> 
<%@page import="config.DBCP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Customer> cust = null;
	try{
		//DBCP 커넥션 풀 연결
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs =  stmt.executeQuery("SELECT * FROM `customer`");
		//리스트에 bean파일을 이용하여 rs값을 추가
		cust = new ArrayList<>();
		while(rs.next()){
			Customer bean = new Customer();
			bean.setCustId(""+rs.getInt(1));
			bean.setName(rs.getString(2));
			bean.setAddress(rs.getString(3));
			bean.setPhone(rs.getString(4));
			cust.add(bean);
		}
		//데이터베이스 종료
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
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
		<h3>고객목록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./register.jsp">고객등록</a>
		<table border="1">
			<tr>
				<th>고객번호</th>
				<th>고객명</th>
				<th>주소</th>
				<th>휴대폰</th>
				<th>관리</th>
			</tr>
			<% for(Customer bean : cust) { %> <!-- 반복문을 이용해 List 출력 -->
			<tr>
				<td><%= bean.getCustId() %></td>
				<td><%= bean.getName() %></td>
				<td><%= bean.getAddress() %></td>
				<td><%= bean.getPhone() %></td>
				<td>
					<a href="./modify.jsp?custId=<%= bean.getCustId() %>">수정</a>
					<a href="./delete.jsp?custId=<%= bean.getCustId() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>