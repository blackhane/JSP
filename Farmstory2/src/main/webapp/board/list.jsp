<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
			<main id="board">
			    <section class="list">                
			        <form action="/Farmstory2/board/list.do">
			        	<input type="hidden" name="group" value="${group}">
			        	<input type="hidden" name="cate" value="${cate}">
			            <input type="text" name="search" placeholder="제목 키워드, 글쓴이 검색">
			            <input type="submit" value="검색">
			        </form>
			        
			        <table border="0">
			            <caption>글목록</caption>
			            <tr>
			                <th>번호</th>
			                <th>제목</th>
			                <th>글쓴이</th>
			                <th>날짜</th>
			                <th>조회</th>
			            </tr>
			            <c:set var="i" value="${total-start}"/>
			            <c:forEach items="${vo}" var="vo">                  
			            <tr>
			                <td>${i}</td>
			                <td><a href="/Farmstory2/board/view.do?group=${group}&cate=${cate}&pg=${currentPage}&no=${vo.no}">${vo.title}</a> [${vo.comment}]</td>
			                <td>${vo.nick}</td>
			                <td>${vo.rdate }</td>
			                <td>${vo.hit}</td>
			            </tr>
			            <c:set var="i" value="${i-1}"/>
			            </c:forEach>
			            <c:if test="${empty vo}">
			            	<tr>
			            		<td colspan="5">등록된 게시물이 없습니다.</td>
			            	</tr>
			            </c:if>
			        </table>
			        <div class="page">
						<c:if test="${pageGroupStart gt 1}">
			        		<a href="/Farmstory2/board/list.do?group=${group}&cate=${cate}&pg=${pageGroupStart-1}" class="prev">이전</a>
			        	</c:if>
			            <c:forEach var="num" begin="${pageGroupStart}" end="${pageGroupEnd}">
			            	<a href="/Farmstory2/board/list.do?group=${group}&cate=${cate}&pg=${num}&search=${search}" class="num ${currentPage eq num ? 'current' : 'off' }">${num}</a>
			            </c:forEach>
			            <c:if test="${pageGroupEnd lt lastPageNum}">
			            	<a href="/Farmstory2/board/list.do?group=${group}&cate=${cate}&pg=${pageGroupEnd+1}" class="next">다음</a>
			            </c:if>
			        </div>
					<c:if test="${sessUser.uid ne null}">
			        	<a href="/Farmstory2/board/write.do?group=${group}&cate=${cate}" class="btn btnWrite">글쓰기</a>
			        </c:if>
			    </section>
			</main>
			
		</article>
	</section>
</div>
<jsp:include page="/WEB-INF/_footer.jsp"/>