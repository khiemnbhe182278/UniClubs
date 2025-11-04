<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Events - ${club.clubName}</title>
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
                --success-color: #2ecc71;
                --warning-color: #f1c40f;
                --danger-color: #e74c3c;
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
                display: flex;
                align-items: center;
                gap: 8px;
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

            /* Main Content */
            .main-content {
                flex: 1;
                margin-left: var(--sidebar-width);
                padding: 32px;
                max-width: 1400px;
            }

            /* Top Bar */
            .header {
                background: var(--surface-color);
                padding: 24px;
                border-radius: 8px;
                margin-bottom: 32px;
                border: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header h1 {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-primary);
            }

            .header-actions {
                display: flex;
                gap: 15px;
            }

            .btn {
                padding: 8px 16px;
                border: 1px solid transparent;
                border-radius: 6px;
                font-weight: 500;
                font-size: 0.875rem;
                cursor: pointer;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
            }

            .btn-primary {
                background: var(--accent-color);
                color: white;
                border-color: var(--accent-color);
            }

            .btn-primary:hover {
                opacity: 0.9;
            }

            .btn-back {
                background: var(--background-color);
                color: var(--text-primary);
                border-color: var(--border-color);
            }

            .btn-back:hover {
                background: var(--background-color);
                border-color: var(--accent-color);
            }

            .events-section {
                background: var(--surface-color);
                border-radius: 8px;
                padding: 24px;
                border: 1px solid var(--border-color);
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-top: 16px;
            }

            thead th {
                padding: 12px 24px;
                text-align: left;
                color: var(--text-secondary);
                font-weight: 500;
                font-size: 0.875rem;
                background: var(--background-color);
                border-bottom: 1px solid var(--border-color);
            }

            thead th:first-child {
                border-top-left-radius: 12px;
            }

            thead th:last-child {
                border-top-right-radius: 12px;
            }

            tbody tr {
                border-bottom: 1px solid #e2e8f0;
                transition: all 0.3s ease;
            }

            tbody tr:hover {
                background: linear-gradient(90deg, rgba(102, 126, 234, 0.03) 0%, rgba(118, 75, 162, 0.03) 100%);
            }

            tbody tr:last-child {
                border-bottom: none;
            }

            tbody td {
                padding: 18px;
                color: #4a5568;
                font-size: 14px;
                vertical-align: middle;
            }

            tbody td strong {
                color: #2d3748;
                font-weight: 600;
            }

            .event-name {
                font-weight: 700;
                color: #2d3748;
                font-size: 15px;
                margin-bottom: 4px;
            }

            .event-location {
                color: #718096;
                font-size: 13px;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .badge {
                display: inline-flex;
                align-items: center;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 0.75rem;
                font-weight: 500;
                line-height: 1;
            }

            .badge-pending {
                background: #fff3e0;
                color: #f57c00;
                border: 1px solid #ffe0b2;
            }

            .badge-approved {
                background: #e8f5e9;
                color: #2e7d32;
                border: 1px solid #a5d6a7;
            }

            .badge-completed {
                background: #e3f2fd;
                color: #1976d2;
                border: 1px solid #90caf9;
            }

            .badge-cancelled {
                background: #ffebee;
                color: #c62828;
                border: 1px solid #ef9a9a;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
            }

            .btn-sm {
                padding: 6px 12px;
                font-size: 0.8125rem;
            }

            .btn-info {
                background: #e3f2fd;
                color: #1976d2;
                border-color: #90caf9;
            }

            .btn-info:hover {
                background: #bbdefb;
            }

            .btn-warning {
                background: #fff3e0;
                color: #f57c00;
                border-color: #ffe0b2;
            }

            .btn-warning:hover {
                background: #ffe0b2;
            }

            .btn-danger {
                background: #ffebee;
                color: #c62828;
                border-color: #ef9a9a;
            }

            .btn-danger:hover {
                background: #ffcdd2;
            }

            .participants-info {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 13px;
            }

            .participants-count {
                font-weight: 600;
                color: #667eea;
            }

            .participants-max {
                color: #718096;
            }

            .progress-bar {
                width: 100%;
                height: 6px;
                background: #e2e8f0;
                border-radius: 3px;
                overflow: hidden;
                margin-top: 6px;
            }

            .progress-fill {
                height: 100%;
                background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
                transition: width 0.3s ease;
            }

            .no-data {
                text-align: center;
                padding: 80px 40px;
            }

            .no-data::before {
                content: "📅";
                font-size: 72px;
                display: block;
                margin-bottom: 20px;
                opacity: 0.5;
            }

            .no-data p {
                color: #718096;
                font-size: 18px;
                font-weight: 500;
                margin-bottom: 25px;
            }

            .success-message {
                background: #d4f4dd;
                color: #22543d;
                padding: 14px 18px;
                border-radius: 12px;
                margin-bottom: 20px;
                font-weight: 500;
                border-left: 4px solid #48bb78;
            }

            @media (max-width: 1200px) {
                .main-content {
                    max-width: 100%;
                }
            }

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
                    position: fixed;
                }
                .sidebar.active {
                    transform: translateX(0);
                }
                .main-content {
                    margin-left: 0;
                    padding: 16px;
                }
                .header {
                    flex-direction: column;
                    gap: 16px;
                    text-align: center;
                }
                .header-actions {
                    justify-content: center;
                }
                .action-buttons {
                    flex-direction: column;
                }
                .btn {
                    width: 100%;
                    justify-content: center;
                }
                table {
                    font-size: 0.8125rem;
                }

                thead th,
                tbody td {
                    padding: 12px 10px;
                }
            }

            @media (max-width: 768px) {
                .header {
                    flex-direction: column;
                    gap: 20px;
                    text-align: center;
                }

                .header-actions {
                    width: 100%;
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                    justify-content: center;
                }

                .events-section {
                    padding: 20px;
                    overflow-x: auto;
                }

                table {
                    min-width: 800px;
                }

                .action-buttons {
                    flex-direction: column;
                }
            }

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

            .events-section {
                animation: fadeIn 0.5s ease;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h2><i class="bi bi-person-badge"></i> Leader Dashboard</h2>
                <p>${club.clubName}</p>
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/dashboard')}">class="active"</c:if>>
                        <i class="bi bi-speedometer2"></i> Overview
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/club/members?clubId=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/members')}">class="active"</c:if>>
                        <i class="bi bi-people"></i> Members
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/events?clubId=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/events')}">class="active"</c:if>>
                        <i class="bi bi-calendar3"></i> Events
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/rules?clubId=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/rules')}">class="active"</c:if>>
                        <i class="bi bi-file-text"></i> Rules
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/news?clubId=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/news')}">class="active"</c:if>>
                        <i class="bi bi-newspaper"></i> News
                    </a>
                </li>
            </ul>
        </div>
        
        <div class="main-content">
            <div class="header">
                <div>
                    <h1>📅 Manage Events</h1>
                    <p style="color: #718096; margin-top: 5px; font-weight: 500;">${club.clubName}</p>
                </div>
                <div class="header-actions">
                    <a href="${pageContext.request.contextPath}/create-event?clubId=${club.clubID}" class="btn btn-primary">
                        ➕ Create Event
                    </a>
                    <a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}" class="btn btn-back">
                        ← Back
                    </a>
                </div>
            </div>

            <c:if test="${param.success == 'deleted'}">
                <div class="success-message">
                    ✓ Event deleted successfully!
                </div>
            </c:if>

            <div class="events-section">
                <c:choose>
                    <c:when test="${not empty events}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Event Details</th>
                                    <th>Date & Time</th>
                                    <th>Participants</th>
                                    <th>Status</th>
                                    <th style="text-align: center;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="event" items="${events}">
                                    <tr>
                                        <td>
                                            <div class="event-name">${event.eventName}</div>
                                            <div class="event-location">
                                                📍 ${event.location}
                                            </div>
                                        </td>
                                        <td>
                                            <div style="margin-bottom: 4px;">
                                                📅 <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy"/>
                                            </div>
                                            <div style="color: #718096; font-size: 13px;">
                                                🕐 <fmt:formatDate value="${event.eventDate}" pattern="HH:mm"/>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="participants-info">
                                                <span class="participants-count">${event.currentParticipants}</span>
                                                <span class="participants-max">/ ${event.maxParticipants} max</span>
                                            </div>
                                            <div class="progress-bar">
                                                <div class="progress-fill" 
                                                     style="width: ${(event.currentParticipants * 100.0 / event.maxParticipants)}%">
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge badge-${event.status.toLowerCase()}">
                                                ${event.status}
                                            </span>
                                        </td>
                                        <td style="text-align: center;">
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/leader/event-participants?eventId=${event.eventID}" 
                                                   class="btn btn-info btn-sm">
                                                    👁️ View
                                                </a>
                                                <a href="${pageContext.request.contextPath}/leader/update-event?id=${event.eventID}&clubId=${club.clubID}" 
                                                   class="btn btn-warning btn-sm">
                                                    ✏️ Edit
                                                </a>
                                                <form method="post" 
                                                      action="${pageContext.request.contextPath}/leader/delete-event" 
                                                      style="display: inline;">
                                                    <input type="hidden" name="eventId" value="${event.eventID}">
                                                    <input type="hidden" name="clubId" value="${club.clubID}">
                                                    <button type="submit" 
                                                            class="btn btn-danger btn-sm" 
                                                            onclick="return confirm('Are you sure you want to delete this event? This action cannot be undone.')">
                                                        🗑️ Delete
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <p>No events yet</p>
                            <a href="${pageContext.request.contextPath}/create-event?clubId=${club.clubID}" 
                               class="btn btn-primary">
                                ➕ Create Your First Event
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>