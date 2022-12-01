<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
			<main id="board">
			    <section class="view">
			        
			        <table border="0">
			            <caption>글보기</caption>
			            <tr>
			                <th>제목</th>
			                <td><input type="text" name="title" value="${vo.title}" readonly/></td>
			            </tr>
			            <c:if test="${vo.file eq 1}">
			            <tr>
			                <th>파일</th>
			                <td><a href="/Farmstory2/board/download.do?fno=${vo.fno}">${vo.oriName}</a>&nbsp;<span>${vo.download}</span>회 다운로드</td>
			            </tr>
			            </c:if>
			            <tr>
			                <th>내용</th>
			                <td>
			                    <textarea name="content" readonly>${vo.content}</textarea>
			                </td>
			            </tr>                    
			        </table>
			        
			        <div>
			        	<c:if test="${sessUser.uid eq vo.uid}">
				            <a href="/Farmstory2/board/delete.do?group=${group}&cate=${cate}&pg=${pg}&no=${vo.no}" class="btn btnRemove">삭제</a>
				            <a href="/Farmstory2/board/modify.do?group=${group}&cate=${cate}&pg=${pg}&no=${vo.no}" class="btn btnModify">수정</a>
			            </c:if>
			            <a href="/Farmstory2/board/list.do?group=${group}&cate=${cate}&pg=${pg}" class="btn btnList">목록</a>
			        </div>
			    </section>
			</main>
		</article>
	</section>
</div>
<jsp:include page="/WEB-INF/_footer.jsp"/>