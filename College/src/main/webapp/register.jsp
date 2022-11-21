<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="JDBC.JDBC"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Bean.RegisterBean"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	List<RegisterBean> registers = new ArrayList<>();
	
	try{
		Connection conn = JDBC.getInstance().getConnetction();
		String sql = "SELECT a.*,b.`lecName`,c.`stdName` FROM `register` AS a ";
			   sql += "JOIN `lecture` AS b ON a.regLecNo = b.lecNo ";
			   sql += "JOIN `student` AS c ON a.regStdNo = c.stdNo";
		PreparedStatement psmt = conn.prepareStatement(sql);
		ResultSet rs = psmt.executeQuery();
		while(rs.next()){
			RegisterBean register = new RegisterBean();
			register.setRegStdNo(rs.getString(1));
			register.setRegLecNo(rs.getInt(2));
			register.setRegMidScore(rs.getInt(3));
			register.setRegFInalScore(rs.getInt(4));
			register.setRegTotalScore(rs.getInt(5));
			register.setRegGrade(rs.getString(6));
			register.setLecName(rs.getString(7));
			register.setStdName(rs.getString(8));
			registers.add(register);
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
		<title>수강관리</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script>
			$(function(){
				$(document).on('click','.register',function(){
					let stdNo = $('.stdNo').val();
					let stdName = $('.stdName').val();
					let lec = document.getElementById('lecName');
					let lecName = lec.options[lec.selectedIndex].text;
					
					let jsonData = {
						"stdNo" : stdNo,
						"stdName" : stdName,
						"lecName" : lecName
					};
					console.log(jsonData);
				});
			});
		</script>
	</head>
	<body>
		<h3>수강관리</h3>
		<a href="/College/lecture.jsp">강좌관리</a>
		<a href="/College/register.jsp">수강관리</a>
		<a href="/College/student.jsp">학생관리</a>
		<h4>수강현황</h4>
		<input type="search" value="검색">
		<button>검색</button>
		<button>수강신청</button>
		<table border="1">
			<tr>
				<th>학번</th>
				<th>이름</th>
				<th>강좌명</th>
				<th>강좌코드</th>
				<th>중간시험</th>
				<th>기말시험</th>
				<th>총점</th>
				<th>등급</th>
			</tr>
			<% for(RegisterBean register : registers) { %>
			<tr>
				<td><%=register.getRegStdNo()  %></td>	
				<td><%=register.getStdName()  %></td>	
				<td><%=register.getLecName()  %></td>	
				<td><%=register.getRegLecNo() %></td>	
				<td><%=register.getRegMidScore() %></td>	
				<td><%=register.getRegFInalScore() %></td>	
				<td><%=register.getRegTotalScore() %></td>	
				<td><%=register.getRegGrade() %></td>						
			</tr>
			<% } %>
		</table>
		
		<h4>수강신청</h4>
		<button>닫기</button>
		<table border="1">
			<tr>
				<td>학번</td>
				<td><input type="text" name="stdNo" class="stdNo"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="stdName" class="stdName"></td>
			</tr>
			<tr>
				<td>신청강좌</td>
				<td>
					<select name="LecName" id="lecName">
						<option value="1">운영체제론</option>
						<option value="2">무역영문</option>
						<option value="3">세법개론</option>
						<option value="4">빅데이터개론</option>
						<option value="5">컴퓨팅사고와 코딩</option>
						<option value="6">사회복지 마케팅</option>
						<option value="7">컴퓨터 구조론</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<button class="register">신청</button>
				</td>
			</tr>
		</table>
	</body>
</html>