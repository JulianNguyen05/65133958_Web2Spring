package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.UserDAO;

@WebServlet("/admin/delete-user")
public class DeleteUserServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		UserDAO dao = new UserDAO();
		if (dao.deleteUser(id)) {
			request.getSession().setAttribute("message", "Đã xóa User!");
			request.getSession().setAttribute("msgType", "success");
		} else {
			request.getSession().setAttribute("message", "Xóa thất bại!");
			request.getSession().setAttribute("msgType", "danger");
		}
		response.sendRedirect(request.getContextPath() + "/admin/home#user");
	}
}