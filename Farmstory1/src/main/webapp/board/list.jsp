<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.farmstory1.dao.UserDAO"%>
<%@page import="kr.co.farmstory1.db.DBHelper"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	pageContext.include("./_"+group+".jsp");
	
	//게시판 페이징 작업
	ArticleDAO dao = ArticleDAO.getInstance();
	//변수
		int start = 0;
		int total = 0;
		int lastPageNum = 0;
		int currentPage = 1;
		int currentPageGroup = 1;
		int pageGroupStart = 0;
		int pageGroupEnd = 0;
		int pageStartNum = 0;
	//현재 페이지 번호
	String pg = request.getParameter("pg");
	if(pg != null){
		currentPage = Integer.parseInt(pg);
	}
	//글 번호 인덱스 (ex:1페이지=0부터, 2페이지=10부터)
	start = (currentPage - 1) * 10;
	//현재 페이지 그룹 (ex: 1~10 11~20 21~30)
	currentPageGroup = (int)Math.ceil(currentPage / 10.0);
	pageGroupStart = (currentPageGroup -1) * 10 + 1; //시작번호
	pageGroupEnd= currentPageGroup * 10; //끝번호
	//전체 게시물 갯수
	total = dao.selectCountTotal(cate);
	//마지막 페이지 번호
	if(total % 10 == 0){
		lastPageNum = total / 10;
	}else{
		lastPageNum = total / 10 +1;
	}
	if(pageGroupEnd > lastPageNum){
		pageGroupEnd = lastPageNum;
	}
	//게시글 번호
	pageStartNum = total - start;
	
	List<ArticleBean> articles = dao.selectArticles(cate, start);
%>
<script>
	let total = <%=total %>
	console.log(total);
</script>
			<main id="board" class="list">
			    <table border="0">
			        <caption>글목록</caption>
			        <tr>
			            <th>번호</th>
			            <th>제목</th>
			            <th>글쓴이</th>
			            <th>날짜</th>
			            <th>조회</th>
			        </tr>
			        <% if(articles.isEmpty()) { %>
			        <tr>
			        	<td colspan="5" align="center">등록된 글이 없습니다.</td>
			        </tr>
			        <% } %>
			        <% for(ArticleBean article : articles) { %>
			        <tr>
			            <td><%=pageStartNum-- %></td>
			            <td><a href="./view.jsp?group=<%=group %>&cate=<%=cate %>&no=<%=article.getNo() %>"><%=article.getTitle() %></a> [<%=article.getComment() %>]</td>                         
			            <td><%=article.getNick() %></td>
			            <td><%=article.getRdate().substring(2,10) %></td>
			            <td><%=article.getHit() %></td>
			        </tr>
			        <% } %>
			    </table>
			    <div class="page">
			    	<% if(pageGroupStart >1) { %>
			        <a href="/Farmstory1/board/list.jsp?group=<%=group %>&cate=<%=cate %>&pg=<%=pageGroupStart-1 %>" class="prev">이전</a>
			       	<% } %>
			        <% for(int num = pageGroupStart; num<=pageGroupEnd; num++) { %>
			        <a href="/Farmstory1/board/list.jsp?group=<%=group %>&cate=<%=cate %>&pg=<%=num %>" class="num <%=(num==currentPage) ? "current":"off" %>"><%=num %></a>
			        <% } %>
			        <% if(pageGroupEnd < lastPageNum) { %>
			        <a href="/Farmstory1/board/list.jsp?group=<%=group %>&cate=<%=cate %>&pg=<%=pageGroupEnd+1 %>" class="next">다음</a>
			    	<% } %>
			    </div>
			    <a href="./write.jsp?group=<%=group %>&cate=<%=cate %>" class="btnWrite">글쓰기</a>
			</main>
		</article>
    </section>
</div>
<%@ include file="../_footer.jsp" %>