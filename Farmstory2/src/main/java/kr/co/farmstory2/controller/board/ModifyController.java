package kr.co.farmstory2.controller.board;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/modify.do")
public class ModifyController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String pg = req.getParameter("pg");
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		req.setAttribute("pg", pg);
		String no = req.getParameter("no");
		
		ArticleVO vo = ArticleDAO.getInstance().selectArticle(no);
		req.setAttribute("vo", vo);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/modify.jsp");
		dispatcher.forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//데이터 수신
		String savePath = req.getRealPath("/file");
		int maxSize = 1024 * 1024 * 10;
		MultipartRequest mr = new MultipartRequest(req, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		String group = mr.getParameter("group");
		String cate = mr.getParameter("cate");
		String pg = mr.getParameter("pg");
		
		String title = mr.getParameter("title");
		String content= mr.getParameter("content");
		String no = mr.getParameter("no");
		
		String fname = mr.getFilesystemName("file");
		
		//기존파일 삭제 처리 로직 추가//
		//기존파일 삭제 처리 로직 추가//
		
		ArticleDAO dao = ArticleDAO.getInstance();
		int parent = dao.updateArticle(no, title, content, fname);
		
		//파일처리
		if(fname != null){
			int idx = fname.lastIndexOf(".");
			String ext = fname.substring(idx);
			String now = new SimpleDateFormat("yyyyMMddHHmmss_").format(new Date());
			String newFname = now+ext;
			
			File oriFile = new File(savePath+"/"+fname);
			File newFile = new File(savePath+"/"+newFname);
			
			oriFile.renameTo(newFile);
			
			dao.insertFile(parent, fname, newFname);
		}
		
		resp.sendRedirect("/Farmstory2/board/view.do?group="+group+"&cate="+cate+"&pg="+pg+"&no="+no);
		
	}
}