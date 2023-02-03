package kr.co.jboard2.controller;

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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/modify.do")
public class ModifyController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		String pg = req.getParameter("pg");
		req.setAttribute("no", no);
		req.setAttribute("pg", pg);
		
		ArticleVO vo = ArticleDAO.getInstance().selectArticle(no);
		
		req.setAttribute("article", vo);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/modify.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//데이터 수신
		String savePath = req.getRealPath("/file");
		int maxSize = 1024 * 1024 * 10;
		MultipartRequest mr = new MultipartRequest(req, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		String pg = mr.getParameter("pg");
		
		String title = mr.getParameter("title");
		String content= mr.getParameter("content");
		String no = mr.getParameter("no");
		
		ArticleDAO dao = ArticleDAO.getInstance();
		//제목, 내용 수정
		dao.updateArticle(no, title, content);
		
		String fname = mr.getFilesystemName("file");
		
		if(fname != null) {
			dao.updateArticleFile(no);
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
			
			//새로운 파일
			if(fname != null){
				int idx = fname.lastIndexOf(".");
				String ext = fname.substring(idx);
				String now = new SimpleDateFormat("yyyyMMddHHmmss_").format(new Date());
				String newFname = now+ext;
				
				File oriFile = new File(savePath+"/"+fname);
				File newFile = new File(savePath+"/"+newFname);
				
				oriFile.renameTo(newFile);
				String parent = mr.getParameter("no");
				dao.insertFile(parent, fname, newFname);
			}
		}
		
		resp.sendRedirect("/JBoard2/view.do?pg="+pg+"&no="+no+"&Code=104");
	}
}
