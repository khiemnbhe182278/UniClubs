package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import model.User;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    private Set<String> loginRequiredPrefixes;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Define URL prefixes that require a logged-in user
        loginRequiredPrefixes = new HashSet<>();
        loginRequiredPrefixes.add("/admin");
        loginRequiredPrefixes.add("/leader");
        loginRequiredPrefixes.add("/dashboard");
        loginRequiredPrefixes.add("/profile");
        loginRequiredPrefixes.add("/join-club");
        loginRequiredPrefixes.add("/create-event");
        loginRequiredPrefixes.add("/create-club");
        loginRequiredPrefixes.add("/admin/");
        // add other protected prefixes as needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Quick pass for static resources and public pages
        if (path.startsWith("/resources") || path.startsWith("/static") || path.startsWith("/css") || path.startsWith("/images") || path.startsWith("/js")) {
            chain.doFilter(request, response);
            return;
        }

        boolean requiresLogin = false;
        for (String p : loginRequiredPrefixes) {
            if (path.equals(p) || path.startsWith(p)) {
                requiresLogin = true;
                break;
            }
        }

        if (!requiresLogin) {
            // public page
            chain.doFilter(request, response);
            return;
        }

        // At this point the page requires login
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        int roleID = user.getRoleID(); // 1=Admin,2=ClubManager,3=Faculty,4=ClubLeader,5=Student

        // Admin-only paths
        if (path.startsWith("/admin")) {
            if (roleID == 1) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have permission to access this page.");
            }
            return;
        }

        // Leader/Manager paths (allow Admin as well)
        if (path.startsWith("/leader") || path.equals("/create-event") || path.equals("/create-club") || path.equals("/createNews") || path.startsWith("/leader/")) {
            if (roleID == 1 || roleID == 2 || roleID == 4) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "You don't have permission to access this page.");
            }
            return;
        }

        // Other pages that require login (profile, dashboard, join)
        if (path.equals("/profile") || path.equals("/dashboard") || path.equals("/join-club") || path.equals("/register-event")) {
            // any logged-in user allowed
            chain.doFilter(request, response);
            return;
        }

        // Default: allow
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup
    }
}