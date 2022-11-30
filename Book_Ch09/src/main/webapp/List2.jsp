<%@page import="DTO.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="DAO.BoardDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="utils.BoardPage" %>
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
	
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
	int totalPage = (int)Math.ceil((double)totalCount / pageSize);
	
	int pageNum = 1;
	String pageTemp = request.getParameter("pageNum");
	if(pageTemp != null && !pageTemp.equals("")){
		pageNum = Integer.parseInt(pageTemp);
	}
	
	int start = (pageNum - 1) * pageSize + 1;
	int end = pageNum * pageSize;
	
	List<BoardDTO> boardLists = dao.selectListPage(start);
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
		<h2>목록보기(List) - 현재 페이지 : <%=pageNum %> (전체 : <%=totalPage %>)</h2>
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
				int countNum = 0;
				for(BoardDTO dto : boardLists){
					virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
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
			<tr align="center">
				<td>
					<%=BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>
				</td>
				<td><button type="button" onclick="location.href='./Write.jsp';">글쓰기</button></td>
			</tr>
		</table>
	</body>
</html>