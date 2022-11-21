<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
<div id="sub">
    <div>
        <img src="../img/sub_top_tit5.png" alt="community">
    </div>
    <section class="cate5">
        <aside>
            <img src="../img/sub_aside_cate5_tit.png" alt="커뮤니티">
            <ul>
                <li class="<%=cate.equals("community1") ? "on" : "off" %>"><a href="./list.jsp?group=community&cate=community1&pg=1">공지사항</a></li>
                <li class="<%=cate.equals("community2") ? "on" : "off" %>"><a href="./list.jsp?group=community&cate=community2&pg=1">오늘의식단</a></li>
                <li class="<%=cate.equals("community3") ? "on" : "off" %>"><a href="./list.jsp?group=community&cate=community3&pg=1">나도요리사</a></li>
                <li class="<%=cate.equals("community4") ? "on" : "off" %>"><a href="./list.jsp?group=community&cate=community4&pg=1">1:1고객문의</a></li>
                <li class="<%=cate.equals("community5") ? "on" : "off" %>"><a href="./list.jsp?group=community&cate=community5&pg=1">자주묻는질문</a></li>
            </ul>
        </aside>
        <article>
            <nav>
            	<img src="../img/sub_nav_tit_cate5_<%=cate %>.png">
            </nav>