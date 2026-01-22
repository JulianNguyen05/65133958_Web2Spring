package julian.viDuServlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/viDuDoPost")
public class viDuDoPost extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public viDuDoPost() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String hoDem = request.getParameter("ho");
		String ten = request.getParameter("ten");

		String hoTenDayDu = "";
		if (hoDem != null && ten != null) {
			hoTenDayDu = hoDem + " " + ten;
		}

		PrintWriter out = response.getWriter();

		out.println("<!DOCTYPE html>");
		out.println("<html><head><title>Kết quả</title></head><body>");
		out.println("<h2>Kết quả nhận được từ doPost:</h2>");
		out.println("<p>Họ đệm: <b>" + hoDem + "</b></p>");
		out.println("<p>Tên: <b>" + ten + "</b></p>");
		out.println("<h3 style='color:blue'>Xin chào, " + hoTenDayDu + "!</h3>");
		out.println("</body></html>");
	}

}
