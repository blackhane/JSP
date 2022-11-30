<%@page import="DAO.BoardDAO"%>
<%@page import="DTO.BoardDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../LoginChecked.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDTO dto = new BoardDTO();
	
	dto.setContent(content);
	dto.setId(session.getAttribute("UserId").toString());
	
	BoardDAO dao = BoardDAO.getInstance();
// 	dto.setTitle(title);
// 	int iResult = dao.insertWrite(dto);
	
	int iResult = 0;
	for(int i=1; i<=100; i++){
		dto.setTitle(title + "-" + i);
		iResult = dao.insertWrite(dto);
	}
	
	if(iResult == 1){
		response.sendRedirect("../List1.jsp");
	}else{
		out.println("글쓰기 등록 실패");
	}
%>