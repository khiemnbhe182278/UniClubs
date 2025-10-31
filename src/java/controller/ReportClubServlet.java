package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ReportClubServlet", urlPatterns = {"/report-club"})
public class ReportClubServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String clubId = request.getParameter("clubId");
        String reason = request.getParameter("reason");
        request.setAttribute("clubId", clubId);
        request.setAttribute("reason", reason);
        request.getRequestDispatcher("report-thanks.jsp").forward(request, response);
    }
}
