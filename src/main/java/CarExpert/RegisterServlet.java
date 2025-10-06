package CarExpert;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response type
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Get parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Basic validation
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            out.write("{\"status\":\"error\", \"message\":\"Username and password are required.\"}");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            
            // Check if username exists
            try (PreparedStatement check = conn.prepareStatement("SELECT id FROM users WHERE username = ?")) {
                check.setString(1, username);
                ResultSet rs = check.executeQuery();
                if (rs.next()) {
                    out.write("{\"status\":\"error\", \"message\":\"Username already exists.\"}");
                    return;
                }
            }

            // Insert new user
            try (PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO users (username, password, email) VALUES (?, ?, ?)")) {
                ps.setString(1, username);
                ps.setString(2, password); 
                ps.setString(3, (email == null || email.trim().isEmpty()) ? null : email.trim());

                int inserted = ps.executeUpdate();
                if (inserted > 0) {
                    out.write("{\"status\":\"success\", \"message\":\"Registration successful.\"}");
                } else {
                    out.write("{\"status\":\"error\", \"message\":\"Registration failed.\"}");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"status\":\"error\", \"message\":\"Server error occurred.\"}");
        }
    }

    // Optional: You can remove doGet or keep it disabled
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // No implementation needed for GET
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET not supported.");
    }
}
