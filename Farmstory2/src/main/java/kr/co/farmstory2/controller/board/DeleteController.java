package kr.co.farmstory2.controller.board;

import java.io.File;
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
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String pg = req.getParameter("pg");
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		req.setAttribute("pg", pg);
		
		String no = req.getParameter("no");
		
		ArticleDAO dao = ArticleDAO.getInstance();
		
		//게시글 삭제
		dao.deleteArticle(no);
		//파일 DB삭제 및 저장된 파일 이름 가져오기
		String fileName = dao.deleteFile(no);
		
		//파일 디렉토리에서 삭제
		if(fileName != null){
			String path = req.getRealPath("/file");
			File file = new File(path,fileName);
			if(file.exists()){
				file.delete();	
			}
		}
		
		resp.sendRedirect("/Farmstory2/board/list.do?group=" + group + "&cate=" + cate + "&pg=" +pg);
	}
}
