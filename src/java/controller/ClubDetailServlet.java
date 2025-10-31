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

    /**
     * ClubDetailServlet
     * -----------------
     * VN: Hiển thị trang chi tiết cho một CLB.
     * - Input: request parameter "id" (số nguyên đại diện cho ClubID)
     * - Behavior: lấy đối tượng Club từ CSDL bằng ClubDAO và forward tới `club-detail.jsp`.
     * - Error handling: trả về 400 nếu id không hợp lệ, 404 nếu không tìm thấy CLB.
     *
     * EN: Shows details for a single club.
     * - Input: request parameter "id" (integer ClubID)
     * - Behavior: fetch Club using ClubDAO and forward to `club-detail.jsp`.
     * - Errors: 400 for bad id, 404 when club not found.
     */

    private ClubDAO clubDAO;

    @Override
    public void init() throws ServletException {
        // Initialize DAO used to query club information.
        clubDAO = new ClubDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read `id` parameter from query string. Expect integer.
        // VN: Tham số "id" phải là số nguyên. Nếu không, trả về lỗi 400.
        try {
            int clubId = Integer.parseInt(request.getParameter("id"));

            // Retrieve club by id. DAO returns null if not found.
            Club club = clubDAO.getClubById(clubId);

            if (club != null) {
                request.setAttribute("club", club);
                // Forward request to JSP for rendering details
                request.getRequestDispatcher("club-detail.jsp").forward(request, response);
            } else {
                // Not found -> HTTP 404
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Club not found");
            }
        } catch (NumberFormatException e) {
            // Bad id format -> HTTP 400
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid club ID");
        }
    }
}
