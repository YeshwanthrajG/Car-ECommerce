package CarExpert;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        if ("remove".equalsIgnoreCase(action)) {
            String carId = request.getParameter("carId");

            if (carId != null) {
                cart.removeIf(item -> carId.equals(item.get("carId").toString()));
                session.setAttribute("cart", cart);
                response.sendRedirect("checkout.jsp");  
            } else {
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script>alert('CarId missing for removal.'); history.back();</script>");
                }
            }

        } else {
            String carId = request.getParameter("carId");
            String carName = request.getParameter("carName");
            String brand = request.getParameter("brand");
            String priceStr = request.getParameter("price");

            if (carId == null || carName == null || carId.isEmpty() || carName.isEmpty() || priceStr == null) {
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script>alert('Failed to add to cart. Missing details.'); history.back();</script>");
                }
                return;
            }

            int price;
            try {
                price = Integer.parseInt(priceStr);   
            } catch (NumberFormatException e) {
                try (PrintWriter out = response.getWriter()) {
                    out.println("<script>alert('Invalid price format.'); history.back();</script>");
                }
                return;
            }

            Map<String, Object> item = new HashMap<>();
            item.put("carId", carId);
            item.put("carName", carName);
            item.put("brand", brand == null ? "" : brand);
            item.put("price", price);   
            cart.add(item);

            session.setAttribute("cart", cart);

            try (PrintWriter out = response.getWriter()) {
                out.println("<script>alert('Car added to cart!'); window.location='dashboard.jsp';</script>");
            }
        }
    }
}
