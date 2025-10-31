<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Club Leader Dashboard - UniClubs</title>
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
                background: #2193b0;
                min-height: 100vh;
                color: white;
                position: fixed;
            }

            .sidebar-header {
                padding: 2rem;
                background: #1a7a94;
                text-align: center;
            }

            .sidebar-header h2 {
                font-size: 1.3rem;
            }

            .sidebar-menu {
                list-style: none;
                padding: 1rem 0;
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
                background: #1a7a94;
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

            .club-selector {
                padding: 0.7rem 1rem;
                border: 2px solid #ddd;
                border-radius: 10px;
                font-size: 1rem;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                padding: 1.5rem;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                position: relative;
            }

            .stat-card h3 {
                font-size: 2rem;
                color: #2193b0;
                margin-bottom: 0.5rem;
            }

            .stat-card p {
                color: #666;
            }

            .section {
                background: white;
                padding: 2rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .section-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #eee;
            }

            .section-header h2 {
                color: #2193b0;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #eee;
            }

            th {
                background: #f8f9fa;
                font-weight: 600;
                color: #333;
            }

            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                font-size: 0.9rem;
                margin-right: 0.5rem;
            }

            .btn-primary {
                background: #2193b0;
                color: white;
            }

            .btn-success {
                background: #2ecc71;
                color: white;
            }

            .btn-danger {
                background: #e74c3c;
                color: white;
            }

            .badge {
                padding: 0.3rem 0.8rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 500;
            }

            .badge-pending {
                background: #fff3cd;
                color: #856404;
            }

            .badge-approved {
                background: #d4edda;
                color: #155724;
            }

            .badge-attended {
                background: #d1ecf1;
                color: #0c5460;
            }

            .no-data {
                text-align: center;
                padding: 2rem;
                color: #999;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 Leader Dashboard</h2>
                <p style="font-size: 0.9rem; opacity: 0.9;">${club.clubName}</p>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}&amp;clubID=${club.clubID}" class="active">Overview</a></li>
                <li><a href="${pageContext.request.contextPath}/club/members?clubId=${club.clubID}&amp;clubID=${club.clubID}">Members</a></li>
                <li><a href="${pageContext.request.contextPath}/leader/events?clubId=${club.clubID}&amp;clubID=${club.clubID}">Events</a></li>
                <li><a href="${pageContext.request.contextPath}/leader/payments?clubId=${club.clubID}&amp;clubID=${club.clubID}">Payments</a></li>
                <li><a href="${pageContext.request.contextPath}/create-event?clubId=${club.clubID}&amp;clubID=${club.clubID}">Create Event</a></li>
                <li><a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="top-bar">
                <h1>Welcome, ${sessionScope.userName}!</h1>
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
                    <h3>${members.size()}</h3>
                    <p>Total Members</p>
                </div>
                <div class="stat-card">
                    <h3>${pendingMembers.size()}</h3>
                    <p>Pending Requests</p>
                </div>
                <div class="stat-card">
                    <h3>${events.size()}</h3>
                    <p>Total Events</p>
                </div>
                <div class="stat-card">
                    <h3>$<fmt:formatNumber value="${totalRevenue}" type="number" maxFractionDigits="2"/></h3>
                    <p>Total Revenue</p>
                </div>
            </div>

            <div class="section">
                <div class="section-header">
                    <h2>Pending Membership Requests</h2>
                </div>
                <c:choose>
                    <c:when test="${not empty pendingMembers}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Student Name</th>
                                    <th>Email</th>
                                    <th>Request Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="member" items="${pendingMembers}">
                                    <tr>
                                        <td><strong>${member.userName}</strong></td>
                                        <td>${member.email}</td>
                                        <td><fmt:formatDate value="${member.joinedAt}" pattern="MMM dd, yyyy"/></td>
                                        <td>
                                            <form method="post" action="${pageContext.request.contextPath}/leader/approve-member" style="display: inline;">
                                                <input type="hidden" name="memberId" value="${member.memberID}">
                                                <!-- pass current club context -->
                                                <input type="hidden" name="clubId" value="${club.clubID}">
                                                <input type="hidden" name="clubID" value="${club.clubID}">
                                                <button type="submit" name="action" value="approve" class="btn btn-success">
                                                    ✓ Approve
                                                </button>
                                                <button type="submit" name="action" value="reject" class="btn btn-danger">
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
                            <p>No pending membership requests</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section">
                <div class="section-header">
                    <h2>Recent Events</h2>
                    <a href="${pageContext.request.contextPath}/create-event?clubId=${club.clubID}&amp;clubID=${club.clubID}" class="btn btn-primary">Create New Event</a>
                </div>
                <c:choose>
                    <c:when test="${not empty events}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Event Name</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="event" items="${events}" end="4">
                                    <tr>
                                        <td><strong>${event.eventName}</strong></td>
                                        <td><fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy HH:mm"/></td>
                                        <td><span class="badge badge-${event.status.toLowerCase()}">${event.status}</span></td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/event-detail?id=${event.eventID}" class="btn btn-primary">View</a>
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
                    <h2>Recent Payments</h2>
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
                                        <td>${payment.userName}</td>
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
                            <p>No payment records</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>
