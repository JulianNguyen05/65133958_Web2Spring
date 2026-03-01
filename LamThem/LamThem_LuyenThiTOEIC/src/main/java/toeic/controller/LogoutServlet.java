package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Lấy session hiện tại (false nghĩa là nếu không có thì không tạo mới)
		HttpSession session = request.getSession(false);

		// Nếu session tồn tại, xóa bỏ toàn bộ dữ liệu (invalidate)
		if (session != null) {
			session.invalidate();
		}

		// Chuyển hướng về trang đăng nhập
		response.sendRedirect("login.jsp");
	}
}