<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cate = request.getParameter("cate");
%>
<div id="sub">
    <div>
        <img src="../img/sub_top_tit3.png" alt="croptalk">
    </div>
    <section class="cate3">
        <aside>
            <img src="../img/sub_aside_cate3_tit.png" alt="농작물이야기">
            <ul>
                <li class="<%=cate.equals("story") ? "on" : "off" %>"><a href="./list.jsp?group=croptalk&cate=story&pg=1">농작물이야기</a></li>
                <li class="<%=cate.equals("grow") ? "on" : "off" %>"><a href="./list.jsp?group=croptalk&cate=grow&pg=1">텃밭가꾸기</a></li>
                <li class="<%=cate.equals("school") ? "on" : "off" %>"><a href="./list.jsp?group=croptalk&cate=school&pg=1">귀농학교</a></li>
            </ul>
        </aside>
        <article>
            <nav>
            	<img src="../img/sub_nav_tit_cate3_<%=cate %>.png">
            </nav>