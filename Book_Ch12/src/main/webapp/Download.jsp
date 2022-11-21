<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String saveDirectory = application.getRealPath("/Uploads"); //저장경로
	String oriName = request.getParameter("oriName");
	String newName = request.getParameter("newName");
	
	try{
		//파일 스트림
		File file = new File(saveDirectory, newName);
		InputStream inStream = new FileInputStream(file);
		
		//한글 깨짐방지
		String client = request.getHeader("User-Agent");
		if(client.indexOf("WOW64") == -1){
			oriName = new String(oriName.getBytes("UTF-8"),"ISO-8859-1");
		}else{
			oriName = new String(oriName.getBytes("KSC5601"),"ISO-8859-1");
		}
		
		response.reset();
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=\""+oriName+"\"");
		response.setHeader("Content-Length",""+file.length());
		
		out.clear();
		
		OutputStream outStream = response.getOutputStream();
		
		byte b[] = new byte[(int)file.length()];
		int readBuffer = 0;
		while((readBuffer = inStream.read(b)) > 0){
			outStream.write(b,0,readBuffer);
		}
		
		inStream.close();
		outStream.close();
	}catch(FileNotFoundException e){
		e.printStackTrace();
	}catch(Exception e){
		e.printStackTrace();
	}
%>