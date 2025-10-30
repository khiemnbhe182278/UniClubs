package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "StaticPageServlet", urlPatterns = {"/about", "/guidelines", "/resources", "/contact", "/feedback", "/register-club", "/join"})
public class StaticPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/about":
                request.getRequestDispatcher("about.jsp").forward(request, response);
                break;
            case "/guidelines":
                request.getRequestDispatcher("guidelines.jsp").forward(request, response);
                break;
            case "/resources":
                request.getRequestDispatcher("resources.jsp").forward(request, response);
                break;
            case "/contact":
                request.getRequestDispatcher("contact.jsp").forward(request, response);
                break;
            case "/feedback":
                request.getRequestDispatcher("feedback.jsp").forward(request, response);
                break;
            case "/register-club":
                request.getRequestDispatcher("register-club.jsp").forward(request, response);
                break;
            case "/join":
                // simple redirect to join-club
                response.sendRedirect(request.getContextPath() + "/join-club");
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
