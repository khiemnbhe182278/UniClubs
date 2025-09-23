package controller;

import dal.ClubRegistrationDAO;
import model.ClubRegistration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/club-registration")
public class ClubRegistrationController extends HttpServlet {
    private ClubRegistrationDAO dao = new ClubRegistrationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    request.getRequestDispatcher("/jsp/clubRegistration/add.jsp").forward(request, response);
                    break;

                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    ClubRegistration reg = dao.getRegistrationById(id);
                    if (reg == null) {
                        response.sendRedirect("club-registration?error=notfound");
                        return;
                    }
                    request.setAttribute("reg", reg);
                    request.getRequestDispatcher("/jsp/clubRegistration/edit.jsp").forward(request, response);
                    break;

                case "delete":
                    int delId = Integer.parseInt(request.getParameter("id"));
                    boolean deleted = dao.deleteRegistration(delId);
                    response.sendRedirect("club-registration" + (deleted ? "?success=delete" : "?error=delete"));
                    break;

                default: // list
                    List<ClubRegistration> list = dao.getAllRegistrations();
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("/jsp/clubRegistration/list.jsp").forward(request, response);
                    break;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("club-registration?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("club-registration?error=exception");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {
            if ("insert".equals(action)) {
                ClubRegistration reg = new ClubRegistration();
          
                reg.setClubID(Integer.parseInt(request.getParameter("clubID")));
                reg.setRegistrationDate(LocalDateTime.now());
                reg.setStatus("pending");
                reg.setNotes(request.getParameter("notes"));

                boolean inserted = dao.insertRegistration(reg);
                response.sendRedirect("club-registration" + (inserted ? "?success=insert" : "?error=insert"));

            } else if ("update".equals(action)) {
                ClubRegistration reg = new ClubRegistration();
                reg.setRegistrationID(Integer.parseInt(request.getParameter("id")));
                reg.setStatus(request.getParameter("status"));
                reg.setNotes(request.getParameter("notes"));

                boolean updated = dao.updateRegistration(reg);
                response.sendRedirect("club-registration" + (updated ? "?success=update" : "?error=update"));
            } else {
                response.sendRedirect("club-registration?error=invalid_action");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("club-registration?error=invalid_number");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("club-registration?error=server_error");
        }
    }
}