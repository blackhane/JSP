<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Cookie</title>
	</head>
	<body>
		<h2>1. 쿠키(Cookie) 설정</h2>
		<%
			//쿠키 생성
			Cookie cookie = new Cookie("myCookie","쿠키맞나요?");
			//쿠키 경로
			cookie.setPath("/");
			//쿠키 유지 기간
			cookie.setMaxAge(60*60);
			//응답 헤더에 쿠키 추가
			response.addCookie(cookie);
		%>
		<h2>2. 쿠키 설정 직후 쿠키값 확인하기</h2>
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
		<h2>3. 페이지 이동 후 쿠키값 확인하기</h2>
		<a href="./CookieResult.jsp">다음 페이지에서 쿠키값 확인하기</a>
	</body>
</html>