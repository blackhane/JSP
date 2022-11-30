<%@page import="DAO.BoardDAO"%>
<%@page import="DTO.BoardDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../LoginChecked.jsp" %>
<%
	String num = request.getParameter("num");
	
	BoardDAO dao = BoardDAO.getInstance();
	dao.deletePost(num);
	
	response.sendRedirect("../List1.jsp");
%>