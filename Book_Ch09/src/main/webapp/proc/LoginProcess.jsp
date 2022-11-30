<%@page import="DAO.MemberDAO"%>
<%@page import="DTO.MemberDTO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("user_id");
	String pass = request.getParameter("user_pw");
	
	MemberDAO dao = new MemberDAO();
	MemberDTO dto = dao.getMemberDTO(id, pass);
	
	if(dto.getId() != null){
		session.setAttribute("UserId", dto.getId());
		session.setAttribute("UserName", dto.getName());
		response.sendRedirect("../Login.jsp");
	}else{
		response.sendRedirect("../Login.jsp?ErrCode=100");
		return;
	}
%>