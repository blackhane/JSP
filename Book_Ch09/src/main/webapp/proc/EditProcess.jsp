<%@page import="DAO.BoardDAO"%>
<%@page import="DTO.BoardDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../LoginChecked.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	BoardDTO dto = new BoardDTO();
	dto.setNum(num);
	dto.setTitle(title);
	dto.setContent(content);
	
	BoardDAO dao = BoardDAO.getInstance();
	dao.updateEdit(dto);
	
	response.sendRedirect("../View.jsp?num="+dto.getNum());
%>