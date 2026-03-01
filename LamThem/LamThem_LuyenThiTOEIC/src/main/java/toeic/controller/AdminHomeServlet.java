package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.ExamDAO;
import toeic.dao.UserDAO;

@WebServlet("/admin/home")
public class AdminHomeServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Lấy danh sách đề thi
		ExamDAO examDao = new ExamDAO();
		request.setAttribute("listExams", examDao.getAllExams());

		// Lấy danh sách user
		UserDAO userDao = new UserDAO();
		request.setAttribute("listUsers", userDao.getAllUsers());

		request.getRequestDispatcher("/admin/home.jsp").forward(request, response);
	}
}