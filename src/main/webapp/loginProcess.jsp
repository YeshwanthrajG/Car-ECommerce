<%@ page import="java.sql.*" %>
<%@ page import="CarExpert.DBConnection" %>
<%
    request.setCharacterEncoding("UTF-8");
    String Username = request.getParameter("username");
    String Password = request.getParameter("password");

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement("SELECT id, username FROM users WHERE username=? AND password=?")) {
        ps.setString(1, Username);
        ps.setString(2, Password);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            session.setAttribute("userId", rs.getInt("id"));
            session.setAttribute("username", rs.getString("username"));
            out.println("<script>alert('Login successful!'); window.location='dashboard.jsp';</script>");
        } else {
            out.println("<script>alert('Invalid username or password!'); window.location='login.jsp';</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Login error occurred.'); window.location='login.jsp';</script>");
    }
%>
