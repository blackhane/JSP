<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>register.jsp</title>
	</head>
	<body>
		<h3>student 등록</h3>
		<a href="./list.jsp">student 목록</a>
		<form action="./registerProc.jsp" method="post">
			<table>
				<tr>
					<td>학번</td>
					<td><input type="text" name="stdNo" placeholder="학번 입력"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="stdName" placeholder="이름 입력"></td>
				</tr>
				<tr>
					<td>휴대폰</td>
					<td><input type="text" name="stdHp" placeholder="휴대폰 입력"></td>
				</tr>
				<tr>
					<td>학년</td>
					<td><input type="text" name="stdYear" placeholder="학년 입력"></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="stdAddress" placeholder="주소 입력"></td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="등록"></td>
				</tr>
			</table>
		</form>
	</body>
</html>