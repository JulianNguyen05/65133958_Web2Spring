package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import toeic.dao.UserDAO;
import toeic.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String user = request.getParameter("username");
		String pass = request.getParameter("password");

		User userObj = UserDAO.checkLogin(user, pass);

		if (userObj != null) {
			HttpSession session = request.getSession();
			session.setAttribute("sessionUser", userObj);

			if ("ADMIN".equals(userObj.getRole())) {
				response.sendRedirect("admin_dashboard.jsp");
			} else {
				response.sendRedirect("home.jsp");
			}
		} else {
			response.sendRedirect("login.jsp?error=invalid");
		}
	}
}