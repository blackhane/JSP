<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no =request.getParameter("no");
	String pg =request.getParameter("pg");
	String title =request.getParameter("title");
	String content =request.getParameter("content");
	
	ArticleDAO.getinstance().updateArticle(no, title, content);
	response.sendRedirect("/JBoard1/view.jsp?no="+no+"&pg="+pg);
%>