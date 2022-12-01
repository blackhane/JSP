<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>
			<main id="board">
			    <section class="list">                
			        <form action="#">
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
			            <c:forEach items="${vo}" var="vo">                  
			            <tr>
			            <c:forEach ver="i" begin="0" end="10">
			                <td>${pageStartNum}-${i}</td>
			            </c:forEach>    
			                <td><a href="/Farmstory2/board/view.do?group=${group}&cate=${cate}&no=${vo.no}">${vo.title} [${vo.comment}]</a></td>
			                <td>${vo.nick}</td>
			                <td>${vo.rdate }</td>
			                <td>${vo.hit}</td>
			            </tr>
			            </c:forEach>
			            <c:if test="${empty vo}">
			            	<tr>
			            		<td colspan="5">등록된 게시물이 없습니다.</td>
			            	</tr>
			            </c:if>
			        </table>
			
			        <div class="page">
			            <a href="#" class="prev">이전</a>
			            <a href="#" class="num current">1</a>
			            <a href="#" class="next">다음</a>
			        </div>
					<c:if test="${sessUser.uid ne null}">
			        	<a href="/Farmstory2/board/write.do" class="btn btnWrite">글쓰기</a>
			        </c:if>
			    </section>
			</main>
			
		</article>
	</section>
</div>
<jsp:include page="/WEB-INF/_footer.jsp"/>