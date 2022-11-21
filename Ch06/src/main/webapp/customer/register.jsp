<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Customer Register</title>
	</head>
	<body>
		<h3>신규등록</h3>
		<a href="./list.jsp">이전으로</a>
		<form action="./registerProc.jsp" method="post">
			<table border = "1">
				<tr>
					<td>아이디</td>
					<td><input type="text" name="custId" placeholder="아이디 입력"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" placeholder="이름 입력"></td>
				</tr>
				<tr>
					<td>전화번호</td>
					<td><input type="text" name="hp" placeholder="전화번호 입력"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="addr" placeholder="주소 입력"></td>
				</tr>
				<tr>
					<td>등록일</td>
					<td><input type="date" name="rDate" placeholder="등록일 입력"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="제출"></td>
				</tr>
			</table>
		</form>
	</body>
</html>