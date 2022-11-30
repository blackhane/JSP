<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("UserId") == null){
		response.sendRedirect("./Login.jsp?ErrCode=101");
		return;
	}
%>