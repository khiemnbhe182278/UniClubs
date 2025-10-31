package controller;

import dal.EventDAO;
import dal.ClubDAO;
import dal.MemberDAO;
import dal.UserDAO;
import model.Event;
import model.Club;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Date;

@WebServlet(name = "CreateEventServlet", urlPatterns = {"/create-event"})
public class CreateEventServlet extends HttpServlet {

    private EventDAO eventDAO;
    private ClubDAO clubDAO;
    private MemberDAO memberDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        clubDAO = new ClubDAO();
        memberDAO = new MemberDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Get user's clubs where they are leader or approved member
        List<Club> myClubs = clubDAO.getUserLeadClubs(user.getUserID());
        request.setAttribute("myClubs", myClubs);

        // Truyền thêm clubId nếu user là Leader hoặc Faculty
        if (user.getRoleID() == 2) { // Leader
            Integer clubId = userDAO.getLeaderPrimaryClubId(user.getUserID());
            request.setAttribute("userClubId", clubId);
        } else if (user.getRoleID() == 3) { // Faculty
            Integer clubId = userDAO.getFacultyPrimaryClubId(user.getUserID());
            request.setAttribute("userClubId", clubId);
        }

        request.getRequestDispatcher("create-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        try {
            int clubId = Integer.parseInt(request.getParameter("clubId"));
            String eventName = request.getParameter("eventName");
            String description = request.getParameter("description");
            String eventDateStr = request.getParameter("eventDate");
            String eventTimeStr = request.getParameter("eventTime");

            // Validation
            if (eventName == null || eventName.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || eventDateStr == null || eventDateStr.trim().isEmpty()
                    || eventTimeStr == null || eventTimeStr.trim().isEmpty()) {
                request.setAttribute("error", "All fields are required");
                doGet(request, response);
                return;
            }





            // Parse date and time
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String dateTimeStr = eventDateStr + " " + eventTimeStr;
            Date eventDate = sdf.parse(dateTimeStr);
            Timestamp eventTimestamp = new Timestamp(eventDate.getTime());

            Event event = new Event();
            event.setClubID(clubId);
            event.setEventName(eventName.trim());
            event.setDescription(description.trim());
            event.setEventDate(eventTimestamp);
            event.setStatus("Pending");

            boolean success = eventDAO.createEvent(event);

            if (success) {
                request.setAttribute("success", "Event created successfully! Waiting for admin approval.");
            } else {
                request.setAttribute("error", "Failed to create event. Please try again.");
            }

            doGet(request, response);

        } catch (NumberFormatException | ParseException e) {
            request.setAttribute("error", "Invalid input data");
            doGet(request, response);
        }
    }
}
