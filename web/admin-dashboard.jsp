<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - UniClubs</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: #f6f8fb;
                min-height: 100vh;
                display: flex;
            }

            /* Sidebar */
            .sidebar {
                width: 280px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 20px;
                background: #2b6cb0;
                color: white;
            }

            .sidebar-header h2 {
                font-size: 24px;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .sidebar-menu {
                list-style: none;
                padding: 20px 0;
            }

            .sidebar-menu li {
                margin: 5px 15px;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 14px 18px;
                color: #4a5568;
                text-decoration: none;
                border-radius: 12px;
                transition: all 0.3s ease;
                font-weight: 500;
                font-size: 15px;
            }

            .sidebar-menu a:hover,
            .sidebar-menu a.active {
                background: #eef2ff;
                color: #2b6cb0;
                transform: translateX(4px);
            }

            /* Main Content */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 40px;
                min-height: 100vh;
            }

            /* Top Bar */
            .top-bar {
                background: #ffffff;
                padding: 20px;
                border-radius: 12px;
                margin-bottom: 20px;
                box-shadow: 0 6px 18px rgba(16,24,40,0.06);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .welcome-section h1 {
                font-size: 28px;
                font-weight: 700;
                color: #1f2937;
                margin-bottom: 6px;
            }

            .welcome-section p {
                color: #718096;
                font-size: 14px;
            }

            /* Use shared .btn / .btn-primary from admin.css */

            .btn-logout:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(245, 101, 101, 0.4);
            }

            /* Stats Grid */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 28px;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
                position: relative;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
            }

            .stat-card.pending::before {
                background: linear-gradient(90deg, #f39c12 0%, #e67e22 100%);
            }

            .stat-card.members::before {
                background: linear-gradient(90deg, #3498db 0%, #2980b9 100%);
            }

            .stat-card.events::before {
                background: linear-gradient(90deg, #9b59b6 0%, #8e44ad 100%);
            }

            .stat-card.users::before {
                background: linear-gradient(90deg, #2ecc71 0%, #27ae60 100%);
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                border-radius: 16px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 30px;
                margin-bottom: 15px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .stat-card.pending .stat-icon {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            }

            .stat-card.members .stat-icon {
                background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            }

            .stat-card.events .stat-icon {
                background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
            }

            .stat-card.users .stat-icon {
                background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            }

            .stat-content h3 {
                font-size: 42px;
                font-weight: 800;
                color: #2d3748;
                margin-bottom: 8px;
                line-height: 1;
            }

            .stat-content p {
                color: #718096;
                font-size: 15px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .stat-trend {
                margin-top: 12px;
                padding-top: 12px;
                border-top: 1px solid #e2e8f0;
                font-size: 13px;
                color: #2ecc71;
                font-weight: 600;
            }

            /* Quick Actions */
            .quick-actions {
                background: white;
                padding: 35px;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            }

            .quick-actions-header {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 25px;
            }

            .quick-actions-header h2 {
                font-size: 24px;
                font-weight: 700;
                color: #2d3748;
            }

            .action-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 20px;
            }

            .action-btn {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 30px 20px;
                border-radius: 16px;
                text-decoration: none;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                color: white;
                font-weight: 600;
                font-size: 16px;
                text-align: center;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .action-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(255, 255, 255, 0.1);
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }

            .action-btn:hover::before {
                transform: translateX(0);
            }

            .action-btn:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.2);
            }

            .action-btn.clubs {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            }

            .action-btn.members {
                background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
            }

            .action-btn.events {
                background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            }

            .action-btn.users {
                background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            }

            .action-icon {
                font-size: 48px;
                margin-bottom: 15px;
            }

            /* Animations */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .stat-card, .quick-actions, .top-bar {
                animation: fadeIn 0.6s ease;
            }

            .stat-card:nth-child(1) {
                animation-delay: 0.1s;
            }
            .stat-card:nth-child(2) {
                animation-delay: 0.2s;
            }
            .stat-card:nth-child(3) {
                animation-delay: 0.3s;
            }
            .stat-card:nth-child(4) {
                animation-delay: 0.4s;
            }

            /* Responsive */
            @media (max-width: 1024px) {
                .sidebar {
                    width: 240px;
                }
                .main-content {
                    margin-left: 240px;
                    padding: 20px;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                }
                .main-content {
                    margin-left: 0;
                    padding: 15px;
                }
                .top-bar {
                    flex-direction: column;
                    gap: 15px;
                    text-align: center;
                }
                .stats-grid {
                    grid-template-columns: 1fr;
                }
            }

            /* Scrollbar */
            ::-webkit-scrollbar {
                width: 8px;
                height: 8px;
            }

            ::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            ::-webkit-scrollbar-thumb {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 10px;
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
                <li><a href="${pageContext.request.contextPath}/admin/events">📅 Manage Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">👤 Manage Users</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="top-bar">
                <div class="welcome-section">
                    <h1>Welcome back, ${sessionScope.userName}!</h1>
                    <p>Here's what's happening with your platform today</p>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                    🚪 Logout
                </a>
            </div>

            <div class="stats-grid">
                <div class="stat-card pending">
                    <div class="stat-icon">⏳</div>
                    <div class="stat-content">
                        <h3>${stats.pendingClubs}</h3>
                        <p>Pending Clubs</p>
                        <div class="stat-trend">Awaiting approval</div>
                    </div>
                </div>
                <div class="stat-card members">
                    <div class="stat-icon">👥</div>
                    <div class="stat-content">
                        <h3>${stats.pendingMembers}</h3>
                        <p>Pending Members</p>
                        <div class="stat-trend">New requests</div>
                    </div>
                </div>
                <div class="stat-card events">
                    <div class="stat-icon">📅</div>
                    <div class="stat-content">
                        <h3>${stats.pendingEvents}</h3>
                        <p>Pending Events</p>
                        <div class="stat-trend">Needs review</div>
                    </div>
                </div>
                <div class="stat-card users">
                    <div class="stat-icon">✓</div>
                    <div class="stat-content">
                        <h3>${stats.totalUsers}</h3>
                        <p>Active Users</p>
                        <div class="stat-trend">System-wide</div>
                    </div>
                </div>
            </div>

            <div class="quick-actions">
                <div class="quick-actions-header">
                    <h2>⚡ Quick Actions</h2>
                </div>
                <div class="action-grid">
                    <a href="${pageContext.request.contextPath}/admin/clubs" class="action-btn clubs">
                        <div class="action-icon">🏛️</div>
                        Approve Clubs
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/members" class="action-btn members">
                        <div class="action-icon">👥</div>
                        Approve Members
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/events" class="action-btn events">
                        <div class="action-icon">📅</div>
                        Approve Events
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="action-btn users">
                        <div class="action-icon">👤</div>
                        Manage Users
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>