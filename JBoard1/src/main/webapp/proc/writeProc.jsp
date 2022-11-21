<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");

	//multipart 전송데이터 수신
	String savePath = application.getRealPath("/file");
	int maxSize = 1024 * 1024 * 10; //10MB
// 	MultipartRequest mr = new MultipartRequest(request, "파일저장경로", "파일최대사이즈", "인코딩값", new DefaultFileRenamePolicy());
	MultipartRequest mr = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String uid = mr.getParameter("uid");
	//file form데이터
	String fname = mr.getFilesystemName("fname");
	String regip = request.getRemoteAddr();
	
	//System.out.println("fname:" +fname);
	//System.out.println("savePath:" +savePath);
	
	ArticleBean article = new ArticleBean();
	article.setTitle(title);
	article.setContent(content);
	article.setUid(uid);
	article.setFname(fname);
	article.setRegip(regip);
	
	ArticleDAO dao = ArticleDAO.getinstance();
	int parent = dao.insertArticle(article);
	
	//첨부파일이 있으면 파일처리
	if(fname != null){
		//파일명 수정(파일명이 겹칠 수 있기 때문에 중복되지 않게 처리)
		
		//확장자 값
		int idx = fname.lastIndexOf(".");
		String ext = fname.substring(idx);
		//년월일시분초
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
		String now = sdf.format(new Date());
		
		//년월일시분초 + 아이디 + 확장자
		String newFname = now+uid+ext;
		
		//현재 파일명
		File oriFile = new File(savePath+"/"+fname);
		//바꿀 파일명
		File newFile = new File(savePath+"/"+newFname);
		
		oriFile.renameTo(newFile);
		
		//파일 테이블저장
		dao.insertFile(parent, newFname, fname);
	}
	
	
	response.sendRedirect("/JBoard1/list.jsp");
%>