<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//데이터 수신
	String savePath = application.getRealPath("/file");
	int maxSize = 1024 * 1024 * 10;
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	String title = mr.getParameter("title");
	String content= mr.getParameter("content");
	String uid = mr.getParameter("uid");
	String regip = request.getRemoteAddr();
	
	String group = mr.getParameter("group");
	String cate = mr.getParameter("cate");
	
	String fname = mr.getFilesystemName("file");
	
	ArticleBean article = new ArticleBean();
	article.setCate(cate);
	article.setTitle(title);
	article.setContent(content);
	article.setFname(fname);
	article.setUid(uid);
	article.setRegip(regip);
	
	ArticleDAO dao = ArticleDAO.getInstance();
	int parent = dao.insertArticle(article);
	
	//파일처리
	if(fname != null){
		int idx = fname.lastIndexOf(".");
		String ext = fname.substring(idx);
		String now = new SimpleDateFormat("yyyyMMddHHmmss_").format(new Date());
		String newFname = now+ext;
		
		File oriFile = new File(savePath+"/"+fname);
		File newFile = new File(savePath+"/"+newFname);
		
		oriFile.renameTo(newFile);
		
		dao.insertFile(parent, fname, newFname);
	}
	
	response.sendRedirect("/Farmstory1/board/list.jsp?group="+group+"&cate="+cate);
%>