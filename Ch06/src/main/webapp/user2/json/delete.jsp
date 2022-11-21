<%@page import="config.JDBC"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String uid = request.getParameter("uid");
	
	int result = 0;
	
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		String sql = "DELETE FROM `user2` WHERE `uid` = ?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		result = psmt.executeUpdate();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	JsonObject json = new JsonObject();
	
	json.addProperty("result", result);
	
	String jsonData = json.toString();
	
	out.print(jsonData);
%>