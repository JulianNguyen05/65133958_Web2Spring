package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.ExamDAO;

@WebServlet("/admin/edit-exam")
public class EditExamServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8"); // Để gõ tiếng Việt có dấu

		int examId = Integer.parseInt(request.getParameter("examId"));
		String title = request.getParameter("title");
		String description = request.getParameter("description");

		ExamDAO dao = new ExamDAO();
		if (dao.updateExam(examId, title, description)) {
			request.getSession().setAttribute("message", "Cập nhật thông tin thành công!");
			request.getSession().setAttribute("msgType", "success");
		} else {
			request.getSession().setAttribute("message", "Cập nhật thất bại!");
			request.getSession().setAttribute("msgType", "danger");
		}

		response.sendRedirect(request.getContextPath() + "/admin/home");
	}
}