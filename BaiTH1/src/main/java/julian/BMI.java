package julian;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BMI")
public class BMI extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/html/bmi.html").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			double height = Double.parseDouble(request.getParameter("height"));
			double weight = Double.parseDouble(request.getParameter("weight"));

			double bmi = weight / Math.pow(height / 100, 2);
			String bmiFormatted = String.format("%.1f", bmi);

			String statusText = "";
			String statusClass = "";
			String advice = "";

			if (bmi < 18.5) {
				statusText = "Hơi gầy";
				statusClass = "status-thin";
				advice = "Bạn cần bổ sung thêm dinh dưỡng và tập luyện để tăng cân khoa học nhé.";
			} else if (bmi < 24.9) {
				statusText = "Cân đối";
				statusClass = "status-normal";
				advice = "Tuyệt vời! Hãy duy trì chế độ ăn uống và sinh hoạt hiện tại.";
			} else if (bmi < 29.9) {
				statusText = "Thừa cân";
				statusClass = "status-fat";
				advice = "Bạn nên hạn chế đồ ngọt, dầu mỡ và tăng cường vận động.";
			} else {
				statusText = "Béo phì";
				statusClass = "status-obese";
				advice = "Cảnh báo sức khỏe! Bạn nên tham khảo ý kiến bác sĩ để có lộ trình giảm cân.";
			}

			// Đóng gói dữ liệu gửi sang JSP
			request.setAttribute("bmi", bmiFormatted);
			request.setAttribute("statusText", statusText);
			request.setAttribute("statusClass", statusClass);
			request.setAttribute("advice", advice);

			// Chuyển hướng sang trang kết quả
			request.getRequestDispatcher("/bmi-result.jsp").forward(request, response);

		} catch (Exception e) {
			response.sendRedirect("html/bmi.html");
		}
	}
}
