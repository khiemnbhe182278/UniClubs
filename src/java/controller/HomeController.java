package controller;

import dal.NewsDAO;
import dal.EventDAO;
import model.News;
import model.Event;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        NewsDAO newsDao = new NewsDAO();
        EventDAO eventDao = new EventDAO();

        List<News> newsList = newsDao.getAllNews();
        List<Event> eventList = eventDao.getAllEvents();

        request.setAttribute("newsList", newsList);
        request.setAttribute("eventList", eventList);

   request.getRequestDispatcher("HomePage/HomePage.jsp").forward(request, response);

    }
}
