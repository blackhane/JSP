package kr.co.farmstory2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/index.do")
public class IndexController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ArticleDAO dao = ArticleDAO.getInstance();
		
		//카테고리
		String cate1 = "grow";
		String cate2 = "school";
		String cate3 = "story";
		String cate4 = "notice";
		String cate5 = "qna";
		String cate6 = "faq";
		//최근 게시물 (농작물이야기)
		List<ArticleVO> articles1 = dao.selectLatest(cate1);
		List<ArticleVO> articles2 = dao.selectLatest(cate2);
		List<ArticleVO> articles3 = dao.selectLatest(cate3);
		//최근 게시물 (커뮤니티)
		List<ArticleVO> articles4 = dao.selectLatest2(cate4);
		List<ArticleVO> articles5 = dao.selectLatest2(cate5);
		List<ArticleVO> articles6 = dao.selectLatest2(cate6);
		
		req.setAttribute("articles1", articles1);
		req.setAttribute("articles2", articles2);
		req.setAttribute("articles3", articles3);
		req.setAttribute("articles4", articles4);
		req.setAttribute("articles5", articles5);
		req.setAttribute("articles6", articles6);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/index.jsp");
		dispatcher.forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	
}
