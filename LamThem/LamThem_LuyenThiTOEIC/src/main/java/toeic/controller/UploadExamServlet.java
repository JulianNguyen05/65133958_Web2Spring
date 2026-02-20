package toeic.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import toeic.dao.ExamDAO;

@WebServlet("/admin/upload-exam")
// BẮT BUỘC PHẢI CÓ DÒNG NÀY ĐỂ UPLOAD FILE
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UploadExamServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String title = request.getParameter("title");
		String description = request.getParameter("description");

		Part filePart = request.getPart("examFile");
		String fileName = filePart.getSubmittedFileName();

		String uploadPath = getServletContext().getRealPath("/assets");
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		try {
			filePart.write(uploadPath + File.separator + fileName);

			ExamDAO dao = new ExamDAO();
			boolean isInserted = dao.insertExam(title, description, fileName);

			if (isInserted) {
				request.setAttribute("message", "Thêm đề thi thành công!");
				request.setAttribute("msgType", "success");
			} else {
				request.setAttribute("message", "Lỗi khi lưu vào Database.");
				request.setAttribute("msgType", "danger");
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("message", "Lỗi khi upload file: " + e.getMessage());
			request.setAttribute("msgType", "danger");
		}

		request.getRequestDispatcher("/admin/home.jsp").forward(request, response);
	}
}