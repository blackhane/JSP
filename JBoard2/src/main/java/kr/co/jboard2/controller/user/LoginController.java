package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.Session;

import kr.co.jboard2.dao.UserDAO;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/login.do")
public class LoginController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/user/login.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		String auto = req.getParameter("auto");
		
		UserDAO dao = UserDAO.getInstance();
		UserVO user = dao.selectUser(uid, pass);
		
		if(user == null) {
			//회원 X
			RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/user/login.jsp?code=101");
			dispatcher.forward(req, resp);
		}else {
			//회원 O
			HttpSession session = req.getSession(true);
			session.setAttribute("sessUser", user);
			
			//자동로그인 
			if(auto != null) {
				String sessId = session.getId();
				
				//쿠키생성
				Cookie cookie = new Cookie("SESSID", sessId);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*3);
				resp.addCookie(cookie);
				
				//세션정보 데이터베이스 저장
				dao.updateUserForSession(uid, sessId);
			}
			
			resp.sendRedirect("/JBoard2/list.do");
		}
	}
}
