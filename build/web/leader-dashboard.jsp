<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Club Leader Dashboard - UniClubs</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
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
                padding: 30px 20px;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
            }

            .sidebar-header h2 {
                font-size: 22px;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 8px;
            }

            .sidebar-header p {
                font-size: 13px;
                opacity: 0.95;
                font-weight: 500;
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
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                transform: translateX(5px);
                box-shadow: 0 4px 12px rgba(33, 147, 176, 0.4);
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
                background: white;
                padding: 30px;
                border-radius: 20px;
                margin-bottom: 30px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: relative;
                overflow: hidden;
            }

            .top-bar::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #2193b0 0%, #6dd5ed 100%);
            }

            .welcome-section h1 {
                font-size: 28px;
                font-weight: 700;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .club-selector {
                padding: 12px 16px;
                border: 2px solid #e2e8f0;
                border-radius: 12px;
                font-size: 14px;
                font-family: 'Inter', sans-serif;
                font-weight: 500;
                cursor: pointer;
                background: white;
                transition: all 0.3s ease;
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

            .stat-card:nth-child(1)::before {
                background: linear-gradient(90deg, #2193b0 0%, #6dd5ed 100%);
            }

            .stat-card:nth-child(2)::before {
                background: linear-gradient(90deg, #f39c12 0%, #e67e22 100%);
            }

            .stat-card:nth-child(3)::before {
                background: linear-gradient(90deg, #9b59b6 0%, #8e44ad 100%);
            }

            .stat-card:nth-child(4)::before {
                background: linear-gradient(90deg, #2ecc71 0%, #27ae60 100%);
            }

            .stat-icon {
                width: 56px;
                height: 56px;
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 28px;
                margin-bottom: 15px;
            }

            .stat-card:nth-child(1) .stat-icon {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
            }

            .stat-card:nth-child(2) .stat-icon {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            }

            .stat-card:nth-child(3) .stat-icon {
                background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
            }

            .stat-card:nth-child(4) .stat-icon {
                background: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            }

            .stat-content h3 {
                font-size: 36px;
                font-weight: 800;
                color: #2d3748;
                margin-bottom: 8px;
            }

            .stat-content p {
                color: #718096;
                font-size: 14px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
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
                border-collapse: collapse;
            }

            thead {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
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

            tbody tr {
                border-bottom: 1px solid #e2e8f0;
                transition: all 0.3s ease;
            }

            tbody tr:hover {
                background: linear-gradient(90deg, rgba(33, 147, 176, 0.03) 0%, rgba(109, 213, 237, 0.03) 100%);
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

            /* Buttons */
            .btn {
                padding: 10px 18px;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                text-decoration: none;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .btn-primary {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(33, 147, 176, 0.3);
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 25px rgba(33, 147, 176, 0.5);
            }

            .btn-success {
                background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
                color: white;
                margin-right: 8px;
            }

            .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(72, 187, 120, 0.4);
            }

            .btn-danger {
                background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
                color: white;
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(245, 101, 101, 0.4);
            }

            .btn-warning {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
                color: white;
                margin-right: 8px;
            }

            .btn-warning:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(243, 156, 18, 0.4);
            }

            .btn:active {
                transform: translateY(0);
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
                <h2>🎓 Leader Dashboard</h2>
                <p>${club.clubName}</p>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}&amp;clubID=${club.clubID}" class="active">📊 Overview</a></li>
                <li><a href="${pageContext.request.contextPath}/club/members?clubId=${club.clubID}&amp;clubID=${club.clubID}">👥 Members</a></li>
                <li><a href="${pageContext.request.contextPath}/leader/events?clubId=${club.clubID}&amp;clubID=${club.clubID}">📅 Events</a></li>
                <li><a href="${pageContext.request.contextPath}/leader/rules?clubId=${club.clubID}&amp;clubID=${club.clubID}">📜 Rules</a></li>
                <li><a href="${pageContext.request.contextPath}/leader/news?clubId=${club.clubID}&amp;clubID=${club.clubID}">📰 News</a></li>
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