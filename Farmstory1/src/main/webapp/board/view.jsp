<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.farmstory1.bean.FileBean"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="kr.co.farmstory1.dao.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	if(sessUser == null){
		response.sendRedirect("/Farmstory1/?ErrCode=101");
		return;
	}

	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	pageContext.include("./_"+group+".jsp");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	ArticleBean article = dao.selectArticle(no);
	FileBean fb = dao.selectFile(no);
	dao.updateArticleHit(no);
%>
			<main id="board" class="view">
			    <table border="0">
			        <caption>글보기</caption>
			        <tr>
			            <th>제목</th>
			            <td><input type="text" class="title" value="<%=article.getTitle() %>" readonly></td>
			        </tr>
			        <% if(article.getFile() > 0) { %>
			        <tr>
			            <th>첨부파일</th>
			            <td><a href="/Farmstory1/board/proc/download.jsp?oriName=<%=URLEncoder.encode(fb.getOriName(),"UTF-8") %>&newName=<%=URLEncoder.encode(fb.getNewName(),"UTF-8") %>&fno=<%=fb.getFno() %>"><%=fb.getOriName() %></a>&nbsp;<span><%=fb.getDownload() %></span>회 다운로드</td>
			        </tr>
			        <% } %>
			        <tr>
			            <th>내용</th>
			            <td><textarea readonly><%=article.getContent() %></textarea></td>
			        </tr>
			        
			    </table>
			    <div class="btn">
			    	<% if(sessUser.getUid().equals(article.getUid())) { %>
			        <a href="/Farmstory1/board/proc/deleteProc.jsp?group=<%=group %>&cate=<%=cate %>&no=<%=article.getNo() %>" class="btnCancel">삭제</a>
			        <a href="./modify.jsp?group=<%=group %>&cate=<%=cate %>&no=<%=article.getNo() %>" class="btnRevise">수정</a>
			     	<% } %>   
			        <a href="./list.jsp?group=<%=group %>&cate=<%=cate %>" class="btnList">목록</a>
			    </div>
			</main>
		</article>
    </section>
</div>
<%@ include file="../_footer.jsp" %>