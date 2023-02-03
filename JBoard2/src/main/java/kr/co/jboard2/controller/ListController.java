package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticleVO;
import service.ArticleService;

@WebServlet("/list.do")
public class ListController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//검색어
		String search = req.getParameter("search");
		req.setAttribute("search", search);
		
		//현재 페이지 값
		String pg= req.getParameter("pg");
		
		int currentPage = 1;
		if(pg != null) {
			currentPage = Integer.parseInt(pg);
		}
		
		//단계 1 : 전체 게시물 갯수
		int total = 0;
		if(search == null) {
			total = service.selectCountTotal();
		}else {
			total = service.selectCountTotal(search);
		}
		
		//단계 2 : 게시물 그룹
		int currentPageGroup = (int)Math.ceil(currentPage / 10.0);
		int pageGroupStart = (currentPageGroup -1) * 10 + 1; //시작번호
		int pageGroupEnd= currentPageGroup * 10; //끝번호
		
		//단계 3 : 마지막 페이지 번호
		int lastPageNum = 0;
		if(total % 10 == 0) {
			lastPageNum = total / 10;
		}else {
			//게시물이 1자리수가 남는다면 + 1페이지
			lastPageNum = total / 10 + 1;
		}
		if(pageGroupEnd > lastPageNum) {
			//마지막 페이지가 15인데 그룹이 20까지 나오는 경우
			pageGroupEnd = lastPageNum;
		}
		
		//게시물리스트
		int pageStart = 0;
		pageStart = (currentPage - 1) * 10;
		
		List<ArticleVO> articles = null;
		if(search == null) {
			articles = service.selectArticles(pageStart);
		}else {
			articles = service.selectArticleByKeyWord(search, pageStart);
		}
		
		req.setAttribute("pageGroupStart", pageGroupStart);
		req.setAttribute("pageGroupEnd", pageGroupEnd);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("lastPageNum", lastPageNum);
		req.setAttribute("articles", articles);
		req.setAttribute("total", total);
		req.setAttribute("pageStart", pageStart);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/list.jsp");
		dispatcher.forward(req, resp);
	}
}
