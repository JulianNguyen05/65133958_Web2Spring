package toeic.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import toeic.dao.ResultDAO;
import toeic.model.Result;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String idStr = request.getParameter("id");
		if (idStr != null) {
			int examId = Integer.parseInt(idStr);
			ResultDAO dao = new ResultDAO();
			List<Result> topUsers = dao.getTopResults(examId);
			request.setAttribute("leaderboard", topUsers);
		}
		request.getRequestDispatcher("leaderboard.jsp").forward(request, response);
	}
}