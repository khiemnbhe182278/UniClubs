package controller;

import dal.UserDTODAO;
import model.UserDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/users")
public class UserDTOController extends HttpServlet {

    private UserDTODAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDTODAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Luôn hiển thị form đăng ký
        request.getRequestDispatcher("/Student/RegisterSTD.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        createUser(request, response);
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String passwordHash = request.getParameter("password"); // TODO: hash trước khi lưu

        // mặc định Student
        int roleID = 2; 
        String role = request.getParameter("role");
        if (role == null || role.trim().isEmpty()) {
            role = "Student";
        }

        UserDTO user = new UserDTO();
        user.setUserName(username);
        user.setEmail(email);
        user.setPasswordHash(passwordHash);
        user.setRoleID(roleID);
        user.setRole(role);
        user.setStatus(true); // mặc định active

        userDAO.addUser(user);

        // quay lại trang đăng ký sau khi tạo
        response.sendRedirect("users");
    }
}
