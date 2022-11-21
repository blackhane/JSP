<%@page import="DAO.MyFileDAO"%>
<%@page import="DTO.MyFileDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String saveDirectory = application.getRealPath("/Uploads"); //저장경로
	int maxPostSize = 1024*1000; //1MB
	String encoding = "UTF-8"; //인코딩 방식
	
	try{
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
		
		//새로운 파일명 생성
		String fileName = mr.getFilesystemName("attchedFile"); //현재 파일 이름
		String ext = fileName.substring(fileName.lastIndexOf("."));//현재 파일 확장자
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		String newFilename = now+ext; //새로운 파일 이름
		
		//파일명 변경
		File oldFile = new File(saveDirectory + "/" + fileName);
		File newFile = new File(saveDirectory + "/" + newFilename);
		oldFile.renameTo(newFile);
		
		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		String[] cateArray = mr.getParameterValues("cate");
		StringBuffer cateBuf = new StringBuffer();
		if(cateArray == null){
			cateBuf.append("선택 없음");
		}else{
			for(String s : cateArray){
				cateBuf.append(s + ",");
			}
		}
		
		MyFileDTO dto = new MyFileDTO();
		dto.setName(name);
		dto.setTitle(title);
		dto.setCate(cateBuf.toString());
		dto.setOfile(fileName);
		dto.setSfile(newFilename);
		
		MyFileDAO dao = new MyFileDAO();
		dao.insertFile(dto);
		
		response.sendRedirect("./FileList.jsp");
	}catch(Exception e){
		e.printStackTrace();
	}
%>