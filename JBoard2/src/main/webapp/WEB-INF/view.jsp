<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<script>
	$(function(){
		//시작과 동시에 리스트 출력
		showComment();
		//댓글 리스트 출력 함수
		function showComment(){
			let parent = "${no}";
			console.log(parent);
	
			let sessId = '${sessUser.uid}';
			console.log(sessId);
			
			$.ajax({
				url : '/JBoard2/comment.do',
				method : 'get',
				data : {'parent' : parent},
				dataType : 'json',
				success : function(data){
					if(data == 0){
						let	tag = "<p class='empty'>등록된 댓글이 없습니다.</p>";
						$('.commentList').append(tag);
					}
					if(data != null){
						console.log(data);
						for(let reply of data){
							let	tag = "<article class='replyList'>";
							    tag += "<span class='nick'>"+reply.nick+"</span>&nbsp;";
								tag += "<span class='date'>"+reply.rdate+"</span>";
								tag += "<p class='content'>"+reply.content+"</p>";
								tag += "<div>";
								let uid = reply.uid;
								console.log(uid);
								if(sessId == uid){					
									tag += "<a href='#' class='remove' data-no='"+reply.no+"' data-parent='"+reply.parent+"'>삭제</a>&nbsp;&nbsp;";
									tag += "<a href='#' class='modify' data-no='"+reply.no+"'>수정</a>";
								}				
								tag += "</div>";
								tag += "</article>";
							$('.commentList').append(tag);
						}
					}
				
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
				return false;
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
					$('.replyList').remove();
					$('.empty').remove();
					showComment();
					$('.replyContent').val('');
				}
			});
			return false;
		});
		
		//댓글 수정
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
				
				let content = p.text();
				let no = $(this).attr('data-no');
				
				let jsonData = {
					"content": content,
					"no": no
				};
				
				console.log(jsonData);
				
				$.ajax({
					url: '/JBoard2/commentProc.do',
					type: 'post',
					data: jsonData,
					dataType: 'json',
					success: function(data){
						if(data.result > 0){
							alert('댓글이 수정되었습니다.');
							$('.replyList').remove();
							showComment();
						}
					}
				});
				
			}
			
		});
		
		//댓글 삭제
		$(document).on('click','.remove',function(e){
			e.preventDefault();
			
			let result = confirm("댓글을 삭제 하시겠습니까?");
			
			if(result){
				let no = $(this).attr('data-no');
				let parent = $(this).attr('data-parent');
				
				let jsonData = {
					"no":no,
					"parent":parent
				};
				console.log(jsonData);
				
				$.ajax({
					url : "/JBoard2/commentProc.do",
					type : "get",
					data : jsonData,
					dataType : "json",
					success : function(data){
						console.log(data.result);
						alert("댓글이 삭제되었습니다.");
						$('.replyList').remove();
						showComment();
					}
				});
			}
		});
		
		$('.btnCancel').click(function(){
			$('textarea[name=content]').val('');
		});
		
		$('.btnRemove').click(function(){
			let chk = confirm('게시글을 삭제하시겠습니까?');
			if(chk){
				return true;
			}else{
				return false;
			}
			return false;
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
                <td><a href="/JBoard2/download.do?fno=${article.fno}">${article.oriName}</a>&nbsp;<span>${article.download}</span>회 다운로드</td>
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
            <a href="/JBoard2/delete.do?no=${article.no}&pg=${pg}" class="btn btnRemove">삭제</a>
            <a href="/JBoard2/modify.do?no=${article.no}&pg=${pg}" class="btn btnModify">수정</a>
            <a href="/JBoard2/list.do?pg=${pg}" class="btn btnList">목록</a>
        </div>

        <!-- 댓글목록 -->
        <section class="commentList">
            <h3>댓글목록</h3>                   
<!-- 				<article> -->
<%-- 	                <span class="nick">${comment.nick}</span> --%>
<%-- 	                <span class="date">${comment.rdate}</span> --%>
<%-- 	                <p class="content">${comment.content}</p>    --%>
<%-- 	                <c:if test="${sessUser.uid eq comment.uid}">                      --%>
<!-- 	                <div> -->
<!-- 	                    <a href="#" class="remove">삭제</a> -->
<!-- 	                    <a href="#" class="modify">수정</a> -->
<!-- 	                </div> -->
<%-- 	                </c:if> --%>
<!-- 	            </article> -->
        </section>

        <!-- 댓글쓰기 -->
        <section class="commentForm">
            <h3>댓글쓰기</h3>
            <form action="#">
            	<input type="hidden" name="uid" value="${sessUser.uid}">
            	<input type="hidden" name="parent" value="${article.no}">
                <textarea name="content" class="replyContent"></textarea>
                <div>
                    <a href="#" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete"/>
                </div>
            </form>
        </section>

    </section>
</main>
<jsp:include page="./_footer.jsp"/>