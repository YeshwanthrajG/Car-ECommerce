package CarExpert;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class SellServlet
 */
@WebServlet("/SellServlet")
public class SellServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SellServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);
        Integer userId = (session == null) ? null : (Integer) session.getAttribute("userId");
        if (userId == null) {
            try (PrintWriter out = response.getWriter()) {
                out.println("<script>alert('Please login to list your car.'); window.location='login.jsp';</script>");
            }
            return;
        }

        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        int price = Integer.parseInt(request.getParameter("price"));
        String cls=request.getParameter("class");
        String desc = request.getParameter("description");
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imageUrl = request.getParameter("image_url");

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO cars (name, brand, price, class, description, stock, image_url) VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, brand);
            ps.setDouble(3, price);
            ps.setString(4, cls);
            ps.setString(5, desc);
            ps.setInt(6, stock);
            ps.setString(7, imageUrl);
//            ps.executeUpdate();      

            int ins = ps.executeUpdate();
            try (PrintWriter out = response.getWriter()) {
                if (ins > 0) {
                    out.println("<script>alert('Your car has been listed successfully!'); window.location='dashboard.jsp';</script>");
                } else {
                    out.println("<script>alert('Failed to list car.'); window.location='dashboard.jsp';</script>");
                }
            }
        } catch (Exception e) {
            try (PrintWriter out = response.getWriter()) {
                out.println("<script>alert('Error while listing car.'); window.location='dashboard.jsp';</script>");
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


