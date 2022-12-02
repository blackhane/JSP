package kr.co.farmstory2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.farmstory2.dao.UserDAO;
import kr.co.farmstory2.db.CookieManager;
import kr.co.farmstory2.vo.UserVO;

@WebServlet("/board/user/login.do")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		session.removeAttribute("findUser");
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/user/login.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		String saveUid = req.getParameter("saveUid");
	
		UserVO vo = UserDAO.getInstance().selectUser(uid, pass);
		
		if(vo != null) {
			
			if(saveUid != null && saveUid.equals("Y")) {
				CookieManager.makeCookie(resp, "loginId", uid, 60*60*24);
			}else {
				CookieManager.deleteCookie(resp, "loginId");
			}
			
			HttpSession session = req.getSession();
			session.setAttribute("sessUser", vo);
			
			resp.sendRedirect("/Farmstory2/");
			
		} else {
			
			RequestDispatcher dispatcher = req.getRequestDispatcher("/board/user/login.jsp?Code=100");
			dispatcher.forward(req, resp);
			
		}
	}
}
