package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.UserDAO;

@WebServlet("/admin/edit-user")
public class EditUserServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int userId = Integer.parseInt(request.getParameter("userId"));
		String fullName = request.getParameter("fullName");
		String role = request.getParameter("role");

		UserDAO dao = new UserDAO();
		if (dao.updateUser(userId, fullName, role)) {
			request.getSession().setAttribute("message", "Cập nhật User thành công!");
			request.getSession().setAttribute("msgType", "success");
		} else {
			request.getSession().setAttribute("message", "Cập nhật thất bại!");
			request.getSession().setAttribute("msgType", "danger");
		}
		response.sendRedirect(request.getContextPath() + "/admin/home#user");
	}
}