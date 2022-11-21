<%@page import="config.DBCP"%> 
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bookId = request.getParameter("bookId");
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		stmt.executeUpdate("DELETE FROM `book` WHERE `bookId`=" + bookId);
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>