<%@page import="bean.UserBean"%>
<%@page import="config.JDBC"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("uid");
	UserBean userbean = null;
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		String sql = "select * from `user2` where `uid`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, uid);
		ResultSet rs = psmt.executeQuery();
		if(rs.next()){
			userbean = new UserBean();
			userbean.setUid(rs.getString(1));
			userbean.setName(rs.getString(2));
			userbean.setHp(rs.getString(3));
			userbean.setAge(rs.getInt(4));
		}
		rs.close();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	//Gson 외부라이브러리 이용한 JSON 데이터 생성
	Gson gson = new Gson();
	String jsonData = gson.toJson(userbean);
	
	//JSON 데이터 출력
	out.print(jsonData);
%>