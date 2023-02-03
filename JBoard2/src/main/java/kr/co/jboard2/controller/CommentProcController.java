package kr.co.jboard2.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import kr.co.jboard2.dao.ArticleDAO;


@WebServlet("/commentProc.do")
public class CommentProcController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		String parent = req.getParameter("parent");
		
		ArticleDAO dao = ArticleDAO.getInstance();
		int result = dao.deleteComment(no, parent);
		dao.updateCommentHitDown(no);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		
		resp.setContentType("application/json;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String content = req.getParameter("content");
		String no = req.getParameter("no");
		
		int result = ArticleDAO.getInstance().updateComment(content, no);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		
		resp.setContentType("application/json;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
