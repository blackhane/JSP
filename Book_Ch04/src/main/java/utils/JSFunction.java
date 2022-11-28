package utils;

import javax.servlet.jsp.JspWriter;

public class JSFunction {

	//알림 후 url 이동
	public static void alertLocation(String msg, String url, JspWriter out) {
		try {
			String script = ""
					+ "<script>"
					+ " alert('"+msg+"');"
					+ " location.href='"+url+"';"
					+ "</script>";
			out.println(script);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//알림 후 이전 페이지
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = ""
					+ "<script>"
					+ "alert('"+msg+"');"
					+ "history.back();"
					+ "</script>";
			out.println(script);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
