<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<script>

	$(function(){
		//시작과 동시에 리스트 출력
		showComment();
		
		//댓글 리스트 출력 함수
		function showComment(){
			let no = $('input[name=parent]').val();
			console.log(no);
			
			$.ajax({
				url : '/JBoard2/comment.do',
				method : 'get',
				data : {'no' : no},
				dataType : 'json',
				success : function(data){
					console.log(data.result)
					if(data.result < 1){
						let comment = "<p>등록된 댓글이 없습니다.</p>";
					}else{
						let comment = "<article>";
							comment += "<span class='nick'>${comment.nick}</span>";
							comment += "<span class='date'>${comment.rdate}</span>";
							comment += "<p class='content'>${comment.content}</p>";
							comment += "<c:if test='${sessUser.uid eq comment.uid}'>";
							comment += "<div><a href='#' class='remove'>삭제</a>";
							comment += "<a href='#' class='modify'>수정</a></div>";
							comment += "</c:if>";
							comment += "</article>";
					}
					$('.commentList').appent(comment);
				}
			});
		}
		
		//댓글 쓰기
		$('.commentForm > form').submit(function(){
			
			let parent = $(this).children('input[name=parent]').val();
			let textarea = $(this).children('textarea[name=content]');
			let uid = $(this).children('input[name=uid]').val();
			let content = textarea.val();
			
			if(content == ''){
				return;
			}
			
			let jsonData = {
					'uid' : uid,
					'parent' : parent,
					'content' : content
			};
			console.log(jsonData);
			
			$.ajax({
				url : '/JBoard2/comment.do',
				method : 'post',
				data : jsonData,
				dataType : 'json',
				success : function(data){
					console.log(data.result);
					$('textarea[name=content]').val('');
				}
			});
			return false;
		});
		
		$('.btnCancel').click(function(){
			$('textarea[name=content]').val('');
		});
	});
</script>
<main id="board">
    <section class="view">
        
        <table border="0">
            <caption>글보기</caption>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" value="${article.title}" readonly/></td>
            </tr>
            <c:if test="${article.file ne 0 }">
            <tr>
                <th>파일</th>
                <td><a href="#">${article.oriName}</a>&nbsp;<span>${article.download}</span>회 다운로드</td>
            </tr>
            </c:if>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="content" readonly>${article.content}</textarea>
                </td>
            </tr>                    
        </table>
        
        <div>
            <a href="/JBoard2/delete.do?no=${article.no}" class="btn btnRemove">삭제</a>
            <a href="/JBoard2/modify.do?no=${article.no}" class="btn btnModify">수정</a>
            <a href="/JBoard2/list.do" class="btn btnList">목록</a>
        </div>

        <!-- 댓글목록 -->
        <section class="commentList">
            <h3>댓글목록</h3>                   
		
			<c:if test="${comments ne null}">
				<c:forEach items="${comments}" var="comment">
					<article>
		                <span class="nick">${comment.nick}</span>
		                <span class="date">${comment.rdate}</span>
		                <p class="content">${comment.content}</p>   
		                <c:if test="${sessUser.uid eq comment.uid}">                     
		                <div>
		                    <a href="#" class="remove">삭제</a>
		                    <a href="#" class="modify">수정</a>
		                </div>
		                </c:if>
		            </article>
	            </c:forEach>
            </c:if>
        </section>

        <!-- 댓글쓰기 -->
        <section class="commentForm">
            <h3>댓글쓰기</h3>
            <form action="#">
            	<input type="hidden" name="uid" value="${sessUser.uid}">
            	<input type="hidden" name="parent" value="${article.no}">
                <textarea name="content"></textarea>
                <div>
                    <a href="#" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete"/>
                </div>
            </form>
        </section>

    </section>
</main>
<jsp:include page="./_footer.jsp"/>