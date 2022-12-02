package kr.co.farmstory2.controller.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.farmstory2.dao.UserDAO;

@WebServlet("/board/user/checkUid.do")
public class CheckUid extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");
		
		int result = UserDAO.getInstance().selectCountUid(uid);
		
		JsonObject json = new JsonObject();
		json.addProperty("reulst", result);
		
		resp.setContentType("application/json;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
