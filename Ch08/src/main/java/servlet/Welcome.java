package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/welcome.do")
public class Welcome extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	//클라이언트의 요청을 응답하는 클래스
	
	@Override
	public void init() throws ServletException {
		//해당 서블릿이 실행될 때 한번 호출
		System.out.println("Welcome init...");
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//응답방식이 get일 때 호출
		System.out.println("Welcome doGet...");
		
		resp.setContentType("text/html;charset=UTF-8");
		
		PrintWriter writer = resp.getWriter();
		writer.println("<html>");
		writer.println("<head>");
		writer.println("<meta charset='UTF-8'>");		
		writer.println("<title>Welcome</title>");
		writer.println("</head>");
		writer.println("<body>");
		writer.println("<h3>Welcome 서블릿</h3>");
		writer.println("<p>");
		writer.println("<a href='/Ch08/1_서블릿.jsp'>1_서블릿</a><br>");
		writer.println("<a href='/Ch08/hello.do'>Hello 서블릿</a><br>");
		writer.println("<a href='/Ch08/welcome.do'>Welcome 서블릿</a><br>");
		writer.println("<a href='/Ch08/greeting.do'>Greeting 서블릿</a><br>");
		writer.println("</p>");
		writer.println("</body>");
		writer.println("</html>");
		writer.close();
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//응답방식이 post일 때 호출 
		System.out.println("Welcome doGet...");
	}
	@Override
	public void destroy() {
		//해당 서블릿이 종료될 때 한번 호출
		System.out.println("Welcome destory...");
	}
	
}
