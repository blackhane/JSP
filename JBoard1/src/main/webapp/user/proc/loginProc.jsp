<%@page import="kr.co.jboard1.dao.UserDAO"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="kr.co.jboard1.bean.UserBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="apllication/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String uid = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	UserBean ub = UserDAO.getinstance().selectUser(uid, pass);
	
	if(ub != null){
		//회원o
		session.setAttribute("sessUser", ub);
		response.sendRedirect("/JBoard1/list.jsp");
	}else{
		//회원x
		response.sendRedirect("/JBoard1/user/login.jsp?success=100");
	}
%>