<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>팜스토리</title>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css"/>
    <link rel="stylesheet" href="/Farmstory2/css/style.css"/>
    <link rel="stylesheet" href="/Farmstory2/board/css/style.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>    
    <script>
        $(function(){
            $('.slider > ul').bxSlider({
                slideWidth: 980,
                pager: false,
                controls: false,
                auto: true
            });

            $('#tabs').tabs();
        });
    </script>
	<script>
		let Code = "${param.Code}";
		
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
			alert("게시글이 수정되었습니다..");
		}
		if(Code == 105){
			alert("게시글이 삭제되었습니다..");
		}
	</script>
</head>
<body>
    <div id="wrapper">
        <header>
            <a href="/Farmstory2/index.do" class="logo"><img src="/Farmstory2/img/logo.png" alt="로고"/></a>
            <p>
                <a href="/Farmstory2/index.do">HOME |</a>
                <c:choose>
                	<c:when test="${empty sessUser}">
		                <a href="/Farmstory2/board/user/login.do">로그인 |</a>
		                <a href="/Farmstory2/board/user/terms.do">회원가입 |</a>
                	</c:when>
                	<c:otherwise>
                		<a href="/Farmstory2/board/user/logout.do">로그아웃 |</a>
                	</c:otherwise>
                </c:choose>
                <a href="/Farmstory2/index.do?Code=103">고객센터</a>
            </p>
            <img src="/Farmstory2/img/head_txt_img.png" alt="3만원 이상 무료배송"/>
            
            <ul class="gnb">
                <li><a href="/Farmstory2/introduction/hello.do">팜스토리소개</a></li>
                <li><a href="/Farmstory2/board/list.do?group=market&cate=market"><img src="/Farmstory2/img/head_menu_badge.png" alt="30%"/>장보기</a></li>
                <li><a href="/Farmstory2/board/list.do?group=croptalk&cate=story">농작물이야기</a></li>
                <li><a href="/Farmstory2/board/list.do?group=event&cate=event">이벤트</a></li>
                <li><a href="/Farmstory2/board/list.do?group=community&cate=notice">커뮤니티</a></li>
            </ul>
        </header>