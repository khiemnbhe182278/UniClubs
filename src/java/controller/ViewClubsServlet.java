//package controller;
//
//import dal.ClubDAO;
//import model.Club;
//
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/viewClubs")
//public class ViewClubsServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String keyword = request.getParameter("search");
//        if (keyword == null) keyword = "";
//
//        ClubDAO dao = new ClubDAO();
//        List<Club> clubs = dao.getClubs(keyword);
//
//        request.setAttribute("clubs", clubs);
//        request.setAttribute("search", keyword);
//
//        request.getRequestDispatcher("/club-manager/viewClubs.jsp").forward(request, response);
//    }
//}
