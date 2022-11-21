<%@page import="com.mysql.cj.xdevapi.DbDoc"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.bean.FileBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String fno = request.getParameter("fno");
	
	//파일 DAO 객체
	ArticleDAO dao = ArticleDAO.getinstance();
	//파일 정보
	FileBean fb = dao.selectFile(fno);
	//파일 다운로드 +1
	dao.updateFileDownload(fno);
	
	//파일 다운로드 response 헤더수정
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(fb.getOriName(), "utf-8"));
	response.setHeader("Content-Transfer-Encoding", "binary");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Cache-Control", "private");
	
	//파일 다운로드 스트림 작업
	String savePath = application.getRealPath("/file");
	File file = new File(savePath+"/"+fb.getNewName());
	
	BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
	
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
	
	while(true){
		
		int data = bis.read();
		
		if(data == -1){
			break;
		}
		
		bos.write(data);
	}
	
	bos.close();
	bis.close();
%>