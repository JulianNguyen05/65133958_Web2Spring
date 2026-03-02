package toeic.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.ResultDAO;
import toeic.model.User;

@WebServlet("/save-result")
public class SaveResultServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("sessionUser");
		if (user == null)
			return; // Chưa đăng nhập thì không lưu

		try {
			int examId = Integer.parseInt(request.getParameter("examId"));
			int score = Integer.parseInt(request.getParameter("score"));
			int timeSpent = Integer.parseInt(request.getParameter("timeSpent"));

			ResultDAO dao = new ResultDAO();
			dao.saveResult(user.getUserId(), examId, score, timeSpent);

			response.setStatus(HttpServletResponse.SC_OK); // Trả về mã 200 (Thành công)
		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}