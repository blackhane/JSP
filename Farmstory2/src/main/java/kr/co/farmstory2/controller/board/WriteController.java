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
import kr.co.farmstory2.vo.UserVO;

@WebServlet("/board/write.do")
public class WriteController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Override
	public void init() throws ServletException {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/write.jsp");
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
		
		String title = mr.getParameter("title");
		String content= mr.getParameter("content");
		String uid = mr.getParameter("uid");
		String regip = req.getRemoteAddr();

		String fname = mr.getFilesystemName("file");
		
		ArticleVO vo = new ArticleVO();
		vo.setTitle(title);
		vo.setContent(content);
		vo.setFname(fname);
		vo.setUid(uid);
		vo.setRegip(regip);
		vo.setCate(cate);
		
		ArticleDAO dao = ArticleDAO.getInstance();
		int parent = dao.insertArticle(vo);
		
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
		
		resp.sendRedirect("/Farmstory2/board/list.do?group=" +group+ "&cate=" +cate);
	}
}