package kr.co.farmstory2.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.farmstory2.dao.ArticleDAO;

@WebServlet("/board/delete.do")
public class DeleteController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String group = (String) session.getAttribute("group");
		String cate = (String) session.getAttribute("cate");
		
		String no = req.getParameter("no");
		
		ArticleDAO.getInstance().deleteArticle(no);
		
		resp.sendRedirect("/Farmstory2/board/list.do?group=" + group + "&cate=" + cate);
	}
}
