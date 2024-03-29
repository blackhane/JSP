package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.dao.UserDAO;

@WebServlet("/user/logout.do")
public class LogoutController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");		
		
		HttpSession session = req.getSession();
		
		//세션제거
		//session.invalidate();
		session.removeAttribute("sessUser");
		
		//쿠키제거
//		Cookie[] cookies = req.getCookies();
//		
//		if(cookies != null) {
//			for(Cookie cookie : cookies) {
//				if(cookie.getName().equals("SESSID")) {
//					cookie.setPath("/");
//					cookie.setMaxAge(0);
//					resp.addCookie(cookie);
//				}
//			}
//		}
		Cookie cookie = new Cookie("SESSID", null);
		cookie.setPath("/");
		cookie.setMaxAge(0);
		resp.addCookie(cookie);
		
		//데이터베이스 쿠키제거
		UserDAO.getInstance().updateUserSessionOut(uid);
		
		resp.sendRedirect("/JBoard2/user/login.do?Code=102");
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
	
}
