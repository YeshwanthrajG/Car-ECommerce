package CarExpert;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (cart == null || cart.isEmpty()) {
            out.println("<script>alert('Cart is empty!'); window.location='checkout.jsp';</script>");
            return;
        }

        String cardNumber = request.getParameter("cardNumber");
        String expiry = request.getParameter("expiry");
        String cvv = request.getParameter("cvv");

        if (cardNumber == null || expiry == null || cvv == null ||
            cardNumber.isEmpty() || expiry.isEmpty() || cvv.isEmpty()) {
            out.println("<script>alert('Please enter valid card details.'); history.back();</script>");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/carecommerce", "root", "password");

            conn.setAutoCommit(false);

            String updateStockSQL = "UPDATE cars SET stock = stock - 1 WHERE id = ? AND stock > 0";
            pstmt = conn.prepareStatement(updateStockSQL);

            for (Map<String, Object> item : cart) {
                int carId = Integer.parseInt(item.get("carId").toString());

                System.out.println("Processing Car ID: " + carId); 

                pstmt.setInt(1, carId);
                int rowsUpdated = pstmt.executeUpdate();

                if (rowsUpdated == 0) {
                    conn.rollback();
                    out.println("<script>alert('Payment failed! Car out of stock.'); window.location='checkout.jsp';</script>");
                    return;
                }
            }

            conn.commit();
            session.removeAttribute("cart");

            out.println("<script>alert('Payment successful! Order confirmed.'); window.location='dashboard.jsp';</script>");

        } catch (Exception e) {
            e.printStackTrace(out); 
            out.println("<script>alert('Payment error occurred. Check console/logs.'); history.back();</script>");
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
