<%@page import="java.util.List"%>
<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<%
	List<ArticleBean> latest = ArticleDAO.getInstance().selectLatest();
	if(latest.size() < 15){
		ArticleBean article = new ArticleBean();
		article.setNo(0);
		article.setTitle("제목");
		article.setRdate("작성일");
		
		for(int i=0; i<15; i++){
			latest.add(article);
		}
	}
%>
<script>
	$(function(){
		//공지사항 최신글 가져오기
		$.get('/Farmstory1/board/proc/getLatest.jsp?cate=community1',function(data){
			for(let latest of data){
				let url = '/Farmstory1/board/view.jsp?group=community&cate=community1&no='+latest.no;
				$('#tab-1 .txt').append("<li>· <a href='"+url+"'>"+latest.title+"</a></li>");
			}
		});
		//고객문의 최신글 가져오기
		$.get('/Farmstory1/board/proc/getLatest.jsp?cate=community4',function(data){
			for(let latest of data){
				let url = '/Farmstory1/board/view.jsp?group=community&cate=community4&no='+latest.no;
				$('#tab-2 .txt').append("<li>· <a href='"+url+"'>"+latest.title+"</a></li>");
			}
		});
		//자주묻는질문 최신글 가져오기
		$.get('/Farmstory1/board/proc/getLatest.jsp?cate=community5',function(data){
			for(let latest of data){
				let url = '/Farmstory1/board/view.jsp?group=community&cate=community5&no='+latest.no;
				$('#tab-3 .txt').append("<li>· <a href='"+url+"'>"+latest.title+"</a></li>");
			}
		});
	});
</script>
<main>
    <div class="slider">
        <div class="slide">
            <img src="./img/main_slide_img1.jpg" alt="슬라이더1">
            <img src="./img/main_slide_img2.jpg" alt="슬라이더2">
            <img src="./img/main_slide_img3.jpg" alt="슬라이더3">
        </div>
        <img src="./img/main_slide_img_tit.png" alt="사람과자연을사랑하는팜스토리">
        <div class="banner">
            <img src="./img/main_banner_txt.png" alt="GrandOpen">
            <img src="./img/main_banner_tit.png" alt="팜스토리오픈기념">
            <img src="./img/main_banner_img.png" alt="과일사진">
        </div>
    </div>
    <div class="quick">
        <div><a href="/Farmstory1/board/list.jsp?group=community&cate=community2" class="sub1"><img src="./img/main_banner_sub1_tit.png" alt="팜스토리오늘의식단"></a></div>
        <div><a href="/Farmstory1/board/list.jsp?group=community&cate=community3" class="sub2"><img src="./img/main_banner_sub2_tit.png" alt="팜스토리나도요리사"></a></div>
    </div>
    <div class="latest">
        <div>
            <a href="#"><img src="./img/main_latest1_tit.png" alt="텃밭가꾸기"></a>
            <img src="./img/main_latest1_img.jpg" alt="사진">
            <table>
            	<% for(int i=0; i<5; i++) { %>
                <tr>
                    <td>></td>
                    <td><a href="/Farmstory1/board/view.jsp?group=croptalk&cate=grow&no=<%=latest.get(i).getNo()%>"><%=latest.get(i).getTitle() %></a></td>
                    <td><%=latest.get(i).getRdate() %></td>
                </tr>
                <% } %>
            </table>
        </div>
        <div>
            <a href="#"><img src="./img/main_latest2_tit.png" alt="귀농학교"></a>
            <img src="./img/main_latest2_img.jpg" alt="사진">
            <table>
                <% for(int i=5; i<10; i++) { %>
                <tr>
                    <td>></td>
                    <td><a href="/Farmstory1/board/view.jsp?group=croptalk&cate=school&no=<%=latest.get(i).getNo()%>"><%=latest.get(i).getTitle() %></a></td>
                    <td><%=latest.get(i).getRdate() %></td>
                </tr>
                <% } %>
            </table>
        </div><div>
            <a href=""><img src="./img/main_latest3_tit.png" alt="농작물이야기"></a>
            <img src="./img/main_latest3_img.jpg" alt="사진">
            <table>
                <% for(int i=10; i<15; i++) { %>
                <tr>
                    <td>></td>
                    <td><a href="/Farmstory1/board/view.jsp?group=croptalk&cate=story&no=<%=latest.get(i).getNo()%>"><%=latest.get(i).getTitle() %></a></td>
                    <td><%=latest.get(i).getRdate() %></td>
                </tr>
                <% } %>
            </table>
        </div>
    </div>
    <div class="info">
        <div class="cs">
            <img src="./img/main_sub2_cs_tit.png" alt="고객센터안내">
            <img src="./img/main_sub2_cs_img.png" alt="전화번호">
            <img src="./img/main_sub2_cs_txt.png" alt="1666-777">
            <p>
                평일: AM 09:00 ~ PM 06:00<br/>
                점심: PM 12:00 ~ PM 01:00<br/>
                토, 일요일, 공휴일 휴무
            </p>
            <a href="/Farmstory1/board/list.jsp?group=community&cate=community4"><img src="./img/main_sub2_cs_bt1.png" alt="1:1고객문의"></a>
            <a href="/Farmstory1/board/list.jsp?group=community&cate=community5"><img src="./img/main_sub2_cs_bt2.png" alt="자주묻는질문"></a>
            <a href="/Farmstory1/?ErrCode=102"><img src="./img/main_sub2_cs_bt3.png" alt="배송조회"></a>
        </div>
        <div class="account">
            <img src="./img/main_sub2_account_tit.png" alt="계좌안내">
            <p>
                기업은행 123-456789-01-01-012<br/>
                국민은행 01-1234-56789<br/>
                우리은행 123-456789-01-01-012<br/>
                하나은행 123-456789-01-01<br/>
                예 금 주 (주)팜스토리
            </p>
        </div>
        <div class="tabs">
            <ul class="tab">
                <li class="tab-link current" data-tab="tab-1">공지사항</li>
                <li class="tab-link" data-tab="tab-2">1:1 고객문의</li>
                <li class="tab-link" data-tab="tab-3">자주묻는질문</li>
            </ul>
            <div id="tab-1" class="tab-content current">
            	<ul class="txt">
            	</ul>
            </div>
            <div id="tab-2" class="tab-content">
            	<ul class="txt">
            	</ul>
            </div>
            <div id="tab-3" class="tab-content">
            	<ul class="txt">
            	</ul>
            </div>
        </div>
    </div>
</main>
<%@ include file="./_footer.jsp" %>