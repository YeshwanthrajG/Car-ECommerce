package CarExpert;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.*;
import java.io.PrintWriter;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();

        try (PrintWriter out = response.getWriter()) {
            out.println("<script>alert('Logged out successfully!'); window.location='index.jsp';</script>");
        }
    }
}
