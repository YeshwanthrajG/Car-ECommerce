package CarExpert;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.*;

/**
 * Servlet implementation class BuyServlet
 */
@WebServlet("/BuyServlet")
public class BuyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BuyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
        Integer userId = (session == null) ? null : (Integer) session.getAttribute("userId");
        if (userId == null) {
            try (PrintWriter out = response.getWriter()) {
                out.println("<script>alert('Please login to buy.'); window.location='login.jsp';</script>");
            }
            return;
        }

        String carId = request.getParameter("carId");

        // Example: mark as sold to this user (adjust to your schema)
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "UPDATE cars SET buyer_id=?, status='SOLD' WHERE id=? AND (status IS NULL OR status <> 'SOLD')")) {
            ps.setInt(1, userId);
            ps.setInt(2, Integer.parseInt(carId));
            int updated = ps.executeUpdate();

            try (PrintWriter out = response.getWriter()) {
                if (updated > 0) {
                    out.println("<script>alert('Purchase request placed successfully!'); window.location='dashboard.jsp';</script>");
                } else {
                    out.println("<script>alert('Purchase failed or already sold.'); window.location='dashboard.jsp';</script>");
                }
            }
        } catch (Exception e) {
            try (PrintWriter out = response.getWriter()) {
                out.println("<script>alert('Error while placing buy request.'); window.location='dashboard.jsp';</script>");
            }
        }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

