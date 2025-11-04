<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Events - Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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
                color: #1f2937;
            }

            /* Sidebar Styles */
            .sidebar {
                width: 280px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                transition: all 0.3s ease;
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

            .sidebar-menu a:hover {
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

            .page-header {
                background: #ffffff;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 6px 18px rgba(16,24,40,0.06);
                margin-bottom: 20px;
            }

            .page-header h1 {
                color: #2d3748;
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 8px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .page-header p {
                color: #718096;
                font-size: 16px;
            }

            /* Table Container */
            .table-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead { background: #f1f5f9; }

            thead th {
                padding: 16px 18px;
                text-align: left;
                color: #334155;
                font-weight: 600;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            tbody tr {
                border-bottom: 1px solid #e2e8f0;
                transition: all 0.3s ease;
            }

            tbody tr:hover {
                background: #f7fafc;
                transform: scale(1.01);
            }

            tbody tr:last-child {
                border-bottom: none;
            }

            tbody td {
                padding: 20px;
                color: #4a5568;
                font-size: 14px;
            }

            tbody td strong {
                color: #2d3748;
                font-weight: 600;
                font-size: 15px;
            }

            /* Buttons */
            .btn {
                padding: 8px 14px;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                font-size: 13px;
                cursor: pointer;
                transition: transform 0.15s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .btn-approve {
                background: #10b981;
                color: white;
                margin-right: 8px;
                padding: 8px 12px;
                border-radius: 8px;
            }

            .btn-reject {
                background: #ef4444;
                color: white;
                padding: 8px 12px;
                border-radius: 8px;
            }

            .btn-reject:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(245, 101, 101, 0.4);
            }

            /* No Data State */
            .no-data {
                padding: 80px 40px;
                text-align: center;
            }

            .no-data h3 {
                color: #718096;
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 12px;
            }

            .no-data::before {
                content: "📭";
                font-size: 64px;
                display: block;
                margin-bottom: 20px;
            }

            /* Badge for Club Name */
            .club-badge {
                display: inline-block;
                padding: 6px 14px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
            }

            /* Event Description */
            .event-desc {
                max-width: 300px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            /* Date Badge */
            .date-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 14px;
                background: #edf2f7;
                border-radius: 10px;
                font-weight: 500;
                color: #2d3748;
            }

            /* Responsive Design */
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

                .sidebar.active {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0;
                    padding: 15px;
                }

                table {
                    font-size: 12px;
                }

                thead th, tbody td {
                    padding: 12px 8px;
                }

                .btn {
                    padding: 8px 12px;
                    font-size: 11px;
                }
            }

            /* Animation */
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

            .table-container {
                animation: fadeIn 0.6s ease;
            }

            /* Scrollbar Styling */
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

            ::-webkit-scrollbar-thumb:hover {
                background: #764ba2;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 Admin Panel</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/clubs">🏛️ Manage Clubs</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/events">📅 Manage Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">👤 Manage Users</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1>Manage Pending Events</h1>
                <p>Review and approve event requests from clubs</p>
            </div>

            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty pendingEvents}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Event Name</th>
                                    <th>Club</th>
                                    <th>Description</th>
                                    <th>Event Date</th>
                                    <th style="text-align: center;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="event" items="${pendingEvents}">
                                    <tr>
                                        <td><strong>${event.eventName}</strong></td>
                                        <td>
                                            <span class="club-badge">${event.clubName}</span>
                                        </td>
                                        <td>
                                            <div class="event-desc" title="${event.description}">
                                                ${event.description}
                                            </div>
                                        </td>
                                        <td>
                                            <span class="date-badge">
                                                📅 <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy HH:mm"/>
                                            </span>
                                        </td>
                                        <td style="text-align: center;">
                                            <form method="post" style="display: inline;">
                                                <input type="hidden" name="eventId" value="${event.eventID}">
                                                <button type="submit" name="action" value="approve" class="btn btn-approve">
                                                    ✓ Approve
                                                </button>
                                                <button type="submit" name="action" value="reject" class="btn btn-reject">
                                                    ✗ Reject
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <h3>No pending events to review</h3>
                            <p style="color: #a0aec0; margin-top: 8px;">All events have been processed</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>