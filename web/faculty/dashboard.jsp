<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Faculty Dashboard - UniClubs</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            /* Sidebar Styles */
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                bottom: 0;
                width: 260px;
                background-color: #fff;
                padding: 1rem;
                overflow-y: auto;
                z-index: 1000;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .sidebar-header {
                padding: 1rem;
                border-bottom: 1px solid #eee;
                margin-bottom: 1rem;
            }

            .sidebar-header h2 {
                font-size: 1.25rem;
                margin-bottom: 0.5rem;
                color: #333;
            }

            .sidebar-header p {
                font-size: 0.9rem;
                color: #666;
                margin: 0;
            }

            .sidebar-menu {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .sidebar-menu li {
                margin-bottom: 0.5rem;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                padding: 0.75rem 1rem;
                color: #333;
                text-decoration: none;
                border-radius: 0.5rem;
                transition: all 0.3s;
            }

            .sidebar-menu a:hover {
                background-color: #f8f9fa;
                color: #007bff;
            }

            .sidebar-menu a.active {
                background-color: #e7f1ff;
                color: #007bff;
            }

            .sidebar-menu i {
                margin-right: 0.5rem;
                font-size: 1.1rem;
            }

            /* Main Content */
            .main-content {
                margin-left: 260px;
                padding: 2rem;
                min-height: 100vh;
            }

            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
            }

            /* Dashboard Header */
            .dashboard-header {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                margin-bottom: 2rem;
            }

            .dashboard-header h2 {
                color: #2d3748;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .dashboard-header p {
                color: #718096;
                margin: 0;
            }

            /* Statistics Cards */
            .stat-card {
                background: white;
                border-radius: 0.5rem;
                padding: 1.5rem;
                height: 100%;
                border: 1px solid #e9ecef;
                position: relative;
            }

            .stat-card.primary {
                border-left: 4px solid #007bff;
            }
            .stat-card.success {
                border-left: 4px solid #28a745;
            }
            .stat-card.warning {
                border-left: 4px solid #ffc107;
            }
            .stat-card.info {
                border-left: 4px solid #17a2b8;
            }

            .stat-icon {
                width: 48px;
                height: 48px;
                border-radius: 0.5rem;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin-bottom: 1rem;
            }

            .stat-card.primary .stat-icon {
                background-color: #e7f1ff;
                color: #007bff;
            }

            .stat-card.success .stat-icon {
                background-color: #d4edda;
                color: #28a745;
            }

            .stat-card.warning .stat-icon {
                background-color: #fff3cd;
                color: #ffc107;
            }

            .stat-card.info .stat-icon {
                background-color: #d1ecf1;
                color: #17a2b8;
            }

            .stat-number {
                font-size: 2.5rem;
                font-weight: 700;
                color: #2d3748;
                margin: 0;
            }

            .stat-label {
                color: #718096;
                font-size: 0.95rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* Content Cards */
            .content-card {
                background: white;
                border-radius: 0.5rem;
                border: 1px solid #e9ecef;
                height: 100%;
            }

            .content-card .card-header {
                background: #f8f9fa;
                color: #333;
                border-bottom: 1px solid #e9ecef;
                padding: 1rem 1.5rem;
                font-weight: 500;
                border-radius: 0.5rem 0.5rem 0 0;
            }

            .content-card .card-body {
                padding: 1.5rem;
            }

            /* Modern Table */
            .modern-table {
                width: 100%;
                margin-bottom: 1rem;
            }

            .modern-table thead th {
                background: #f8f9fa;
                color: #495057;
                font-weight: 500;
                padding: 0.75rem;
                border-bottom: 2px solid #dee2e6;
            }

            .modern-table tbody tr:hover {
                background-color: #f8f9fa;
            }

            .modern-table tbody td {
                padding: 0.75rem;
                vertical-align: middle;
                border-bottom: 1px solid #dee2e6;
            }

            /* Badges */
            .badge-modern {
                padding: 0.4rem 0.8rem;
                border-radius: 0.25rem;
                font-weight: 500;
                font-size: 0.875rem;
            }

            .badge-active {
                background-color: #28a745;
                color: white;
            }

            .badge-pending {
                background-color: #ffc107;
                color: #212529;
            }

            .badge-approved {
                background-color: #28a745;
                color: white;
            }

            /* Buttons */
            .btn-modern {
                padding: 0.375rem 1rem;
                font-weight: 500;
                border-radius: 0.25rem;
            }

            .btn-primary-modern {
                background-color: #007bff;
                border-color: #007bff;
                color: white;
            }

            .btn-primary-modern:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            .btn-outline-modern {
                border: 1px solid #007bff;
                color: #007bff;
                background-color: transparent;
            }

            .btn-outline-modern:hover {
                background-color: #007bff;
                color: white;
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 3rem 1rem;
                color: #a0aec0;
            }

            .empty-state i {
                font-size: 4rem;
                margin-bottom: 1rem;
                opacity: 0.5;
            }

            /* Club Logo */
            .club-logo-mini {
                width: 40px;
                height: 40px;
                border-radius: 8px;
                object-fit: cover;
                margin-right: 0.75rem;
            }

            /* Status Indicators */
            .status-dot {
                width: 8px;
                height: 8px;
                border-radius: 50%;
                display: inline-block;
                margin-right: 0.5rem;
            }

            .status-dot.active {
                background: #48bb78;
            }
            .status-dot.pending {
                background: #ed8936;
            }
            .status-dot.approved {
                background: #4299e1;
            }

            /* Quick Stats */
            .quick-stat {
                display: flex;
                align-items: center;
                padding: 0.75rem;
                background: #f7fafc;
                border-radius: 10px;
                margin-bottom: 0.5rem;
            }

            .quick-stat-icon {
                width: 40px;
                height: 40px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 1rem;
                font-size: 1.2rem;
            }

            /* Section Divider */
            .section-divider {
                margin: 2rem 0;
                border: none;
                height: 2px;
                background: linear-gradient(90deg, transparent, #e2e8f0, transparent);
            }
        </style>
    </head>
    <body>
        
        <div class="sidebar">
            <div class="sidebar-header">
                <h2><i class="bi bi-person-badge"></i> Faculty Portal</h2>
                <p>${sessionScope.user.userName}</p>
                <div class="d-flex mt-3">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                        <i class="bi bi-box-arrow-right"></i> Sign Out
                    </a>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/faculty/dashboard" <c:if test="${fn:contains(pageContext.request.requestURI, '/faculty/dashboard')}">class="active"</c:if>>
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/faculty/members" <c:if test="${fn:contains(pageContext.request.requestURI, '/faculty/members')}">class="active"</c:if>>
                        <i class="bi bi-people"></i> Members
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/faculty/events" <c:if test="${fn:contains(pageContext.request.requestURI, '/faculty/events')}">class="active"</c:if>>
                        <i class="bi bi-calendar3"></i> Events
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/faculty/news" <c:if test="${fn:contains(pageContext.request.requestURI, '/faculty/news')}">class="active"</c:if>>
                        <i class="bi bi-newspaper"></i> News
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content">

        <div class="container-fluid px-4 py-4">
            <!-- Alert Messages -->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-${sessionScope.messageType} alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="message" scope="session"/>
                <c:remove var="messageType" scope="session"/>
            </c:if>

            <!-- Dashboard Header -->
            <div class="dashboard-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2><i class="fas fa-chart-line me-2"></i>Dashboard Overview</h2>
                        <p>Welcome back, ${sessionScope.user.userName}! Here's what's happening with your supervised clubs.</p>
                    </div>
                    <div class="text-end">
                        <small class="text-muted d-block">Last updated</small>
                        <strong><fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMM yyyy, HH:mm"/></strong>
                    </div>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-4 mb-4">
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card primary">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h3 class="stat-number">${stats.totalClubs}</h3>
                        <p class="stat-label">Total Clubs</p>
                        <small class="text-muted">Under your supervision</small>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card success">
                        <div class="stat-icon">
                            <i class="fas fa-user-check"></i>
                        </div>
                        <h3 class="stat-number">${stats.totalMembers}</h3>
                        <p class="stat-label">Active Members</p>
                        <small class="text-muted">Approved members</small>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card warning">
                        <div class="stat-icon">
                            <i class="fas fa-user-clock"></i>
                        </div>
                        <h3 class="stat-number">${stats.pendingMembers}</h3>
                        <p class="stat-label">Pending Reviews</p>
                        <small class="text-muted">Requires your attention</small>
                    </div>
                </div>
                <div class="col-xl-3 col-md-6">
                    <div class="stat-card info">
                        <div class="stat-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <h3 class="stat-number">${stats.totalEvents}</h3>
                        <p class="stat-label">Total Events</p>
                        <small class="text-muted">All club events</small>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <!-- Supervised Clubs -->
                <div class="col-lg-6">
                    <div class="content-card">
                        <div class="card-header">
                            <i class="fas fa-users me-2"></i>Supervised Clubs
                        </div>
                        <div class="card-body">
                            <c:if test="${empty clubs}">
                                <div class="empty-state">
                                    <i class="fas fa-inbox"></i>
                                    <h5>No Clubs Yet</h5>
                                    <p class="text-muted">You don't have any clubs under your supervision.</p>
                                </div>
                            </c:if>

                            <c:forEach items="${clubs}" var="club">
                                <div class="quick-stat">
                                    <div class="d-flex align-items-center flex-grow-1">
                                        <c:choose>
                                            <c:when test="${not empty club.logo}">
                                                <img src="${pageContext.request.contextPath}/uploads/${club.logo}" 
                                                     class="club-logo-mini" alt="${club.clubName}">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="club-logo-mini bg-light d-flex align-items-center justify-content-center">
                                                    <i class="fas fa-users text-muted"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="flex-grow-1">
                                            <div class="fw-bold">${club.clubName}</div>
                                            <small class="text-muted">
                                                <span class="status-dot ${club.status == 'Active' ? 'active' : 'pending'}"></span>
                                                ${club.categoryName} • ${club.memberCount} members
                                            </small>
                                        </div>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/faculty/club?clubID=${club.clubID}" 
                                       class="btn btn-sm btn-outline-modern">
                                        <i class="fas fa-arrow-right"></i>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- Pending Members -->
                <div class="col-lg-6">
                    <div class="content-card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-user-clock me-2"></i>Pending Member Approvals</span>
                            <c:if test="${stats.pendingMembers > 0}">
                                <span class="badge bg-light text-dark">${stats.pendingMembers}</span>
                            </c:if>
                        </div>
                        <div class="card-body">
                            <c:if test="${empty pendingMembers}">
                                <div class="empty-state">
                                    <i class="fas fa-check-circle"></i>
                                    <h5>All Caught Up!</h5>
                                    <p class="text-muted">No pending member applications at the moment.</p>
                                </div>
                            </c:if>

                            <c:forEach items="${pendingMembers}" var="member" begin="0" end="4">
                                <div class="quick-stat">
                                    <div class="quick-stat-icon" style="background: linear-gradient(135deg, #ffd89b 0%, #ffb347 100%); color: white;">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="flex-grow-1">
                                        <div class="fw-bold">${member.fullName}</div>
                                        <small class="text-muted">
                                            ${member.studentID} • ${member.clubName}
                                        </small>
                                    </div>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${member.joinedAt}" pattern="dd MMM"/>
                                    </small>
                                </div>
                            </c:forEach>

                            <c:if test="${stats.pendingMembers > 5}">
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/faculty/members" 
                                       class="btn btn-primary-modern btn-modern">
                                        View All ${stats.pendingMembers} Applications
                                    </a>
                                </div>
                            </c:if>

                            <c:if test="${not empty pendingMembers && stats.pendingMembers <= 5}">
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/faculty/members" 
                                       class="btn btn-outline-modern btn-modern">
                                        Review Applications
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Events -->
            <div class="row g-4 mt-1">
                <div class="col-12">
                    <div class="content-card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span><i class="fas fa-calendar-alt me-2"></i>Recent Events</span>
                            <a href="${pageContext.request.contextPath}/faculty/events" class="btn btn-sm btn-light">
                                View All <i class="fas fa-arrow-right ms-1"></i>
                            </a>
                        </div>
                        <div class="card-body">
                            <c:if test="${empty events}">
                                <div class="empty-state">
                                    <i class="fas fa-calendar-times"></i>
                                    <h5>No Events Yet</h5>
                                    <p class="text-muted">No events have been created by your supervised clubs.</p>
                                </div>
                            </c:if>

                            <c:if test="${not empty events}">
                                <div class="table-responsive">
                                    <table class="table modern-table">
                                        <thead>
                                            <tr>
                                                <th>Event</th>
                                                <th>Club</th>
                                                <th>Date & Time</th>
                                                <th>Location</th>
                                                <th>Participants</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${events}" var="event" begin="0" end="4">
                                                <tr>
                                                    <td>
                                                        <div class="fw-bold">${event.eventName}</div>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-light text-dark">${event.clubName}</span>
                                                    </td>
                                                    <td>
                                                        <i class="far fa-clock me-1"></i>
                                                        <fmt:formatDate value="${event.eventDate}" pattern="dd MMM, HH:mm"/>
                                                    </td>
                                                    <td>
                                                        <i class="fas fa-map-marker-alt me-1 text-danger"></i>
                                                        ${event.location}
                                                    </td>
                                                    <td>
                                                        <span class="badge badge-modern" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                                                            ${event.currentParticipants}
                                                            <c:if test="${event.maxParticipants > 0}">/ ${event.maxParticipants}</c:if>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span class="badge badge-modern badge-${event.status == 'Approved' ? 'approved' : 'pending'}">
                                                            ${event.status}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/faculty/events?eventID=${event.eventID}" 
                                                           class="btn btn-sm btn-outline-modern">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>