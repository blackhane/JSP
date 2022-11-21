<%@page import="java.io.File"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	
	ArticleDAO dao = ArticleDAO.getinstance();
	
	dao.deleteArticle(no);
	
	String fileName = dao.deleteFile(no);
	if(fileName != null){
		String path = application.getRealPath("/file");	
		
		File file = new File(path,fileName);
		if(file.exists()){
			file.delete();
		}
	}
	
	
	
	response.sendRedirect("/JBoard1/list.jsp");
%>