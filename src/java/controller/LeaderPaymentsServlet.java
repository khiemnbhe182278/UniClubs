package controller;

import dal.PaymentDAO;
import model.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LeaderPaymentsServlet", urlPatterns = {"/leader/payments"})
public class LeaderPaymentsServlet extends HttpServlet {

    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String clubIdParam = request.getParameter("clubId");
        if (clubIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing clubId");
            return;
        }

        try {
            int clubId = Integer.parseInt(clubIdParam);
            List<Payment> payments = paymentDAO.getClubPayments(clubId);
            request.setAttribute("payments", payments);
            request.setAttribute("clubId", clubId);
            request.getRequestDispatcher("/leader-payments.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid clubId");
        }
    }
}
