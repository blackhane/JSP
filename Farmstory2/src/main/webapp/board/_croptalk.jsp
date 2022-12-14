<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <div id="sub">
            <div><img src="../img/sub_top_tit3.png" alt="CROP TALK"></div>
            <section class="cate3">
                <aside>
                    <img src="../img/sub_aside_cate3_tit.png" alt="농작물이야기"/>

                    <ul class="lnb">
                        <li class= "${cate eq 'story' ? 'on' : 'off'}"><a href="/Farmstory2/board/list.do?group=croptalk&cate=story">농작물이야기</a></li>
                        <li class= "${cate eq 'grow' ? 'on' : 'off'}"><a href="/Farmstory2/board/list.do?group=croptalk&cate=grow">텃밭가꾸기</a></li>
                        <li class= "${cate eq 'school' ? 'on' : 'off'}"><a href="/Farmstory2/board/list.do?group=croptalk&cate=school">귀농학교</a></li>
                    </ul>

                </aside>
                <article>
                    <nav>
                        <img src="../img/sub_nav_tit_cate3_${cate}.png" alt="농작물이야기"/>
                        <p>
                            <c:if test="${cate eq 'story'}">HOME > 농작물이야기 > <em>농작물이야기</em></c:if>
                            <c:if test="${cate eq 'grow'}">HOME > 농작물이야기 > <em>텃밭가꾸기</em></c:if>
                            <c:if test="${cate eq 'school'}">HOME > 농작물이야기 > <em>귀농학교</em></c:if>
                        </p>
                    </nav>
