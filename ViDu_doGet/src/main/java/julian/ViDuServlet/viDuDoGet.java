package julian.ViDuServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/viDuDoGet")
public class viDuDoGet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public viDuDoGet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		String noiDungHTML = "";
		noiDungHTML += "<center><h3>Tôi học Web Java </h3></center>";
		noiDungHTML += "<hr>";
		noiDungHTML += "<center>65.CNTT-CLC</center>";
		
		
		PrintWriter boTraLoi = response.getWriter();
		boTraLoi.print(noiDungHTML);
	}

}
