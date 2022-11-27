<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>파일 첨부형 게시판</title>
		<style>
			a {text-decoration: none;}
		</style>
	</head>
	<body>
		<h2>파일 첨부형 게시판 - 목록보기(List)</h2>
		<!-- 검색 -->
		<form method="get">
			<table border="1" width="90%">
				<tr>
					<td align="center">
						<select name="searchField">
							<option value="title">제목</option>
							<option value="content">내용</option>
						</select>
						<input type="text" name="searchWord"/>
						<input type="submit" value="검색하기"/>
					</td>
				</tr>
			</table>
		</form>
		
		<!-- 목록 테이블 -->
		<table border="1" width="90%">
			<tr>
				<th width="10%">번호</th>
				<th width="*">제목</th>
				<th width="15%">작성자</th>
				<th width="10%">조회수</th>
				<th width="15%">작성일</th>
				<th width="8%">첨부</th>
			</tr>
			<tr>
				<td colspan="6" align="center">
					등록된 게시물이 없습니다.
				</td>
			</tr>
<%-- 			<c:choose> --%>
<!-- 				게시물 X -->
<%-- 				<c:when test="${empty boardLists }"> --%>
<!-- 					<tr> -->
<!-- 						<td colspan="6" align="center"> -->
<!-- 							등록된 게시물이 없습니다. -->
<!-- 						</td> -->
<!-- 					</tr> -->
<%-- 				</c:when> --%>
<!-- 				게시물 O -->
<%-- 				<c:otherwise> --%>
<%-- 					<c:forEach items="${boardLists }" var="row" varStatus="loop"> --%>
<!-- 					<tr align="center"> -->
<!-- 						<td></td>번호 -->
<!-- 						<td></td>제목 -->
<!-- 						<td></td>작성자 -->
<!-- 						<td></td>조회수 -->
<!-- 						<td></td>작성일 -->
<!-- 						<td></td>첨부파일 -->
<!-- 					</tr> -->
<%-- 					</c:forEach> --%>
<%-- 				</c:otherwise> --%>
<%-- 			</c:choose> --%>
		</table>
		
		<!-- 하단 메뉴(바로가기, 글쓰기) -->
		<table border="1" width="90%">
			<tr align="center">
				<td>
					1
				</td>
				<td width="100"><button type="button" onclick="location.href='./Write.jsp';">글쓰기</button></td>
			</tr>
		</table>
	</body>
</html>