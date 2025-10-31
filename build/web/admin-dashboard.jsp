<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - UniClubs</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
                display: flex;
            }

            .sidebar {
                width: 250px;
                background: #2c3e50;
                min-height: 100vh;
                color: white;
                position: fixed;
            }

            .sidebar-header {
                padding: 2rem;
                background: #34495e;
                text-align: center;
            }

            .sidebar-header h2 {
                font-size: 1.5rem;
            }

            .sidebar-menu {
                list-style: none;
                padding: 1rem 0;
            }

            .sidebar-menu li {
                padding: 0;
            }

            .sidebar-menu a {
                display: block;
                padding: 1rem 2rem;
                color: white;
                text-decoration: none;
                transition: background 0.3s;
            }

            .sidebar-menu a:hover,
            .sidebar-menu a.active {
                background: #34495e;
            }

            .main-content {
                margin-left: 250px;
                flex: 1;
                padding: 2rem;
            }

            .top-bar {
                background: white;
                padding: 1.5rem 2rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                position: relative;
                overflow: hidden;
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 5px;
                height: 100%;
            }

            .stat-card.pending::before {
                background: #f39c12;
            }

            .stat-card.members::before {
                background: #3498db;
            }

            .stat-card.events::before {
                background: #9b59b6;
            }

            .stat-card.users::before {
                background: #2ecc71;
            }

            .stat-card .icon {
                font-size: 3rem;
                opacity: 0.2;
                position: absolute;
                right: 1rem;
                top: 50%;
                transform: translateY(-50%);
            }

            .stat-card h3 {
                font-size: 2.5rem;
                margin-bottom: 0.5rem;
                color: #2c3e50;
            }

            .stat-card p {
                color: #7f8c8d;
                font-size: 1rem;
            }

            .quick-actions {
                background: white;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .quick-actions h2 {
                margin-bottom: 1.5rem;
                color: #2c3e50;
            }

            .action-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
            }

            .action-btn {
                display: block;
                padding: 1.5rem;
                background: #3498db;
                color: white;
                text-decoration: none;
                border-radius: 10px;
                text-align: center;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .action-btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
            }

            .action-btn.clubs {
                background: #f39c12;
            }

            .action-btn.members {
                background: #9b59b6;
            }

            .action-btn.events {
                background: #e74c3c;
            }

            .action-btn.users {
                background: #2ecc71;
            }

            .btn-logout {
                background: #e74c3c;
                color: white;
                padding: 0.7rem 1.5rem;
                border-radius: 5px;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 Admin Panel</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/clubs">🏛️ Manage Clubs</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/members">👥 Manage Members</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/events">📅 Manage Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">👤 Manage Users</a></li>
                <li><a href="${pageContext.request.contextPath}/home">🏠 Back to Site</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="top-bar">
                <h1>Welcome, ${sessionScope.userName}!</h1>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
            </div>

            <div class="stats-grid">
                <div class="stat-card pending">
                    <div class="icon">⏳</div>
                    <h3>${stats.pendingClubs}</h3>
                    <p>Pending Clubs</p>
                </div>
                <div class="stat-card members">
                    <div class="icon">👥</div>
                    <h3>${stats.pendingMembers}</h3>
                    <p>Pending Members</p>
                </div>
                <div class="stat-card events">
                    <div class="icon">📅</div>
                    <h3>${stats.pendingEvents}</h3>
                    <p>Pending Events</p>
                </div>
                <div class="stat-card users">
                    <div class="icon">👤</div>
                    <h3>${stats.totalUsers}</h3>
                    <p>Active Users</p>
                </div>
            </div>

            <div class="quick-actions">
                <h2>Quick Actions</h2>
                <div class="action-grid">
                    <a href="${pageContext.request.contextPath}/admin/clubs" class="action-btn clubs">
                        Approve Clubs
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/members" class="action-btn members">
                        Approve Members
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/events" class="action-btn events">
                        Approve Events
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="action-btn users">
                        Manage Users
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>