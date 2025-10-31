<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Events - ${club.clubName}</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 40px 20px;
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
            }

            .header {
                background: white;
                padding: 30px;
                border-radius: 20px;
                margin-bottom: 30px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .header h1 {
                font-size: 28px;
                font-weight: 700;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .header-actions {
                display: flex;
                gap: 15px;
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 12px;
                font-weight: 600;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 25px rgba(102, 126, 234, 0.5);
            }

            .btn-back {
                background: #f7fafc;
                color: #2d3748;
                border: 2px solid #e2e8f0;
            }

            .btn-back:hover {
                background: #edf2f7;
                transform: translateY(-2px);
            }

            .events-section {
                background: white;
                border-radius: 20px;
                padding: 35px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            thead {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            thead th {
                padding: 16px 18px;
                text-align: left;
                color: white;
                font-weight: 600;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
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
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.3px;
                display: inline-block;
            }

            .badge-pending {
                background: #fef5e7;
                color: #f39c12;
            }

            .badge-approved {
                background: #d4f4dd;
                color: #22543d;
            }

            .badge-completed {
                background: #e0e7ff;
                color: #4c51bf;
            }

            .badge-cancelled {
                background: #fee;
                color: #c53030;
            }

            .action-buttons {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
            }

            .btn-sm {
                padding: 8px 16px;
                font-size: 13px;
            }

            .btn-info {
                background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
                color: white;
            }

            .btn-info:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(52, 152, 219, 0.4);
            }

            .btn-warning {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                color: white;
            }

            .btn-warning:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(243, 156, 18, 0.4);
            }

            .btn-danger {
                background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
                color: white;
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(245, 101, 101, 0.4);
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
                table {
                    font-size: 13px;
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
        <div class="container">
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