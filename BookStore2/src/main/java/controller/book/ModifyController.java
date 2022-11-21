package controller.book;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDAO;
import vo.BookVO;

@WebServlet("/book/modify.do")
public class ModifyController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String bookId = req.getParameter("bookId");
		BookVO vo = BookDAO.getInstance().selectBook(bookId);
		req.setAttribute("vo", vo);
		
		RequestDispatcher dispathcer = req.getRequestDispatcher("/book/modify.jsp");
		dispathcer.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String bookId = req.getParameter("bookId");
		String bookName = req.getParameter("bookName");
		String bookPublisher = req.getParameter("publisher");
		String bookPrice = req.getParameter("price");
		
		BookVO vo = new BookVO();
		vo.setBookId(bookId);
		vo.setBookName(bookName);;
		vo.setBookPublisher(bookPublisher);
		vo.setBookPrice(bookPrice);

		BookDAO.getInstance().updateBook(vo);
		
		resp.sendRedirect("/BookStore2/book/list.do");
	}
}
