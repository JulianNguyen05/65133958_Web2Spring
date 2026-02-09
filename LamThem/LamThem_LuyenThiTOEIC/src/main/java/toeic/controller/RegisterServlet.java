package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.UserDAO;
import toeic.model.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fullName = request.getParameter("fullName");
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if ("admin".equalsIgnoreCase(username)) {
			response.sendRedirect("register.jsp?error=admin");
			return;
		}

		User newUser = new User(username, password, fullName, "USER");
		boolean isSuccess = UserDAO.register(newUser);

		if (isSuccess) {
			response.sendRedirect("login.jsp?registerSuccess=true");
		} else {
			response.sendRedirect("register.jsp?error=failed");
		}
	}
}