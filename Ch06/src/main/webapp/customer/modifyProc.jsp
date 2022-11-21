<%@page import="config.DBCP"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String custId = request.getParameter("custId");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String addr = request.getParameter("addr");
	String rDate = request.getParameter("rDate");
	
	try{
		Connection conn = DBCP.getCustomerConnection();
		PreparedStatement psmt = conn.prepareStatement("update `customer` set `name`=?, `hp`=?,`addr`=?,`rDate`=? where `custId`=? ");
		psmt.setString(1, name);
		psmt.setString(2, hp);
		psmt.setString(3, addr);
		psmt.setString(4, rDate);
		psmt.setString(5, custId);
		psmt.executeUpdate();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("./list.jsp");
%>
