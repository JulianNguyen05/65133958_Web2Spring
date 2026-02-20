package toeic.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/do-exam")
public class DoExamServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String fileName = request.getParameter("file");

		String realPath = getServletContext().getRealPath("/assets/" + fileName);

		File file = new File(realPath);
		if (file.exists()) {
			String jsonContent = new String(Files.readAllBytes(file.toPath()), StandardCharsets.UTF_8);
			request.setAttribute("examData", jsonContent);
			request.setAttribute("examTitle", fileName);
		} else {
			request.setAttribute("error", "File đề thi không tồn tại!");
		}

		request.getRequestDispatcher("do-exam.jsp").forward(request, response);
	}
}