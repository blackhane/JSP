<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.bean.ArticleBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kr.co.jboard1.db.Sql"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.DBCP"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	//ArticleDAO 객체
	ArticleDAO dao = ArticleDAO.getinstance();
	//글보기
	ArticleBean article = dao.selectArticle(no);
	//조회수 +1
	dao.updateArticleHit(no);
	//댓글보기
	List<ArticleBean>comments = dao.selectComments(no);
%>
<%@ include file = "./_header.jsp" %>
<script>
	$(document).ready(function(){
		
		//삭제하기
		$(document).on('click','.remove',function(e){
			e.preventDefault();
			
			let tag = $(this);
			let result = confirm("정말 삭제 하시겠습니까?");
			
			if(result){
				let no = $(this).attr('data-no');
				let parent = $(this).attr('data-parent');
				
				let jsonData = {
						"no":no,
						"parent":parent
				};
				
				$.ajax({
					url : "/JBoard1/proc/commentDeleteProc.jsp",
					type : "get",
					data : jsonData,
					dataType : "json",
					success : function(data){
						if(data.result > 0){
							alert("댓글이 삭제되었습니다.");
							
							tag.closest('article').remove();
						}
					}
				});
			}
		});
		
		//수정하기
		$(document).on('click','.modify',function(e){
			e.preventDefault();

			let txt = $(this).text();
			let p = $(this).parent().prev();
			
			if(txt == '수정'){
				//수정모드
				$(this).text('수정완료');
				
				p.attr('contentEditable',true);
				p.attr('readonly',false);
				p.focus();
				
			}else{
				//수정완료
				$(this).text('수정');
				
				p.attr('contentEditable',false);
				p.attr('readonly',true);
				
				let content = p.val();
				let no = $(this).attr('data-no');
				let jsonData = {
						"content": content,
						"no": no
				};
				
				console.log(jsonData);
				
				$.ajax({
					url: '/JBoard1/proc/commentModifyProc.jsp',
					type: 'post',
					data: jsonData,
					dataType: 'json',
					success: function(data){
						if(data.result > 0){
							alert('댓글이 수정되었습니다.');
						}
					}
				});
				
			}
			
		});
		
		//댓글쓰기
		$('.commentWrite > form').submit(function(){
			
			let pg = $(this).children('input[name=pg]').val();
			let parent = $(this).children('input[name=parent]').val();
			let uid = $(this).children('input[name=uid]').val();
			let textarea = $(this).children('textarea[name=content]');
			let content = textarea.val();
			
			let jsonData = {
					"pg" : pg,
					"parent" : parent,
					"uid" : uid,
					"content" : content
			};
			console.log(jsonData);
			$.ajax({
				url : '/JBoard1/proc/commentWriteProc.jsp',
				method : 'post',
				data : jsonData,
				dataType : 'json',
				success : function(data){
					console.log(data);
					let article ="<article>";					
						article +="<p>"+data.nick+"&nbsp<span>"+data.date+"</span></p>";
						article +="<textarea readonly>"+data.content+"</textarea>";
						article +="<div>";
						article +="<a href='#' class='remove' data-no='"+data.no+"'>삭제</a>&nbsp";
						article +="<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";
						article +="</div>";
						article +="</article>";
					$('.commentList > .empty').hide();
					$('.commentList').append(article);
					textarea.val(' ');
				}
			});
			return false;
		});
	});
</script>
<main id="board" class="view">
    <table border="0">
        <caption>글보기</caption>
        <tr>
            <th>제목</th>
            <td><input type="text" class="title" value="<%= article.getTitle()%>" readonly></td>
        </tr>
        <% if(article.getFile() > 0) { %>
        <tr>
            <th>첨부파일</th>
            <td><a href="/JBoard1/proc/download.jsp?fno=<%= article.getFno()%>"><%= article.getOriName()%> </a><span><%= article.getDownload()%></span>회 다운로드</td>
        </tr>
        <% } %>
        <tr>
            <th>내용</th>
            <td><textarea readonly><%= article.getContent()%></textarea></td>
        </tr>
        
    </table>
    <div class="btn">
    <% if(sessUser.getUid().equals(article.getUid())) {%>
        <a href="/JBoard1/proc/deleteProc.jsp?no=<%=article.getNo()%>" class="btnCancel">삭제</a>
        <a href="/JBoard1/modify.jsp?no=<%=article.getNo()%>&pg=<%=pg%>" class="btnRevise">수정</a>
    <% } %>
        <a href="/JBoard1/list.jsp?pg<%=pg%>" class="btnList">목록</a>
    </div>
    <div class="comment commentList">
        <p class="list">댓글목록</p>
        <% for(ArticleBean comment : comments ) { %>
        <article>
            <p><%=comment.getNick() %> <span><%=comment.getrDate() %></span></p>
            <textarea readonly><%=comment.getContent() %></textarea>
            <% if(sessUser.getUid().equals(comment.getUid())) {%>
            <div>
                <a href="#" class="remove" data-no="<%=comment.getNo()%>" data-parent="<%=comment.getParent()%>" ">삭제e</a>
                <a href="#" class="modify" data-no="<%=comment.getNo()%>">수정</a>
            </div>
            <% } %>
        </article>
		<% } %>
        <% if(comments.size() == 0) { %>
            <p class="empty">등록된 댓글이 없습니다.</p>
        <% } %>
    </div>
    <div class="comment commentWrite">
        <form action="#" method="post">
            <p>댓글쓰기</p>
            <input type="hidden" name="pg" value="<%=pg%>">
            <input type="hidden" name="parent" value="<%=no%>">
            <input type="hidden" name="uid" value="<%=sessUser.getUid()%>">
            <textarea name="content"></textarea>
            <div>
                <a href="#" class="btnCancel">취소</a>
                <input type="submit" class="btnComplete" value="작성완료">
            </div>
        </form>
    </div>
</main>
<%@ include file = "./_footer.jsp" %>