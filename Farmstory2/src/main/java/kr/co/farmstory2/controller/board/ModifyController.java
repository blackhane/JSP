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
		
		ArticleDAO dao = ArticleDAO.getInstance();
		//제목, 내용 수정
		dao.updateArticle(no, title, content);
		
		String fname = mr.getFilesystemName("file");
		
		if(fname != null) {
			
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
		
		resp.sendRedirect("/Farmstory2/board/view.do?group="+group+"&cate="+cate+"&pg="+pg+"&no="+no+"&Code=104");
		
	}
}