<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <link rel="stylesheet" href="/JBoard2/css/style.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
		let Code = "${Code}";
		console.log(Code);
		
		if(Code == 100){
			alert("등록되지 않은 회원입니다.\n아이디와 비밀번호를 확인해주십시요.");
		}
		if(Code == 101){
			alert("회원가입이 완료되었습니다.");
		}
		if(Code == 102){
			alert("로그아웃이 정상처리 되었습니다.");
		}
		if(Code == 103){
			alert("아직 개설되지 않은 게시판입니다.");
		}
		if(Code == 104){
			alert("게시글이 수정되었습니다.");
		}
		if(Code == 105){
			alert("게시글이 삭제되었습니다.");
		}
	</script>
</head>
<body>
    <div id="wrapper">
        <header>
            <h3>Board System v1.0></h3>
            <p>
                <span>${sessionScope.sessUser.nick }</span>님 반갑습니다.
                <a href="/JBoard2/user/info.do">[회원정보]</a>
                <a href="/JBoard2/user/logout.do?uid=${sessUser.uid}">[로그아웃]</a>
            </p>
        </header>