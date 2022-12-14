package kr.co.farmstory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;

import kr.co.farmstory2.dao.UserDAO;
import kr.co.farmstory2.vo.UserVO;

@WebServlet("/board/user/findId.do")
public class FindId extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/user/findId.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		
		UserVO user = UserDAO.getInstance().selectFindId(name,email);
		
		JsonObject json = new JsonObject();
		
		if(user != null) {
			json.addProperty("result", 1);
			HttpSession session = req.getSession();
			session.setAttribute("findUser", user);
		}else {
			json.addProperty("result", 0);
		}
		
		resp.setContentType("application/json;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
