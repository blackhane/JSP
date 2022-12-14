<%@page import="DTO.BoardDTO"%>
<%@page import="DAO.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String num = request.getParameter("num");

	BoardDAO dao = BoardDAO.getInstance();
	dao.updateVisitCount(num);
	BoardDTO dto = dao.selectView(num);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>모델1 게시판</title>
	</head>
	<body>
		<jsp:include page="./Link.jsp"/>
		<h2>회원제 게시판 - 상세 보기</h2>
		<form name="writeFrm">
			<input type="hidden" name="num" value=<%=num %>/>
			<table border="1'" width="90%">
				<tr>
					<td>번호</td>
					<td><%=dto.getNum() %></td>
					<td>작성자</td>
					<td><%=dto.getName() %></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=dto.getPostDate() %></td>
					<td>조회수</td>
					<td><%=dto.getVisitcount() %></td>
				</tr>
				<tr>
					<td>제목</td>
					<td colspan="3"><%=dto.getTitle() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3" height="100"><%=dto.getContent().replace("\r\n", "<br/>")%></td>
				</tr>
				<tr>
					<td colspan="4" align="center">
					<% if(session.getAttribute("UserId") != null && session.getAttribute("UserId").toString().equals(dto.getId())) { %>
					<button type="button" onclick="location.href='./Edit.jsp?num=<%=dto.getNum() %>';">수정하기</button>
					<button type="button" onclick="location.href='./proc/DeleteProcess.jsp?num=<%=dto.getNum() %>';">삭제하기</button>
					<% } %>
					<button type="button" onclick="location.href='./List1.jsp';">목록보기</button>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>