/**
 * 
 */
 //user2 목록페이지 불러오기
function list(){
	$(function(){
		$('nav').empty();
		$('#content').empty();
		
		$('nav').append('<h4>user2 목록</h4>');
		$('nav').append('<a href="#" class="register">user2 등록</a>');
		
		$.get('./json/users.jsp',function(data){
			let tableTag = "<table border='1'>";
				tableTag += "<tr>";
				tableTag += "<th>아이디</th>";
				tableTag += "<th>이름</th>";
				tableTag += "<th>휴대폰</th>";
				tableTag += "<th>나이</th>";
				tableTag += "<th>관리</th>";
				tableTag += "</tr>";
				tableTag += "</table>";
			
			$('#content').append(tableTag);
			
			for(let users of data){
				let tags  = "<tr>";
					tags += "<td>"+users.uid+"</td>";
					tags += "<td>"+users.name+"</td>";
					tags += "<td>"+users.hp+"</td>";
					tags += "<td>"+users.age+"</td>";
					tags += "<td>";
					tags += "<a href='#' data-uid='"+users.uid+"' class='modify'>수정</a>";
					tags += "<a href='#' data-uid='"+users.uid+"' class='delete'>삭제</a>";
					tags += "</td>";
					tags += "</tr>";
				
				$('#content > table').append(tags);
			}
		});
	});
}