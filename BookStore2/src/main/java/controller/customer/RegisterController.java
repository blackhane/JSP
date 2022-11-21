package controller.customer;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BookDAO;
import dao.CustomerDAO;
import vo.BookVO;
import vo.CustomerVO;

@WebServlet("/customer/register.do")
public class RegisterController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispathcer = req.getRequestDispatcher("/customer/register.jsp");
		dispathcer.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name = req.getParameter("name");
		String address = req.getParameter("address");
		String phone = req.getParameter("phone");
		
		CustomerVO vo = new CustomerVO();
		vo.setName(name);
		vo.setAddress(address);
		vo.setPhone(phone);

		CustomerDAO.getInstance().insertCustomer(vo);
		
		resp.sendRedirect("/BookStore2/customer/list.do");
	}
}
