<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    List<Map<String,Object>> cart = (List<Map<String,Object>>) session.getAttribute("cart");
    if (cart == null) cart = new ArrayList<>();
    double total = 0.0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h2>Checkout</h2>
    <div class="card">
        <h3>Your Cart</h3>
        <table class="table">
            <tr><th>#</th><th>Car</th><th>Brand</th><th>Price (₹)</th><th>Action</th></tr>
            <%
                int i = 1;
                for (Map<String,Object> item : cart) {
                	int price = ((Number) item.get("price")).intValue();
                	total += price;
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= item.get("carName") %></td>
                <td><%= item.get("brand") %></td>
                <td><%= price %></td>
                <td>
				    <form action="CartServlet" method="post" style="display:inline;">
				        <input type="hidden" name="action" value="remove">
				        <input type="hidden" name="carId" value="<%= item.get("carId") %>">
				        <button type="submit">Remove</button>
				    </form>
				</td>

            </tr>
            <% } %>
            <tr class="total-row">
                <td colspan="4" style="text-align:right;"><b>Total</b></td>
                <td><b>₹ <%= String.format("%.2f", total) %></b></td>
            </tr>
        </table>
    </div>

    <div class="card">
        <h3>Payment</h3>
        <form class="form" action="PaymentServlet" method="post" 
              onsubmit="return confirm('Confirm to pay ₹ <%= String.format("%.2f", total) %>?')">
            <label>Name on Card</label>
            <input type="text" name="nameOnCard" required>

            <label>Card Number</label>
            <input type="text" name="cardNumber" maxlength="16" pattern="\d{13,19}" required placeholder="16 digits">

            <div class="row">
                <div class="col">
                    <label>Expiry (MM/YY)</label>
                    <input type="text" name="expiry" maxlength="5" 
                           required placeholder="MM/YY">
                </div>
                <div class="col">
                    <label>CVV</label>
                    <input type="password" name="cvv" maxlength="4" required placeholder="3 digits">
                </div>
            </div>

            <button type="submit" class="primary">Pay Now</button>
            <a class="ghost" href="dashboard.jsp">Back to Dashboard</a>
        </form>
    </div>
</div>
</body>
</html>
