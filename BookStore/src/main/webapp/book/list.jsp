<%@page import="bean.Book"%> 
<%@page import="config.DBCP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Book> books = null;
	try{
		//DBCP 커넥션 풀 연결
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		ResultSet rs =  stmt.executeQuery("SELECT * FROM `book`");
		//리스트에 bean파일을 이용하여 rs값을 추가
		books = new ArrayList<>();
		while(rs.next()){
			Book bean = new Book();
			bean.setBookId(""+rs.getInt(1));
			bean.setBookName(rs.getString(2));
			bean.setPublisher(rs.getString(3));
			bean.setPrice(""+rs.getInt(4));
			books.add(bean);
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
		<title>Book List</title>
	</head>
	<body>
		<h3>도서목록</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./register.jsp">도서등록</a>
		<table border="1">
			<tr>
				<th>도서번호</th>
				<th>도서명</th>
				<th>출판사</th>
				<th>가격</th>
				<th>관리</th>
			</tr>
			<% for(Book bean:books) { %> <!-- 반복문을 이용해 List 출력 -->
			<tr>
				<td><%= bean.getBookId() %></td>
				<td><%= bean.getBookName() %></td>
				<td><%= bean.getPublisher() %></td>
				<td><%= bean.getPrice() %></td>
				<td>
					<a href="modify.jsp?bookId=<%= bean.getBookId() %>">수정</a>
					<a href="delete.jsp?bookId=<%= bean.getBookId() %>">삭제</a>
				</td>
			</tr>
			<% } %>
		</table>
	</body>
</html>