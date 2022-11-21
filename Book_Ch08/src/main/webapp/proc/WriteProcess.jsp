<%@page import="DAO.BoardDAO"%>
<%@page import="DTO.BoardDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../LoginChecked.jsp" %>
<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDTO dto = new BoardDTO();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setId(session.getAttribute("UserId").toString());
	
	BoardDAO dao = BoardDAO.getInstance();
	int iResult = dao.insertWrite(dto);
	
	if(iResult == 1){
		response.sendRedirect("../List1.jsp");
	}else{
		out.println("글쓰기 등록 실패");
	}
%>