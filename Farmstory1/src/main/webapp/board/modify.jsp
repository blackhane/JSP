<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="kr.co.farmstory1.dao.UserDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	pageContext.include("./_"+group+".jsp");
	
	ArticleBean article = ArticleDAO.getInstance().selectArticle(no);
%>
			<main id="board" class="modify">
			    <form action="/Farmstory1/board/proc/modifyProc.jsp">
			    <input type="hidden" name="group" value=<%=group %>>
			    <input type="hidden" name="cate" value=<%=cate %>>
			    <input type="hidden" name="no" value=<%=no %>>
			        <table border="0">
			            <caption>글수정</caption>
			            <tr>
			                <th>제목</th>
			                <td><input type="text" class="title" name="title" value="<%=article.getTitle() %>"></td>
			            </tr>
			            <tr>
			                <th>내용</th>
			                <td><textarea name="content"><%=article.getContent() %></textarea></td>
			            </tr>
			        </table>
			        <div>
			            <a href="./view.jsp?group=<%=group %>&cate=<%=cate %>&no=<%=article.getNo() %>" class="btnCancel">취소</a>
			            <input type="submit" class="btnComplete" value="수정완료">
			        </div>
			    </form>
			</main>
		</article>
    </section>
</div>
<%@ include file="../_footer.jsp" %>