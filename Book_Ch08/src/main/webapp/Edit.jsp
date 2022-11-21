<%@page import="DTO.BoardDTO"%>
<%@page import="DAO.BoardDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./LoginChecked.jsp" %>
<%
	String num = request.getParameter("num");
	BoardDAO dao = BoardDAO.getInstance();
	BoardDTO dto = dao.selectView(num);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>모델1 게시판</title>
		<script type="text/javascript">
			//폼 검증
			function validataForm(form){
				if(form.title.value == ""){
					alert("제목을 입력하세요.");
					form.title.focus();
					return false;
				}
				if(form.content.value == ""){
					alert("내용을 입력하세요.");
					form.content.focus();
					return false;
				}
			}
		</script>
	</head>
	<body>
		<jsp:include page="./Link.jsp"/>
		<h2>회원제 게시판 - 수정하기</h2>
		<form name="writeFrm" method="post" action="./proc/EditProcess.jsp" onsubmit="return validateForm(form);">
		<input type="hidden" name="num" value="<%=dto.getNum() %>"/>
			<table border="1" width="90%">
				<tr>
					<td>제목</td>
					<td><input type="text" name="title" style="width:90%;" value="<%=dto.getTitle() %>"/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="content" style="width:90%; height:100px;"><%=dto.getContent() %></textarea></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit">작성 완료</button>
						<button type="reset">다시 입력</button>
						<button type="button" onclick="location.href='./List1.jsp';">목록보기</button>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>