<%@page import="config.DBCP"%> 
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String custId = request.getParameter("custId");
	
	try{
		Connection conn = DBCP.getConnection();
		Statement stmt = conn.createStatement();
		stmt.executeUpdate("DELETE FROM `customer` WHERE `custId`=" + custId);
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>