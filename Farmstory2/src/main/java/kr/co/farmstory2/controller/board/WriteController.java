package kr.co.farmstory2.controller.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.UserVO;

@WebServlet("/board/write.do")
public class WriteController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/write.jsp");
		dispatcher.forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String group = (String) session.getAttribute("group");
		String cate = (String) session.getAttribute("cate");
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String uid = req.getParameter("uid");
		String regip = req.getRemoteAddr();
		
		//파일의 유무 체크
		String fname = null;
		
		ArticleVO vo = new ArticleVO();
		vo.setTitle(title);
		vo.setContent(content);
		vo.setUid(uid);
		vo.setRegip(regip);
		vo.setFname(fname);
		vo.setCate(cate);
		
		ArticleDAO dao = ArticleDAO.getInstance();
		
		//파일 저장용 부모 번호
		int parent = dao.insertArticle(vo);
		
		resp.sendRedirect("/Farmstory2/board/list.do?group=" +group+ "&cate=" +cate);
	}
}