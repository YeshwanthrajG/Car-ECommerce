<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>FAQs - CarExpert</title>
    <link rel="stylesheet" href="style.css">
    <style>
      .faq { background: #fff; margin: 20px auto; padding: 20px 30px; border-radius: 12px; box-shadow: 0 4px 16px rgba(0,0,0,.08);}
      .faq h3 { color: #2563eb; margin-bottom: 10px;}
      .faq p { color: #222; margin-bottom: 0;}
    </style>
</head>
<body>
    <div class="container">
        <h2>Frequently Asked Questions</h2>
        <%
            List<Map<String, String>> faqs = (List<Map<String, String>>) request.getAttribute("faqs");
            if (faqs != null) {
                for (Map<String, String> faq : faqs) {
        %>
        <div class="faq">
            <h3><%= faq.get("question") %></h3>
            <p><%= faq.get("answer") %></p>
        </div>
        <%
                }
            } else {
        %>
        <p>No FAQs are available.</p>
        <%
            }
        %>
    </div>
</body>
</html>
