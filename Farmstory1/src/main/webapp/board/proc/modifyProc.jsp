<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	ArticleBean article = new ArticleBean();
	article.setNo(no);
	article.setTitle(title);
	article.setContent(content);
	
	ArticleDAO.getInstance().updateArticle(article);
	
	response.sendRedirect("/Farmstory1/board/view.jsp?group="+group+"&cate="+cate+"&no="+no);
%>