<%@page import="javax.tools.DocumentationTool.Location"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@page import="kr.co.farmstory1.dao.UserDAO"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = application.getRealPath("/file");
	String oriName = request.getParameter("oriName");
	String newName = request.getParameter("newName");
	String fno = request.getParameter("fno");
	
	try{
		File file = new File(path, newName);
		InputStream is = new FileInputStream(file);
		
		String client = request.getHeader("User-Agent");
		if(client.indexOf("WOW64") == -1){
			oriName = new String(oriName.getBytes("UTF-8"),"ISO-8859-1");
		}else{
			oriName = new String(oriName.getBytes("KSC5601"),"ISO-8859-1");
		}
		response.reset();
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\""+oriName+"\"");
		response.setHeader("Contnet-Length", ""+file.length());
		out.clear();
		OutputStream os = response.getOutputStream();
		byte b[] = new byte[(int)file.length()];
		int readBuffer = 0;
		while((readBuffer = is.read(b)) > 0){
			os.write(b, 0, readBuffer);
		}
		is.close();
		os.close();
	}catch(Exception e){
		e.printStackTrace();
	}

	ArticleDAO.getInstance().updateFileHit(fno);
%>
location.reload();