package controller;

import dal.MemberDAO;
import dal.EventDAO;
import dal.PaymentDAO;
import model.Member;
import model.Event;
import model.Payment;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ExportDataServlet", urlPatterns = {"/leader/export"})
public class ExportDataServlet extends HttpServlet {

    private MemberDAO memberDAO;
    private EventDAO eventDAO;
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
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

        int clubId = Integer.parseInt(request.getParameter("clubId"));
        String type = request.getParameter("type"); // members, events, payments

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + type + "_" + clubId + ".csv\"");

        PrintWriter writer = response.getWriter();

        switch (type) {
            case "members":
                exportMembers(writer, clubId);
                break;
            case "events":
                exportEvents(writer, clubId);
                break;
            case "payments":
                exportPayments(writer, clubId);
                break;
        }

        writer.flush();
    }

    private void exportMembers(PrintWriter writer, int clubId) {
        writer.println("Name,Email,Status,Joined Date");
        List<Member> members = memberDAO.getClubMembers(clubId);
        for (Member member : members) {
            writer.printf("%s,%s,%s,%s\n",
                    escapeCsv(member.getUserName()),
                    escapeCsv(member.getEmail()),
                    member.getJoinStatus(),
                    member.getJoinedAt().toString()
            );
        }
    }

    private void exportEvents(PrintWriter writer, int clubId) {
        writer.println("Event Name,Date,Status,Description");
        List<Event> events = eventDAO.getEventsByClub(clubId);
        for (Event event : events) {
            writer.printf("%s,%s,%s,%s\n",
                    escapeCsv(event.getEventName()),
                    event.getEventDate().toString(),
                    event.getStatus(),
                    escapeCsv(event.getDescription())
            );
        }
    }

    private void exportPayments(PrintWriter writer, int clubId) {
        writer.println("Member,Amount,Type,Date,Status");
        List<Payment> payments = paymentDAO.getClubPayments(clubId);
        for (Payment payment : payments) {
            writer.printf("%s,%.2f,%s,%s,%s\n",
                    escapeCsv(payment.getUserName()),
                    payment.getAmount(),
                    payment.getPaymentType(),
                    payment.getPaymentDate().toString(),
                    payment.getStatus()
            );
        }
    }

    private String escapeCsv(String value) {
        if (value == null) {
            return "";
        }
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }
}
