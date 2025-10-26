package controller;

import dal.ClubDAO;
import model.Club;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ClubDetailServlet", urlPatterns = {"/club-detail"})
public class ClubDetailServlet extends HttpServlet {

    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int clubId = Integer.parseInt(request.getParameter("id"));
            Club club = clubDAO.getClubById(clubId);

            if (club != null) {
                request.setAttribute("club", club);
                request.getRequestDispatcher("club-detail.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Club not found");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid club ID");
        }
    }
}
