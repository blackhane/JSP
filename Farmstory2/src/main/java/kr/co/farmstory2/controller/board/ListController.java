package kr.co.farmstory2.controller.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.jasper.tagplugins.jstl.core.Out;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/list.do")
public class ListController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String search = req.getParameter("search");
		
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);		
		req.setAttribute("search", search);		
		
		ArticleDAO dao = ArticleDAO.getInstance();
		
		//변수
		int start = 0;
		int total = 0;
		int lastPageNum = 0;
		int currentPage = 1;
		int currentPageGroup = 1;
		int pageGroupStart = 0;
		int pageGroupEnd = 0;
		int pageStartNum = 0;
		
		//현재 페이지 번호
		String pg = req.getParameter("pg");
		if(pg != null){
			currentPage = Integer.parseInt(pg);
		}
		
		//현재 페이지 그룹 (ex: 1~10 11~20 21~30)
		currentPageGroup = (int)Math.ceil(currentPage / 10.0);
		pageGroupStart = (currentPageGroup -1) * 10 + 1; //시작번호
		pageGroupEnd= currentPageGroup * 10; //끝번호
		
		//전체 게시물 갯수
		if(search == null) {
			total = dao.selectCountTotal(cate);
		}else {
			total = dao.selectCountTotal(cate, search);
		}
		
		//마지막 페이지 번호
		if(total % 10 == 0){
			lastPageNum = total / 10;
		}else{
			lastPageNum = total / 10 +1;
		}
		if(pageGroupEnd > lastPageNum){
			pageGroupEnd = lastPageNum;
		}
		
		//글 번호 인덱스 (ex:1페이지=0부터, 2페이지=10부터)
		start = (currentPage - 1) * 10;
		
		List<ArticleVO> vo = new ArrayList<>();
		
		if(search == null) {
			vo = dao.selectArticles(cate, start);
		}else {
			vo = dao.selectArticleByKeyWord(cate, start, search);
		}
		req.setAttribute("vo", vo);
		req.setAttribute("pageGroupStart", pageGroupStart);
		req.setAttribute("pageGroupEnd", pageGroupEnd);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("lastPageNum", lastPageNum);
		req.setAttribute("total", total);
		req.setAttribute("start", start);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/list.jsp");
		dispatcher.forward(req, resp);		
	}
}
