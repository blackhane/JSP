<%@page import="kr.co.farmstory1.bean.UserBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	UserBean sessUser = (UserBean)session.getAttribute("sessUser");
	String ErrCode = request.getParameter("ErrCode");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Farmstory</title>
    <link rel="stylesheet" href="/Farmstory1/css/style.css">
    <link rel="stylesheet" href="/Farmstory1/user/css/style.css">
    <link rel="stylesheet" href="/Farmstory1/board/css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
    	let ErrCode = <%=ErrCode %>
    	if(ErrCode == 101){
    		alert('로그인 후 이용가능합니다.');
    	}
    	if(ErrCode == 100){
    		alert("등록되지 않은 회원입니다.\n아이디나 비밀번호를 체크해주십시오.");
    	}
    	if(ErrCode == 102){
    		alert("아직 개설되지 않은 게시판입니다.");
    	}
    	
        $(document).ready(function(){
            $('ul.tab li').click(function(){
	            let tab_id = $(this).attr('data-tab');
	
	            $('ul.tab li').removeClass('current');
	            $('.tab-content').removeClass('current');
	
	            $(this).addClass('current');
	            $("#"+tab_id).addClass('current');
		        });
	
	            $(function(){
	            let slider = $('.slide > img');
	            let i = 0;
	
	            setInterval(function(){
	                slider.eq(i).animate({'left':'-100%'},1000);
	                i++;
	                if(i>=3){
	                    i=0;
	                }
	                slider.eq(i).css('left','100%').animate({'left':'0'},1000);
	            },5000);
       		});
        });
    </script>
</head>
<body>
    <div id="wrapper">
        <header>
            <a href="/Farmstory1/index.jsp"><img src="/Farmstory1/img/logo.png" alt="HeaderLogo"></a>
            <p>
                <a href="/Farmstory1">HOME |</a>
                <%if(sessUser == null) { %>
                <a href="/Farmstory1/user/login.jsp">로그인 |</a>
                <a href="/Farmstory1/user/terms.jsp">회원가입 |</a>
                <% }else{ %>
                <a href="/Farmstory1/user/proc/logout.jsp">로그아웃 |</a>
                <% } %>
                <a href="/Farmstory1/?ErrCode=102">고객센터</a>
            </p>
            <img src="/Farmstory1/img/head_txt_img.png" alt="3만원이상 무료배송 팜카드 10% 적립">
            <ul>
                <li><a href="/Farmstory1/introduction/hello.jsp"></a></li>
                <li><a href="/Farmstory1/board/list.jsp?group=market&cate=market&pg=1"><img src="/Farmstory1/img/head_menu_badge.png" alt="30%"></a></li>
                <li><a href="/Farmstory1/board/list.jsp?group=croptalk&cate=story&pg=1"></a></li>
                <li><a href="/Farmstory1/board/list.jsp?group=event&cate=event&pg=1"></a></li>
                <li><a href="/Farmstory1/board/list.jsp?group=community&cate=community1&pg=1"></a></li>
            </ul>
        </header>