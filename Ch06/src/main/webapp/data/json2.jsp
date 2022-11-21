<%@page import="bean.UserBean"%>
<%@page import="config.JDBC"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<UserBean> users = new ArrayList<>();
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("select * from `user2`");
		while(rs.next()){
			UserBean userbean = new UserBean();
			userbean.setUid(rs.getString(1));
			userbean.setName(rs.getString(2));
			userbean.setHp(rs.getString(3));
			userbean.setAge(rs.getInt(4));
			users.add(userbean);
		}
		rs.close();
		stmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	//Gson 외부라이브러리 이용한 JSON 데이터 생성
	Gson gson = new Gson();
	String jsonData = gson.toJson(users);
	
	//JSON 데이터 출력
	out.print(jsonData);
%>