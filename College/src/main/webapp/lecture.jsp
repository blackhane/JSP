<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bean.LectureBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="JDBC.JDBC"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	List<LectureBean> lectures = new ArrayList<>();
	
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		String sql = "select * from `lecture`";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		while(rs.next()){
			LectureBean lecture = new LectureBean();
			lecture.setLecNo(rs.getInt(1));
			lecture.setLecName(rs.getString(2));
			lecture.setLecCredit(rs.getInt(3));
			lecture.setLecTime(rs.getInt(4));
			lecture.setLecClass(rs.getString(5));
			lectures.add(lecture);
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
		<title>강좌관리</title>
	</head>
	<body>
		<h3>강좌관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		<h4>강좌현황</h4>
		<button>등록</button>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>강좌명</th>
				<th>학점</th>
				<th>시간</th>
				<th>강의장</th>
			</tr>
			<% for(LectureBean lecture : lectures) { %>
			<tr>
				<td><%= lecture.getLecNo() %></td>	
				<td><%= lecture.getLecName() %></td>	
				<td><%= lecture.getLecCredit() %></td>	
				<td><%= lecture.getLecTime() %></td>	
				<td><%= lecture.getLecClass() %></td>	
			</tr>
			<% } %>
		</table>
	</body>
</html>