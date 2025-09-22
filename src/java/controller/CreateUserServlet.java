
import dal.RoleDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.RoleDTO;
import model.UserDTO;

@WebServlet("/createUser")
public class CreateUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RoleDAO roleDao = new RoleDAO();
        List<RoleDTO> roles = roleDao.getRolesToCreateUsers();
        request.setAttribute("roles", roles);

        request.getRequestDispatcher("/admin/createUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String roleStr = request.getParameter("role");

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Username is required");
            doGet(request, response);
            return;
        }
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            request.setAttribute("error", "Invalid email format");
            doGet(request, response);
            return;
        }
        if (password == null || password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters");
            doGet(request, response);
            return;
        }
        if (roleStr == null) {
            request.setAttribute("error", "Please select a role");
            doGet(request, response);
            return;
        }

        int roleID = Integer.parseInt(roleStr);

        UserDTO user = new UserDTO();
        user.setUserName(username.trim());
        user.setEmail(email.trim());
        user.setPasswordHash(password);
        user.setRoleID(roleID);

        UserDAO dao = new UserDAO();
        boolean success = dao.createUser(user);

        if (success) {
            request.setAttribute("message", "User created successfully!");
            doGet(request, response);
        } else {
            request.setAttribute("error", "Failed to create user. Please try again!");
            doGet(request, response);
        }

    }
}
