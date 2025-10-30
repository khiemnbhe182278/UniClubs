package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SubmitFeedbackServlet", urlPatterns = {"/submit-feedback"})
public class SubmitFeedbackServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // In this simple implementation we just forward to a thank-you page.
        // Real implementation should persist feedback to DB or send email.
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        request.setAttribute("subject", subject);
        request.setAttribute("message", message);
        request.getRequestDispatcher("feedback-thanks.jsp").forward(request, response);
    }
}
