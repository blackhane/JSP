<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>3_JSON</title>
		<!-- 
			날짜 : 2022 10 20
			이름 : 박진휘
			내용 : JSON 실습
		 -->
		 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		 <script>
		 	$(function(){
			 	$('.btn1').click(function(){
			 		$.ajax({
			 			url : './data/json1.jsp',
			 			method : 'get',
			 			dataType : 'json',
			 			success:function(data){
			 				console.log(data);
			 				$('p:eq(0) > span:eq(0)').text(data.uid);
			 				$('p:eq(0) > span:eq(1)').text(data.name);
			 				$('p:eq(0) > span:eq(2)').text(data.hp);
			 				$('p:eq(0) > span:eq(3)').text(data.age);
			 			}
			 		});
			 	});
			 	$('.btn2').click(function(){
			 		$.ajax({
			 			url : './data/json2.jsp',
			 			method : 'get',
			 			dataType : 'json',
			 			success:function(data){
			 				console.log(data);
			 				for(let users of data){
			 					let tags  = "<tr>";
			 						tags += "<td>"+users.uid+"</td>";
			 						tags += "<td>"+users.name+"</td>";
			 						tags += "<td>"+users.hp+"</td>";
			 						tags += "<td>"+users.age+"</td>";
			 						tags += "</tr>";
			 					
			 					$('table').append(tags);
			 				}
			 			}
			 		});
			 	});
		 	});
		 </script>
	</head>
	<body>
		<h3>JSON</h3>
		
		<a href="./data/json1.jsp">JSON 출력</a>
		<a href="./data/json2.jsp">JSON Array 출력</a><br>
		
		<h4>Ajax 실습</h4>
		
		<button class="btn1">데이터 요청하기</button>
		<p>
			아이디 : <span></span><br>
			이름 : <span></span><br>
			휴대폰 : <span></span><br>
			나이 : <span></span><br>
		</p>
		
		<button class="btn2">데이터 요청하기</button>
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>나이</th>
			</tr>
		</table>
	</body>
</html>