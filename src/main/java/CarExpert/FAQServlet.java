package CarExpert;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import java.io.*;
import java.util.*;

@WebServlet("/FAQServlet")
public class FAQServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> faqs = new ArrayList<>();
        try {
            // Adjust the path if necessary
            String xmlPath = getServletContext().getRealPath("/WEB-INF/faqs.xml");
            File file = new File(xmlPath);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(file);
            NodeList faqNodes = doc.getElementsByTagName("faq");
            for (int i = 0; i < faqNodes.getLength(); i++) {
                Element faqElem = (Element) faqNodes.item(i);
                String question = faqElem.getElementsByTagName("question").item(0).getTextContent();
                String answer = faqElem.getElementsByTagName("answer").item(0).getTextContent();
                Map<String, String> faq = new HashMap<>();
                faq.put("question", question);
                faq.put("answer", answer);
                faqs.add(faq);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Forward to JSP
        request.setAttribute("faqs", faqs);
        RequestDispatcher dispatcher = request.getRequestDispatcher("faqs.jsp");
        dispatcher.forward(request, response);
    }
}
