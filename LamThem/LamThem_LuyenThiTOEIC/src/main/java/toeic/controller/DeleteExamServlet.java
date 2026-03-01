package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.ExamDAO;

@WebServlet("/admin/delete-exam")
public class DeleteExamServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String idStr = request.getParameter("id");
		if (idStr != null) {
			int id = Integer.parseInt(idStr);
			ExamDAO dao = new ExamDAO();

			if (dao.deleteExam(id)) {
				request.getSession().setAttribute("message", "Đã xóa đề thi thành công!");
				request.getSession().setAttribute("msgType", "success");
			} else {
				request.getSession().setAttribute("message", "Xóa thất bại!");
				request.getSession().setAttribute("msgType", "danger");
			}
		}
		// Xóa xong phải quay lại Servlet admin/home để nó load lại danh sách mới nhất
		response.sendRedirect(request.getContextPath() + "/admin/home");
	}
}