<%@page import="java.io.File"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	dao.deleteArticle(no);
	String fileName = dao.deleteFile(no);
	if(fileName != null){
		String path = application.getRealPath("/file");
		File file = new File(path,fileName);
		if(file.exists()){
			file.delete();	
		}
	}
	
	response.sendRedirect("/Farmstory1/board/list.jsp?group="+group+"&cate="+cate);
%>