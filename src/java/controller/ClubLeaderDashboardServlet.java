package controller;

import dal.ClubDAO;
import dal.MemberDAO;
import dal.EventDAO;
import dal.PaymentDAO;
import model.User;
import model.Club;
import model.Member;
import model.Event;
import model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ClubLeaderDashboardServlet", urlPatterns = {"/leader/dashboard"})
public class ClubLeaderDashboardServlet extends HttpServlet {
    /*
     * ClubLeaderDashboardServlet
     * (Tiếng Việt)
     * Mục đích: Hiển thị dashboard dành cho vai trò Club Leader (ban chủ nhiệm CLB).
     * - Input:
     *   + Session chứa "user" (User). Nếu không có -> redirect /login.
     *   + Optional request param: "clubId" để chọn CLB hiện hành.
     * - Bảo mật/Quyền truy cập:
     *   + Kiểm tra roleID để đảm bảo user là Leader/Manager/Admin (roleID 2/4/1 trong app này).
     *   + Nếu user không có quyền truy cập CLB được yêu cầu -> trả về 403.
     * - Xử lý chính:
     *   + Lấy danh sách CLB mà user là leader (myClubs).
     *   + Quyết định clubId hiện hành theo thứ tự: param > session > first club trong myClubs.
     *   + Lưu clubId và club object vào session (currentClubId, currentClub) để các trang con dùng.
     *   + Lấy dữ liệu thống kê liên quan: members, events, payments, pendingMembers, totalRevenue.
     * - Output: Đặt nhiều attribute trên request (club, myClubs, members, events, payments, pendingMembers, totalRevenue, ...) và forward tới `/leader-dashboard.jsp`.
     * - Lỗi: nếu user không là leader của CLB nào -> forward tới `error-no-club.jsp` với thông báo.
     *
     * Ghi chú:
     * - Việc lưu clubId vào session giúp giữ trạng thái giữa các trang leader (sử dụng trong header/menus).
     * - Các DAO nên trả dữ liệu đã lọc (ví dụ: chỉ trả payments liên quan đến clubId).
     */

    private ClubDAO clubDAO;
    private MemberDAO memberDAO;
    private EventDAO eventDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        clubDAO = new ClubDAO();
        memberDAO = new MemberDAO();
        eventDAO = new EventDAO();
        paymentDAO = new PaymentDAO();
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

        // Kiểm tra quyền: chỉ cho leader/admin/manager
        if (user.getRoleID() != 2 && user.getRoleID() != 4 && user.getRoleID() != 1) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Lấy danh sách CLB do user quản lý
        List<Club> myClubs = clubDAO.getUserLeadClubs(user.getUserID());

        if (myClubs.isEmpty()) {
            // Nếu user không là leader của CLB nào -> thông báo và forward tới trang lỗi chuyên biệt
            request.setAttribute("errorMessage",
                    "You are not assigned as a leader of any club. Please contact the administrator.");
            request.getRequestDispatcher("/error-no-club.jsp").forward(request, response);
            return;
        }

        // Xác định clubId hiện hành: ưu tiên param > session > first club
        String clubIdParam = request.getParameter("clubId");
        int clubId = 0;
        Club club = null;

        if (clubIdParam != null && !clubIdParam.trim().isEmpty()) {
            try {
                clubId = Integer.parseInt(clubIdParam);
                club = clubDAO.getClubById(clubId);

                // Xác nhận user là leader của club này (trừ khi user là Admin roleID==1)
                boolean isLeaderOfClub = false;
                for (Club c : myClubs) {
                    if (c.getClubID() == clubId) {
                        isLeaderOfClub = true;
                        club = c;
                        break;
                    }
                }

                if (!isLeaderOfClub && user.getRoleID() != 1) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN,
                            "You don't have permission to access this club");
                    return;
                }
            } catch (NumberFormatException e) {
                clubId = myClubs.get(0).getClubID();
                club = myClubs.get(0);
            }
        } else {
            Integer sessionClubId = (Integer) session.getAttribute("currentClubId");
            if (sessionClubId != null) {
                boolean found = false;
                for (Club c : myClubs) {
                    if (c.getClubID() == sessionClubId) {
                        clubId = sessionClubId;
                        club = c;
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    clubId = myClubs.get(0).getClubID();
                    club = myClubs.get(0);
                }
            } else {
                club = myClubs.get(0);
                clubId = club.getClubID();
            }
        }

        // Lưu club hiện hành vào session để các trang khác dùng lại
        session.setAttribute("currentClubId", clubId);
        session.setAttribute("currentClub", club);

        try {
            // Lấy dữ liệu liên quan tới CLB
            List<Member> members = memberDAO.getClubMembers(clubId);
            List<Event> events = eventDAO.getEventsByClub(clubId);
            List<Payment> payments = paymentDAO.getClubPayments(clubId);
            double totalRevenue = paymentDAO.getTotalRevenue(clubId);

            List<Member> pendingMembers = memberDAO.getPendingMembersByClub(clubId);

            // Đặt attribute cho JSP
            request.setAttribute("club", club);
            request.setAttribute("myClubs", myClubs);
            request.setAttribute("members", members);
            request.setAttribute("events", events);
            request.setAttribute("payments", payments);
            request.setAttribute("pendingMembers", pendingMembers);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("clubId", clubId);

            // Thống kê nhanh
            request.setAttribute("totalMembers", members.size());
            request.setAttribute("pendingMembersCount", pendingMembers.size());
            request.setAttribute("upcomingEvents", events.size());

            request.getRequestDispatcher("/leader-dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while loading dashboard data.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
