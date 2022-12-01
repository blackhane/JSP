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
		//최근 게시물 (농작물이야기)
		List<ArticleVO> articles = dao.selectLatest();
		//최근 게시물 (커뮤니티)
		List<ArticleVO> articles2 = dao.selectLatest2();
		
		if(articles.size() < 15){
			ArticleVO article = new ArticleVO();
			article.setNo(0);
			article.setTitle("제목");
			article.setRdate("작성일");
			
			for(int i=0; i<15; i++){
				articles.add(article);
			}
		}
		if(articles2.size() < 9){
			ArticleVO article = new ArticleVO();
			article.setNo(0);
			article.setTitle("제목");
			article.setRdate("작성일");
			
			for(int i=0; i<9; i++){
				articles.add(article);
			}
		}
		
		req.setAttribute("articles1", articles.subList(0, 5));
		req.setAttribute("articles2", articles.subList(5, 10));
		req.setAttribute("articles3", articles.subList(10, 15));
		req.setAttribute("articles4", articles2.subList(0, 3));
		req.setAttribute("articles5", articles2.subList(3, 6));
		req.setAttribute("articles6", articles2.subList(6, 9));
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/index.jsp");
		dispatcher.forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
	
}
