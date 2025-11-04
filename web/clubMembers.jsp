<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Member" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    List<Member> members = (List<Member>) request.getAttribute("members");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Club Members Management - UniClubs</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #34495e;
                --accent-color: #3498db;
                --background-color: #f5f6fa;
                --surface-color: #ffffff;
                --text-primary: #2c3e50;
                --text-secondary: #666666;
                --border-color: #e1e4e8;
                --sidebar-width: 250px;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, -apple-system, sans-serif;
                background: var(--background-color);
                color: var(--text-primary);
                min-height: 100vh;
                display: flex;
            }
            
            .wrapper {
                display: flex;
                min-height: 100vh;
            }
            
            /* Sidebar */
            .sidebar {
                width: var(--sidebar-width);
                background: var(--surface-color);
                border-right: 1px solid var(--border-color);
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 24px 20px;
                background: var(--surface-color);
                border-bottom: 1px solid var(--border-color);
            }

            .sidebar-header h2 {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 4px;
            }

            .sidebar-header p {
                font-size: 0.875rem;
                color: var(--text-secondary);
            }

            .sidebar-menu {
                list-style: none;
                padding: 12px 0;
            }

            .sidebar-menu li {
                margin: 2px 12px;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 12px 16px;
                color: var(--text-secondary);
                text-decoration: none;
                border-radius: 6px;
                transition: all 0.2s ease;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .sidebar-menu a:hover {
                background: var(--background-color);
                color: var(--text-primary);
            }

            .sidebar-menu a.active {
                background: var(--background-color);
                color: var(--accent-color);
                font-weight: 600;
            }
            
            .content {
                flex: 1;
                padding: 20px;
                transition: all 0.3s ease;
            }
            
            .toggle-sidebar {
                display: none;
                position: fixed;
                top: 20px;
                left: 20px;
                z-index: 1001;
                background: var(--primary-color);
                border: none;
                color: white;
                padding: 10px;
                border-radius: 5px;
            }
            
            @media (max-width: 768px) {
                .sidebar {
                    position: fixed;
                    height: 100vh;
                    margin-left: calc(-1 * var(--sidebar-width));
                }
                
                .sidebar.active {
                    margin-left: 0;
                }
                
                .toggle-sidebar {
                    display: block;
                }
            }
            h2 {
                color: #333;
            }
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }
            
            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            
            .stat-card h3 {
                margin: 0;
                color: var(--secondary-color);
                font-size: 0.9rem;
                text-transform: uppercase;
            }
            
            .stat-card .value {
                font-size: 2rem;
                font-weight: bold;
                color: var(--primary-color);
                margin: 10px 0;
            }
            
            .content {
                flex: 1;
                margin-left: var(--sidebar-width);
                padding: 32px;
                max-width: 1200px;
            }

            .table-container {
                background: var(--surface-color);
                border-radius: 8px;
                border: 1px solid var(--border-color);
                margin-top: 24px;
            }
            
            .table-header {
                padding: 16px 24px;
                border-bottom: 1px solid var(--border-color);
            }
            
            .table-header h2 {
                font-size: 1.125rem;
                font-weight: 600;
                color: var(--text-primary);
                margin: 0;
            }
            
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
            }
            
            th, td {
                padding: 12px 24px;
                text-align: left;
                border-bottom: 1px solid var(--border-color);
                font-size: 0.875rem;
            }
            
            th {
                color: var(--text-secondary);
                font-weight: 500;
                background: var(--background-color);
            }
            
            tr:hover {
                background: var(--background-color);
            }
            
            .btn {
                padding: 6px 12px;
                border-radius: 6px;
                border: 1px solid transparent;
                cursor: pointer;
                font-weight: 500;
                font-size: 0.875rem;
                transition: all 0.2s;
            }
            
            .btn.approve {
                background: #e8f5e9;
                color: #2e7d32;
                border-color: #a5d6a7;
            }
            
            .btn.approve:hover {
                background: #c8e6c9;
            }
            
            .btn.reject {
                background: #ffebee;
                color: #c62828;
                border-color: #ef9a9a;
            }
            
            .btn.reject:hover {
                background: #ffcdd2;
            }

            .btn.kick {
                background: #f5f5f5;
                color: #d32f2f;
                border-color: #e0e0e0;
            }
            
            .btn.kick:hover {
                background: #fafafa;
                border-color: #d32f2f;
            }
            
            .status-badge {
                display: inline-flex;
                align-items: center;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 0.75rem;
                font-weight: 500;
                line-height: 1;
            }
            
            .status-badge.pending {
                background: #fff3e0;
                color: #f57c00;
                border: 1px solid #ffe0b2;
            }
            
            .status-badge.approved {
                background: #e8f5e9;
                color: #2e7d32;
                border: 1px solid #a5d6a7;
            }
            
            .status-badge.rejected {
                background: #ffebee;
                color: #c62828;
                border: 1px solid #ef9a9a;
            }

            /* Stats Grid */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                gap: 24px;
                margin-bottom: 32px;
            }

            .stat-card {
                background: var(--surface-color);
                padding: 24px;
                border-radius: 8px;
                border: 1px solid var(--border-color);
            }

            .stat-card h3 {
                font-size: 0.875rem;
                color: var(--text-secondary);
                margin-bottom: 8px;
                font-weight: 500;
            }

            .stat-card .value {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-primary);
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <%
                // Get clubId from request parameter or session
                String clubId = request.getParameter("clubId");
                if (clubId == null || clubId.isEmpty()) {
                    clubId = (String) session.getAttribute("clubId");
                }
            %>
            <div class="sidebar-header">
                <h2><i class="bi bi-person-badge"></i> Leader Dashboard</h2>
                <p>${club.clubName}</p>
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/leader/dashboard?clubId=<%=clubId%>"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/dashboard')}">class="active"</c:if>>
                        <i class="bi bi-speedometer2"></i> Overview
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/club/members?clubId=<%=clubId%>"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/club/members')}">class="active"</c:if>>
                        <i class="bi bi-people"></i> Members
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/events?clubId=<%=clubId%>"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/events')}">class="active"</c:if>>
                        <i class="bi bi-calendar3"></i> Events
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/rules?clubId=<%=clubId%>"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/rules')}">class="active"</c:if>>
                        <i class="bi bi-file-text"></i> Rules
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/news?clubId=<%=clubId%>"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/news')}">class="active"</c:if>>
                        <i class="bi bi-newspaper"></i> News
                    </a>
                </li>
            </ul>
        </div>
            
            <div class="content">
                <div class="stats-grid">
                    <div class="stat-card">
                        <h3>Total Members</h3>
                        <div class="value"><%= members != null ? members.size() : 0 %></div>
                    </div>
                    <div class="stat-card">
                        <h3>Pending Approvals</h3>
                        <div class="value"><%= members != null ? members.stream().filter(m -> "Pending".equalsIgnoreCase(m.getJoinStatus())).count() : 0 %></div>
                    </div>
                    <div class="stat-card">
                        <h3>Active Members</h3>
                        <div class="value"><%= members != null ? members.stream().filter(m -> "Approved".equalsIgnoreCase(m.getJoinStatus())).count() : 0 %></div>
                    </div>
                </div>

                <div class="table-container">
                    <div class="table-header">
                        <h2>Club Members List</h2>
                    </div>
                    
                    <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Status</th>
                    <th>Joined At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (members != null && !members.isEmpty()) {
           for (Member m : members) { %>
                <tr>
                    <td><%= m.getMemberID() %></td>
                    <td><%= m.getUserName() %></td>
                    <td><%= m.getEmail() %></td>
                    <td>
                        <span class="status-badge <%= m.getJoinStatus().toLowerCase() %>">
                            <%= m.getJoinStatus() %>
                        </span>
                    </td>
                    <td><%= m.getJoinedAt() %></td>
                    <td>
                        <% if ("Pending".equalsIgnoreCase(m.getJoinStatus())) { %>
                        <form method="post" action="<%= request.getContextPath() %>/club/members" style="display:inline;">
                            <input type="hidden" name="memberId" value="<%= m.getMemberID() %>">
                            <input type="hidden" name="action" value="approve">
                            <button type="submit" class="btn approve">Approve</button>
                        </form>
                        <form method="post" action="<%= request.getContextPath() %>/club/members" style="display:inline;">
                            <input type="hidden" name="memberId" value="<%= m.getMemberID() %>">
                            <input type="hidden" name="action" value="reject">
                            <button type="submit" class="btn reject">Reject</button>
                        </form>
                        <% } else if ("Approved".equalsIgnoreCase(m.getJoinStatus())) { %>
                        <form method="post" action="<%= request.getContextPath() %>/club/members" style="display:inline;" 
                              onsubmit="return confirm('Are you sure you want to remove this member from the club? This action cannot be undone.');">
                            <input type="hidden" name="memberId" value="<%= m.getMemberID() %>">
                            <input type="hidden" name="action" value="kick">
                            <button type="submit" class="btn kick">Remove from Club</button>
                        </form>
                        <% } else { %>
                        <em>No actions</em>
                        <% } %>
                    </td>
                </tr>
                <% } } else { %>
                <tr><td colspan="6">No members found.</td></tr>
                <% } %>
            </tbody>
        </table>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.querySelector('.toggle-sidebar').addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('active');
            });

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(e) {
                const sidebar = document.querySelector('.sidebar');
                const toggleBtn = document.querySelector('.toggle-sidebar');
                
                if (window.innerWidth <= 768) {
                    if (!sidebar.contains(e.target) && !toggleBtn.contains(e.target)) {
                        sidebar.classList.remove('active');
                    }
                }
            });

            // Handle window resize
            window.addEventListener('resize', function() {
                if (window.innerWidth > 768) {
                    document.querySelector('.sidebar').classList.remove('active');
                }
            });
        </script>
    </body>
</html>
