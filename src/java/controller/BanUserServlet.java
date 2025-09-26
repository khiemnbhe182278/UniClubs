
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/banUser")
public class BanUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int userID = Integer.parseInt(req.getParameter("userID"));
        boolean status = Boolean.parseBoolean(req.getParameter("status"));

        UserDAO dao = new UserDAO();
        dao.toggleBan(userID, !status);

        resp.sendRedirect(req.getContextPath() + "/admin/listAccounts");
    }
}
