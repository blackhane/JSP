<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>User2 관리자</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
		<script src="./js/list.js"></script>
		<script src="./js/register.js"></script>
		<script src="./js/modify.js"></script>
		<script>
			$(function(){
				//시작페이지
				list();
				
				//user2 목록페이지
				$(document).on('click','.list',function(e){
					e.preventDefault();
					list();
				});
				
				//user2 등록페이지
				$(document).on('click','.register',function(e){
					e.preventDefault();
					register();
				});
				
				//user2 등록(register)
				$(document).on('click','#btnRegister',function(e){
					e.preventDefault;
					//데이터 가져오기
					let uid = $('input[name=uid]').val();
					let name = $('input[name=name]').val();
					let hp = $('input[name=hp]').val();
					let age = $('input[name=age]').val();
					//Json 데이터 생성
					let jsonData = {
						'uid':uid,	
						'name':name,	
						'hp':hp,	
						'age':age	
					};
					console.log(jsonData);
					//데이터 전송
					$.ajax({
						url:'./json/register.jsp',
						type:'post',
						data:jsonData,
						dataType:'json',
						success:function(data){
							console.log(data);
							
							if(data.result == 1){
								alert('데이터 등록 성공');
								list();
							}else{
								alert('데이터 등록 실패');
							}
						}
					});
				});
				//user2 등록(register)
				
				//user2 수정페이지
				$(document).on('click','.modify',function(e){
					e.preventDefault;
					modify();
					//데이터 가져오기
					let uid = $(this).attr('data-uid');
					let jsonData = {
						'uid':uid
					}
					$.ajax({
						url:'./json/user.jsp',
						type:'post',
						data:jsonData,
						dataType:'json',
						success:function(data){
							console.log(data);
							let tags  = "<table border='1'>";
							tags += "<tr>";
							tags += "<td>아이디</td>";
							tags += "<td><input type='text' name='uid' readonly value='"+data.uid+"'></td>";
							tags += "</tr>";
							tags += "<tr>";
							tags += "<td>이름</td>";
							tags += "<td><input type='text' name='name' value='"+data.name+"'></td>";
							tags += "</tr>";
							tags += "<tr>";
							tags += "<td>휴대폰</td>";
							tags += "<td><input type='text' name='hp' value='"+data.hp+"'></td>";
							tags += "</tr>";
							tags += "<tr>";
							tags += "<td>나이</td>";
							tags += "<td><input type='text' name='age' value='"+data.age+"'></td>";
							tags += "</tr>";
							tags += "<tr>";
							tags += "<td colspan='2' align='right'><input type='submit' id='btnModify' value='수정'></td>";
							tags += "</tr>";
							tags += "</table>";
						
							$('#content').append(tags);
						}
					});
				});
				
				//user2 수정(modify)
				$(document).on('click','#btnModify',function(e){
					e.preventDefault;
					//데이터 가져오기
					let uid = $('input[name=uid]').val();
					let name = $('input[name=name]').val();
					let hp = $('input[name=hp]').val();
					let age = $('input[name=age]').val();
					//Json 데이터 생성
					let jsonData = {
						'uid':uid,	
						'name':name,	
						'hp':hp,	
						'age':age	
					};
					console.log(jsonData);
					//데이터 전송
					$.ajax({
						url:'./json/modify.jsp',
						type:'post',
						data:jsonData,
						dataType:'json',
						success:function(data){
							console.log(data);
							
							if(data.result == 1){
								alert('데이터 수정 성공');
								list();
							}else{
								alert('데이터 수정 실패');
							}
						}
					});
				});
				//user2 수정(modify)
				
				//user2 삭제(delete)
				$(document).on('click','.delete',function(e){
					e.preventDefault;
					let del = confirm('정말로 삭제하시겠습니까?');
					if(del == true){
						//데이터 가져오기
						let uid = $(this).attr('data-uid');
						//Json 데이터 생성
						let jsonData = {
							'uid' : uid
						}
						console.log(jsonData);
						//데이터 전송
						$.ajax({
							url:'./json/delete.jsp',
							type:'post',
							data:jsonData,
							dataType:'json',
							success:function(data){
								console.log(data);
								if(data.result == 1){
									alert('데이터 삭제 성공');
									list();
								}else{
									alert('데이터 삭제 실패');
								}
							}
						});
					}else{
						return console.log('데이터 삭제 취소');
					}
				});
				//user2 삭제(delete)
			});
		</script>
		<style>
			table {
				border-collapse: collapse;
			}
		</style>
	</head>
	<body>
		<h3>User2 관리자</h3>
		<nav></nav>
		<div id="content"></div>
	</body>
</html>