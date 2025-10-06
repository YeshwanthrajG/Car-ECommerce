<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="CarExpert.DBConnection" %>
<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", 0);

    Integer userId = (Integer) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String,Object>> cart = (List<Map<String,Object>>) session.getAttribute("cart");
    int cartCount = (cart == null) ? 0 : cart.size();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard | CarExpert</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="navbar">
    <div class="brand">CarExpert</div>
    <div class="actions">
        <span class="badge">Hello, <%= username %></span>
        <a class="ghost" href="checkout.jsp">Cart (<%= cartCount %>)</a>
        <a class="primary" href="sell.jsp">Sell a Car</a>
        <a class="ghost" href="LogoutServlet">Logout</a>
    </div>
</div>

<div class="container">
    <div class="card">
        <h2>Available Cars</h2>
        <table class="table">
            <tr>
                <th>Image</th>
                <th>Name</th>
                <th>Brand</th>
                <th>Price</th>
                <th>Class</th>
                <th>Description</th>
                <th>Stock</th>
                <th>Action</th>
            </tr>
            <%
                try {
                    Connection conn = DBConnection.getConnection();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM cars");

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String brand = rs.getString("brand");
                        String price = rs.getString("price");
                        String carClass = rs.getString("class");
                        String description = rs.getString("description");
                        int stock = rs.getInt("stock");
                        String status = (stock > 0) ? "AVAILABLE" : "SOLD";
            %>
                <tr>
                    <td><img src="<%= rs.getString("image_url") %>" width="100" height="60"></td>
                    <td><%= name %></td>
                    <td><%= brand %></td>
                    <td>₹<%= price %></td>
                    <td><%= carClass %></td>
                    <td><%= description %></td>
                    <td><%= stock %></td>
                    <td>
                        <% if (!"SOLD".equalsIgnoreCase(status)) { %>
                            <!-- Add to Cart -->
                            <form action="CartServlet" method="post" style="display:inline;">
                                <input type="hidden" name="carId" value="<%= id %>">
                                <input type="hidden" name="carName" value="<%= name %>">
                                <input type="hidden" name="brand" value="<%= brand %>">
                                <input type="hidden" name="price" value="<%= price %>">
                                <button type="submit" class="ghost">Add to Cart</button>
                            </form>

                            <!-- Direct Buy -->
                            <form action="BuyServlet" method="post" style="display:inline;margin-left:6px;">
                                <input type="hidden" name="carId" value="<%= id %>">
                                <button type="submit" class="primary">Buy Now</button>
                            </form>
                        <% } else { %>
                            <span class="badge">SOLD</span>
                        <% } %>
                    </td>
                </tr>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='8'>Error loading cars: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>
        
        <div style="margin-top:12px;">
            <a class="primary" href="checkout.jsp">Go to Checkout</a>
        </div>
    </div>
</div>
</body>
</html>
