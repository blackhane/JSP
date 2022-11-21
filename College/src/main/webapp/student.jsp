<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="JDBC.JDBC"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bean.StudentBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	List<StudentBean> students = new ArrayList<>();
	
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		String sql = "select * from `student`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		while(rs.next()){
			StudentBean student = new StudentBean();
			student.setStdNo(rs.getString(1));
			student.setStdName(rs.getString(2));
			student.setStdHp(rs.getString(3));
			student.setStdYear(rs.getInt(4));
			student.setStdAddress(rs.getString(5));
			students.add(student);
		}
		rs.close();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>학생관리</title>
	</head>
	<body>
		<h3>학생관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		<h4>학생목록</h4>
		<button>등록</button>
		<table border="1">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>학년</th>
				<th>주소</th>
			</tr>
			<% for(StudentBean student : students) { %>
			<tr>
				<td><%=student.getStdNo() %></td>	
				<td><%=student.getStdName() %></td>	
				<td><%=student.getStdHp() %></td>	
				<td><%=student.getStdYear() %></td>	
				<td><%=student.getStdAddress() %></td>					
			</tr>
			<% } %>
		</table>
	</body>
</html>