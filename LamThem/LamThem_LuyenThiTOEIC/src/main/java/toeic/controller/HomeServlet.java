package toeic.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.ExamDAO;
import toeic.model.Exam;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ExamDAO dao = new ExamDAO();
		List<Exam> list = dao.getAllExams();

		request.setAttribute("listExams", list);

		request.getRequestDispatcher("home.jsp").forward(request, response);
	}
}
