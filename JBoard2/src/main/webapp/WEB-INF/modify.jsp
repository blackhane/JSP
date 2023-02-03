<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="./_header.jsp"/>
<script>
	$(function(){
		
		$('.btnComplete').click(function(){
			
			let chk = confirm("게시글을 수정하시겠습니까?");
			if(chk){
				return true;
			}else{
				return false;
			}
			return false;
		});
		
	})
</script>
<main id="board">
    <section class="modify">

        <form action="/JBoard2/modify.do" method="post" enctype="multipart/form-data">
        <input type="hidden" name="no" value="${no}"/>
        <input type="hidden" name="pg" value="${pg}"/>
            <table border="0">
                <caption>글수정</caption>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" value="${article.title}"/></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea name="content">${article.content}</textarea>
                    </td>
                </tr>
                <tr>
                    <th>파일</th>
                    <td>
                        <input type="file" name="file"/>
                    </td>
                </tr>
            </table>
            
            <div>
                <a href="/JBoard2/view.do?no=${no}&pg=${pg}" class="btn btnCancel">취소</a>
                <input type="submit" value="작성완료" class="btn btnComplete"/>
            </div>
        </form>

    </section>
</main>
<jsp:include page="./_footer.jsp"/>