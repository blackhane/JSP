<%@page import="bean.Book"%> 
<%@page import="config.DBCP"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookId = request.getParameter("bookId");
	Book bean = null;
	try{
		Connection conn = DBCP.getConnection();
		PreparedStatement psmt = conn.prepareStatement("SELECT * FROM `book` WHERE `bookId`=?");
		psmt.setString(1, bookId);
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			bean = new Book();
			bean.setBookName(rs.getString(2));
			bean.setPublisher(rs.getString(3));
			bean.setPrice(rs.getString(4));
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
		<title>Book Modify</title>
	</head>
	<body>
		<h3>도서수정</h3>
		<a href="../index.jsp">처음으로</a>
		<a href="./list.jsp">도서목록</a>
		<form action="./proc/modifyProc.jsp" method="post">
			<table border="1">				
				<tr>
					<td>도서번호</td>
					<td><input type="number" name="bookId" readonly value=<%= bookId %>></td>
				</tr>
				<tr>
					<td>도서명</td>
					<td><input type="text" name="bookName" value="<%= bean.getBookName() %>"></td>
				</tr>
				<tr>
					<td>출판사</td>
					<td><input type="text" name="publisher" value="<%= bean.getPublisher() %>"></td>
				</tr>
				<tr>
					<td>가격</td>
					<td><input type="number" name="price" value=<%= bean.getPrice() %>></td>
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