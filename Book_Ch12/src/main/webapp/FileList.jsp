<%@page import="java.net.URLEncoder"%>
<%@page import="DTO.MyFileDTO"%>
<%@page import="java.util.List"%>
<%@page import="DAO.MyFileDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<h2>게시물 리스트</h2>
		<%
			MyFileDAO dao = new MyFileDAO();
			List<MyFileDTO> fileLists = dao.myFileList();
		%>
		<table border="1">
			<tr>
				<th>No</th>
				<th>작성자</th>
				<th>제목</th>
				<th>카테고리</th>
				<th>원본 파일명</th>
				<th>저장된 파일명</th>
				<th>작성일</th>
			</tr>
			<% for(MyFileDTO f : fileLists) {%>
				<tr>
					<td><%= f.getIdx() %></td>
					<td><%= f.getName() %></td>
					<td><%= f.getCate() %></td>
					<td><%= f.getOfile() %></td>
					<td><%= f.getSfile() %></td>
					<td><%= f.getPostdate() %></td>
					<td><a href="./Download.jsp?oriName=<%=URLEncoder.encode(f.getOfile(), "UTF-8")%>&newName=<%=URLEncoder.encode(f.getSfile(),"UTF-8") %>">[다운로드]</a></td>
				</tr>
			<% } %>
		</table>
	</body>
</html>