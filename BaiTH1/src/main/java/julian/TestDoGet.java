package julian;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/TestDoGet")
public class TestDoGet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String st = "";
		st += "<h2>Đây là kết quả của phương thức doGET</h2>";
		st += "<p>Yêu cầu đã được xử lý thành công tại URL: /testDoGet</p>";

		PrintWriter out = response.getWriter();
		out.println(st);
	}
}
