package julian;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BMI")
public class BMI extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BMI() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.println("<!DOCTYPE html>");
		out.println("<html><head><title>Tính BMI</title>");
		out.println("<style>");
		out.println("body { font-family: sans-serif; padding: 50px; text-align: center; }");
		out.println(
				"form { display: inline-block; border: 1px solid #ccc; padding: 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); }");
		out.println("input { display: block; margin: 10px auto; padding: 8px; width: 200px; }");
		out.println(
				"button { background: #28a745; color: white; padding: 10px 20px; border: none; cursor: pointer; border-radius: 5px;}");
		out.println("</style></head><body>");

		out.println("<h2>Công cụ tính BMI</h2>");

		out.println("<form action='BMI' method='post'>");
		out.println("<label>Chiều cao (cm):</label>");
		out.println("<input type='number' name='height' required placeholder='VD: 170'>");
		out.println("<label>Cân nặng (kg):</label>");
		out.println("<input type='number' name='weight' step='0.1' required placeholder='VD: 65'>");
		out.println("<button type='submit'>Tính toán</button>");
		out.println("</form>");

		out.println("</body></html>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		try {
			String heightStr = request.getParameter("height");
			String weightStr = request.getParameter("weight");

			double heightCm = Double.parseDouble(heightStr);
			double weight = Double.parseDouble(weightStr);

			double heightM = heightCm / 100;
			double bmi = weight / (heightM * heightM);
			String phanLoai = "";
			String color = "black";

			if (bmi < 18.5) {
				phanLoai = "Gầy";
				color = "orange";
			} else if (bmi < 24.9) {
				phanLoai = "Bình thường";
				color = "green";
			} else if (bmi < 29.9) {
				phanLoai = "Thừa cân";
				color = "orange";
			} else {
				phanLoai = "Béo phì";
				color = "red";
			}

			out.println("<!DOCTYPE html><html><head><title>Kết quả BMI</title></head><body>");
			out.println("<div style='text-align:center; margin-top: 50px;'>");
			out.println("<h2>Kết quả BMI của bạn</h2>");
			out.println("<p>Chiều cao: " + heightCm + " cm | Cân nặng: " + weight + " kg</p>");
			out.println("<h3>Chỉ số BMI: " + String.format("%.2f", bmi) + "</h3>");
			out.println("<h2 style='color:" + color + "'>Phân loại: " + phanLoai + "</h2>");
			out.println("<br><a href='BMI'>Quay lại tính tiếp</a>");
			out.println("</div></body></html>");

		} catch (Exception e) {
			out.println("<h3>Dữ liệu nhập vào không hợp lệ!</h3>");
		}
	}

}
