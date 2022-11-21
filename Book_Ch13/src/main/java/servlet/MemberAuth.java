package servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.MemberDAO;
import DBCP.DBConnPool;
import DTO.MemberDTO;

public class MemberAuth extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String admin_id = this.getInitParameter("admin_id");
		
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		MemberDAO dao = new MemberDAO();
		MemberDTO dto =  dao.getMemberDTO(id, pass);
		String memberName = dto.getName();
		
		if(dto.getName() != null) {
			req.setAttribute("authMessage", memberName + "님 반갑습니다.");
		}else {
			if(admin_id.equals(id)) {
				req.setAttribute("authMessage", admin_id + "는 최고 관리자입니다.");
			}else {
				req.setAttribute("authMessage", "회원이 존재하지 않습니다.");
			}
		}
		req.getRequestDispatcher("/MemberAuth.jsp").forward(req, resp);
	}
	
}
