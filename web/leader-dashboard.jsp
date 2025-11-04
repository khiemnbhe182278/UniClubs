<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Club Leader Dashboard - UniClubs</title>
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
            .top-bar {
                background: var(--surface-color);
                padding: 24px;
                border-radius: 8px;
                margin-bottom: 32px;
                border: 1px solid var(--border-color);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .welcome-section h1 {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-primary);
            }

            .club-selector {
                padding: 8px 16px;
                border: 1px solid var(--border-color);
                border-radius: 6px;
                font-size: 0.875rem;
                font-family: inherit;
                color: var(--text-primary);
                background: var(--surface-color);
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .club-selector:hover {
                border-color: var(--accent-color);
            }

            .club-selector:focus {
                outline: none;
                border-color: var(--accent-color);
                box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.1);
            }

            .club-selector:focus {
                outline: none;
                border-color: #2193b0;
                box-shadow: 0 0 0 3px rgba(33, 147, 176, 0.1);
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
                transition: all 0.2s ease;
            }

            .stat-card:hover {
                border-color: var(--accent-color);
                transform: translateY(-2px);
            }

            .stat-icon {
                width: 48px;
                height: 48px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                margin-bottom: 16px;
                background: var(--background-color);
                color: var(--accent-color);
            }

            .stat-content h3 {
                font-size: 1.75rem;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 4px;
            }

            .stat-content p {
                color: var(--text-secondary);
                font-size: 0.875rem;
                font-weight: 500;
            }

            /* Section Styles */
            .section {
                background: var(--surface-color);
                padding: 24px;
                border-radius: 8px;
                border: 1px solid var(--border-color);
                margin-bottom: 24px;
            }

            /* Section */
            .section {
                background: white;
                padding: 35px;
                border-radius: 20px;
                margin-bottom: 30px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
                animation: fadeIn 0.6s ease;
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                padding-bottom: 20px;
                border-bottom: 2px solid #e2e8f0;
            }

            .section-header h2 {
                font-size: 22px;
                font-weight: 700;
                color: #2d3748;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            /* Table */
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
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

            tbody tr {
                transition: all 0.2s ease;
            }

            tbody tr:hover {
                background: var(--background-color);
            }

            tbody tr:last-child td {
                border-bottom: none;
            }

            tbody td {
                padding: 12px 24px;
                color: var(--text-primary);
                font-size: 0.875rem;
                border-bottom: 1px solid var(--border-color);
                vertical-align: middle;
            }

            tbody td strong {
                color: var(--text-primary);
                font-weight: 500;
            }

            /* Buttons */
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
                gap: 6px;
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

            .btn-success {
                background: #e8f5e9;
                color: #2e7d32;
                border-color: #a5d6a7;
                margin-right: 8px;
            }

            .btn-success:hover {
                background: #c8e6c9;
            }

            .btn-danger {
                background: #ffebee;
                color: #c62828;
                border-color: #ef9a9a;
            }

            .btn-danger:hover {
                background: #ffcdd2;
            }

            .btn-warning {
                background: #fff3e0;
                color: #f57c00;
                border-color: #ffe0b2;
                margin-right: 8px;
            }

            .btn-warning:hover {
                background: #ffe0b2;
            }

            /* Badge */
            .badge {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .badge-pending {
                background: #fef5e7;
                color: #f39c12;
            }

            .badge-approved {
                background: #d4f4dd;
                color: #22543d;
            }

            .badge-attended {
                background: #d1ecf1;
                color: #0c5460;
            }

            /* No Data */
            .no-data {
                text-align: center;
                padding: 60px 40px;
            }

            .no-data::before {
                content: "📭";
                font-size: 56px;
                display: block;
                margin-bottom: 15px;
                opacity: 0.5;
            }

            .no-data p {
                color: #718096;
                font-size: 16px;
                font-weight: 500;
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

            .stat-card:nth-child(1) {
                animation: fadeIn 0.6s ease 0.1s both;
            }
            .stat-card:nth-child(2) {
                animation: fadeIn 0.6s ease 0.2s both;
            }
            .stat-card:nth-child(3) {
                animation: fadeIn 0.6s ease 0.3s both;
            }
            .stat-card:nth-child(4) {
                animation: fadeIn 0.6s ease 0.4s both;
            }

            /* Action Buttons Group */
            .action-buttons {
                display: flex;
                gap: 8px;
                flex-wrap: wrap;
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
                .section {
                    padding: 20px;
                }
                .section-header {
                    flex-direction: column;
                    gap: 15px;
                    align-items: flex-start;
                }
                table {
                    font-size: 12px;
                }
                thead th, tbody td {
                    padding: 10px 8px;
                }
                .action-buttons {
                    flex-direction: column;
                }
                .btn {
                    padding: 8px 12px;
                    font-size: 11px;
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
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                border-radius: 10px;
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
                    <a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/dashboard')}">class="active"</c:if>>
                        <i class="bi bi-speedometer2"></i> Overview
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/club/members?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/members')}">class="active"</c:if>>
                        <i class="bi bi-people"></i> Members
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/events?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/events')}">class="active"</c:if>>
                        <i class="bi bi-calendar3"></i> Events
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/rules?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/rules')}">class="active"</c:if>>
                        <i class="bi bi-file-text"></i> Rules
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/news?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/news')}">class="active"</c:if>>
                        <i class="bi bi-newspaper"></i> News
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content">
            <div class="top-bar">
                <div class="welcome-section">
                    <h1>Welcome back, ${sessionScope.userName}! 👋</h1>
                </div>
                <c:if test="${myClubs.size() > 1}">
                    <select class="club-selector" onchange="location = this.value">
                        <c:forEach var="c" items="${myClubs}">
                            <option value="?clubId=${c.clubID}" ${c.clubID == club.clubID ? 'selected' : ''}>
                                ${c.clubName}
                            </option>
                        </c:forEach>
                    </select>
                </c:if>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">👥</div>
                    <div class="stat-content">
                        <h3>${members.size()}</h3>
                        <p>Total Members</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">⏱</div>
                    <div class="stat-content">
                        <h3>${pendingMembers.size()}</h3>
                        <p>Pending Requests</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📅</div>
                    <div class="stat-content">
                        <h3>${events.size()}</h3>
                        <p>Total Events</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">💰</div>
                    <div class="stat-content">
                        <h3>$<fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="2"/></h3>
                        <p>Total Revenue</p>
                    </div>
                </div>
            </div>

            <div class="section">
                <div class="section-header">
                    <h2>📋 Pending Membership Requests</h2>
                </div>
                <c:choose>
                    <c:when test="${not empty pendingMembers}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Student Name</th>
                                    <th>Email</th>
                                    <th>Request Date</th>
                                    <th style="text-align: center;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="member" items="${pendingMembers}">
                                    <tr>
                                        <td><strong>${member.userName}</strong></td>
                                        <td>${member.email}</td>
                                        <td><fmt:formatDate value="${member.joinedAt}" pattern="MMM dd, yyyy"/></td>
                                        <td style="text-align: center;">
                                            <form method="post" action="${pageContext.request.contextPath}/leader/approve-member" style="display: inline;">
                                                <input type="hidden" name="memberId" value="${member.memberID}">
                                                <input type="hidden" name="clubId" value="${club.clubID}">
                                                <input type="hidden" name="clubID" value="${club.clubID}">
                                                <div class="action-buttons">
                                                    <button type="submit" name="action" value="approve" class="btn btn-success">
                                                        ✓ Approve
                                                    </button>
                                                    <button type="submit" name="action" value="reject" class="btn btn-danger">
                                                        ✗ Reject
                                                    </button>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <p>No pending membership requests</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section">
                <div class="section-header">
                    <h2>📅 Recent Events</h2>
                    <a href="${pageContext.request.contextPath}/create-event?clubId=${club.clubID}&amp;clubID=${club.clubID}" class="btn btn-primary">
                        ➕ Create New Event
                    </a>
                </div>
                <c:choose>
                    <c:when test="${not empty events}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Event Name</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th style="text-align: center;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="event" items="${events}" end="4">
                                    <tr>
                                        <td><strong>${event.eventName}</strong></td>
                                        <td><fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy HH:mm"/></td>
                                        <td><span class="badge badge-${event.status.toLowerCase()}">${event.status}</span></td>
                                        <td style="text-align: center;">
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/leader/event-participants?eventId=${event.eventID}" class="btn btn-primary">
                                                    👁️ View
                                                </a>
                                                <a href="${pageContext.request.contextPath}/leader/update-event?id=${event.eventID}&clubId=${club.clubID}" class="btn btn-warning">
                                                    ✏️ Edit
                                                </a>
                                                <form method="post" action="${pageContext.request.contextPath}/leader/delete-event" style="display: inline;">
                                                    <input type="hidden" name="eventId" value="${event.eventID}">
                                                    <input type="hidden" name="clubId" value="${club.clubID}">
                                                    <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this event?')">
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
                            <p>No events yet. Create your first event!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section">
                <div class="section-header">
                    <h2>💳 Recent Payments</h2>
                </div>
                <c:choose>
                    <c:when test="${not empty payments}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Member</th>
                                    <th>Amount</th>
                                    <th>Type</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="payment" items="${payments}" end="4">
                                    <tr>
                                        <td><strong>${payment.userName}</strong></td>
                                        <td>$<fmt:formatNumber value="${payment.amount}" type="number" maxFractionDigits="2"/></td>
                                        <td>${payment.paymentType}</td>
                                        <td><fmt:formatDate value="${payment.paymentDate}" pattern="MMM dd, yyyy"/></td>
                                        <td><span class="badge badge-${payment.status.toLowerCase()}">${payment.status}</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <p>No payment records yet</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>