<%@page import="DTO.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="DAO.BoardDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	Map<String, Object> param = new HashMap<>();
	
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	if(searchWord != null){
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	BoardDAO dao = BoardDAO.getInstance();
	int totalCount = dao.selectCount(param);
	List<BoardDTO> boardLists = dao.selectList(param);
	dao.close();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>모델1 게시판</title>
	</head>
	<body>
		<jsp:include page="./Link.jsp"></jsp:include>
		<h2>목록보기(List)</h2>
		<form method="get">
			<table border="1" width="90%">
				<tr>
					<td align="center">
						<select name="searchField">
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
						<input type="text" name="searchWord"/>
						<input type="submit" value="검색하기"/>
					</td>
				</tr>
			</table>
		</form>
		
		<table border="1" width="90%">
			<tr>
				<th width="10%">번호</th>
				<th width="50%">제목</th>
				<th width="15%">작성자</th>
				<th width="10%">조회수</th>
				<th width="15%">작성일</th>
			</tr>
			<% if(boardLists.isEmpty()) { %>
				<tr>
					<td colspan="5" align="center">
						등록된 게시물이 없습니다.
					</td>
				</tr>
			<% } else { 
				int virtualNum = 0;
				for(BoardDTO dto : boardLists){
					virtualNum = totalCount--;
			%>
				<tr align="center">
					<td><%= virtualNum %></td>
					<td align="left">
						<a href="./View.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle() %></a>
					</td>
					<td align="center"><%=dto.getId() %></td>
					<td align="center"><%=dto.getVisitcount() %></td>
					<td align="center"><%=dto.getPostDate() %></td>
				</tr>
			<% }
			} %>
		</table>
		
		<table border="1" width="90%">
			<tr align="right">
				<td><button type="button" onclick="location.href='./Write.jsp';">글쓰기</button></td>
			</tr>
		</table>
	</body>
</html>