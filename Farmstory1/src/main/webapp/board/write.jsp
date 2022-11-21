<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<%
	if(sessUser == null){
		response.sendRedirect("/Farmstory1/?ErrCode=101");
		return;
	}

	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	pageContext.include("./_"+group+".jsp");
	
%>
			<main id="board" class="write">
			    <form action="/Farmstory1/board/proc/writeProc.jsp" method="post" enctype="multipart/form-data">
			    <input type="hidden" name="group" value="<%=group %>">
			    <input type="hidden" name="cate" value="<%=cate %>">
			    <input type="hidden" name="uid" value="<%=sessUser.getUid() %>">
			        <table border="0">
			            <caption>글쓰기</caption>
			            <tr>
			                <th>제목</th>
			                <td><input type="text" class="title" name="title" placeholder="제목을 입력하세요."></td>
			            </tr>
			            <tr>
			                <th>내용</th>
			                <td><textarea name="content"></textarea></td>
			            </tr>
			            <tr>
			                <th>첨부</th>
			                <td><input type="file" name="file" value="파일 선택"></td>
			            </tr>
			        </table>
			        <div>
			            <a href="./list.jsp?group=<%=group %>&cate=<%=cate %>" class="btnCancel">취소</a>
			            <input type="submit" class="btnComplete" value="작성완료">
			        </div>
			    </form>
			</main>
		</article>
    </section>
</div>
<%@ include file="../_footer.jsp" %>