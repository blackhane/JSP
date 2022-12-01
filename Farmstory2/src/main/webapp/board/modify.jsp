<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
			<main id="board">
			    <section class="modify">
			
			        <form action="/Farmstory2/board/modify.do" method="post">
			        <input type="hidden" name="no" value="${vo.no}">
			            <table border="0">
			                <caption>글수정</caption>
			                <tr>
			                    <th>제목</th>
			                    <td><input type="text" name="title" value="${vo.title}"/></td>
			                </tr>
			                <tr>
			                    <th>내용</th>
			                    <td>
			                        <textarea name="content">${vo.content}</textarea>
			                    </td>
			                </tr>
			                <tr>
			                    <th>파일</th>
			                    <td>
			                        <input type="file" name="file" value="${vo.oriName}"/>
			                    </td>
			                </tr>
			            </table>
			            
			            <div>
			                <a href="./view.do?no=${vo.no}" class="btn btnCancel">취소</a>
			                <input type="submit" value="작성완료" class="btn btnComplete"/>
			            </div>
			        </form>
			
			    </section>
			</main>
		</article>
	</section>
</div>
<jsp:include page="/WEB-INF/_footer.jsp"/>