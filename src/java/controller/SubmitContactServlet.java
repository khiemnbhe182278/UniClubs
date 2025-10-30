package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SubmitContactServlet", urlPatterns = {"/submit-contact"})
public class SubmitContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");
        request.setAttribute("name", name);
        request.setAttribute("email", email);
        request.setAttribute("message", message);
        request.getRequestDispatcher("contact-thanks.jsp").forward(request, response);
    }
}
