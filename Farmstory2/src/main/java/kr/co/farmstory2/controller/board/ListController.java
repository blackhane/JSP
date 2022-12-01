package kr.co.farmstory2.controller.board;

import java.io.IOException;
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
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		
		HttpSession session = req.getSession();
		session.setAttribute("group", group);
		session.setAttribute("cate", cate);
		
		ArticleDAO dao = ArticleDAO.getInstance();
		
		//페이징 작업
		int start = 0;
		int total = 0; //총 게시물 개수
		int lastPageNum = 0; //마지막 페이지 번호
		int currentPage = 1; //현재 페이지
		int currentPageGroup = 1; //현재 페이지 그룹
		int pageGroupStart = 0; //그룹 시작번호
		int pageGroupEnd = 0; //그룹 마지막 번호
		int pageStartNum = 0; //페이지 시작 번호
		
		
		
		//현재 페이지 그룹 (ex: 1~10, 11~20, 21~30...)
		currentPageGroup = (int)Math.ceil(currentPage / 10.0);
		pageGroupStart = (currentPageGroup-1) * 10 + 1;//시작번호
		pageGroupEnd = currentPageGroup * 10;//끝번호
		//전체 게시물 개수
		total = dao.selectCountTotal(cate);
		//마지막 페이지 번호
		if(total % 10 == 0) {
			lastPageNum = total / 10;
		}else {
			lastPageNum = total / 10 + 1;
		}
		//페이지 그룹 번호가 마지막 페이지 번호보다 많으면...
		if(pageGroupEnd > lastPageNum) {
			pageGroupEnd = lastPageNum;
		}
		
		
		//게시글 번호
		pageStartNum = total - start;
		req.setAttribute("pageStartNum", pageStartNum);
		
		//현재 페이지 번호
		String pg = req.getParameter("pg");
		if(pg != null) {
			currentPage = Integer.parseInt(pg);
		}
		//현재 페이지의 리스트 idx (ex:1페이지 : 0~10 2페이지 : 10~20...)
		start = (currentPage - 1) * 10;
		
		List<ArticleVO> vo = dao.selectArticles(cate, start);
		req.setAttribute("vo", vo);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/list.jsp");
		dispatcher.forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
