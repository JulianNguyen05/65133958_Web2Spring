package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.UserDAO;

@WebServlet("/admin/add-user")
public class AddUserServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String fullName = request.getParameter("fullName");
		String role = request.getParameter("role");

		UserDAO dao = new UserDAO();
		if (dao.insertUser(username, password, fullName, role)) {
			request.getSession().setAttribute("message", "Thêm User thành công!");
			request.getSession().setAttribute("msgType", "success");
		} else {
			request.getSession().setAttribute("message", "Thêm thất bại (Có thể do Username bị trùng)!");
			request.getSession().setAttribute("msgType", "danger");
		}
		// Redirect về trang chủ Admin kèm mỏ neo #user để hiển thị đúng Tab User
		response.sendRedirect(request.getContextPath() + "/admin/home#user");
	}
}