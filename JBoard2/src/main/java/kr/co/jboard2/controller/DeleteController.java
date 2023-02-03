package kr.co.jboard2.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.dao.ArticleDAO;

@WebServlet("/delete.do")
public class DeleteController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {	
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		String pg = req.getParameter("pg");
		req.setAttribute("pg", pg);
		
		ArticleDAO dao = ArticleDAO.getInstance();
		dao.deleteArticle(no);
		String fileName = dao.deleteFile(no);
		
		//파일 디렉토리에서 삭제
		if(fileName != null){
			String path = req.getRealPath("/file");
			File file = new File(path,fileName);
			if(file.exists()){
				file.delete();	
			}
		}
		
		resp.sendRedirect("/JBoard2/list.do?pg="+pg+"&Code=105");
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	}
}
