<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>CookieResult.jsp</title>
	</head>
	<body>
		<h2>쿠키값 확인하기(쿠키가 생성된 이후의 페이지)</h2>
		<%
			//요청 헤더의 모든 쿠키 얻기
			Cookie[] cookies = request.getCookies();
			if(cookies != null){
				for(Cookie c : cookies){
					//쿠키 이름
					String cookieName = c.getName();
					//쿠키 값
					String cookieValue = c.getValue();
					//화면 출력
					out.println("cookieName : " + cookieName);
					out.println("cookieValue : " + cookieValue + "<br/>");
				}
			}
		%>
	</body>
</html>