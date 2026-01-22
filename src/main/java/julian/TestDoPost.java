package julian;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/testDoPost")
public class TestDoPost extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public TestDoPost() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<form method='post' action='testDoPost'>");
		out.println("Nhập dữ liệu test: <input type='text' name='data'>");
		out.println("<input type='submit' value='Gửi POST'>");
		out.println("</form>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String data = request.getParameter("data");

		PrintWriter out = response.getWriter();
		out.println("<h2>Đây là kết quả của phương thức doPOST</h2>");
		out.println("<p>Dữ liệu nhận được: <b>" + data + "</b></p>");
	}

}
