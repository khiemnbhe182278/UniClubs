<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Faculty Dashboard - UniClubs</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --success-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                --warning-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                --info-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            }

            body {
                background: #f5f7fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            /* Top Navigation */
            .navbar {
                background: var(--primary-gradient) !important;
                box-shadow: 0 2px 20px rgba(0,0,0,0.1);
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
                border-radius: 15px;
                padding: 1.5rem;
                height: 100%;
                transition: all 0.3s ease;
                border: none;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
                position: relative;
                overflow: hidden;
            }

            .stat-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 4px;
                height: 100%;
                background: var(--gradient);
            }

            .stat-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            }

            .stat-card.primary::before {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }
            .stat-card.success::before {
                background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
            }
            .stat-card.warning::before {
                background: linear-gradient(135deg, #ffd89b 0%, #19547b 100%);
            }
            .stat-card.info::before {
                background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.8rem;
                margin-bottom: 1rem;
            }

            .stat-card.primary .stat-icon {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .stat-card.success .stat-icon {
                background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
                color: white;
            }

            .stat-card.warning .stat-icon {
                background: linear-gradient(135deg, #ffd89b 0%, #19547b 100%);
                color: white;
            }

            .stat-card.info .stat-icon {
                background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
                color: white;
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
                border-radius: 15px;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
                border: none;
                height: 100%;
            }

            .content-card .card-header {
                background: var(--primary-gradient);
                color: white;
                border: none;
                border-radius: 15px 15px 0 0 !important;
                padding: 1.25rem 1.5rem;
                font-weight: 600;
            }

            .content-card .card-body {
                padding: 1.5rem;
            }

            /* Modern Table */
            .modern-table {
                border-collapse: separate;
                border-spacing: 0;
            }

            .modern-table thead th {
                background: #f7fafc;
                color: #4a5568;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.75rem;
                letter-spacing: 0.5px;
                padding: 1rem;
                border: none;
            }

            .modern-table tbody tr {
                transition: all 0.2s;
            }

            .modern-table tbody tr:hover {
                background: #f7fafc;
                transform: scale(1.01);
            }

            .modern-table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border-bottom: 1px solid #e2e8f0;
            }

            /* Badges */
            .badge-modern {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-weight: 500;
                font-size: 0.8rem;
            }

            .badge-active {
                background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
                color: white;
            }

            .badge-pending {
                background: linear-gradient(135deg, #ffd89b 0%, #ffb347 100%);
                color: white;
            }

            .badge-approved {
                background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
                color: white;
            }

            /* Buttons */
            .btn-modern {
                border-radius: 10px;
                padding: 0.5rem 1.5rem;
                font-weight: 600;
                transition: all 0.3s;
                border: none;
            }

            .btn-modern:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            .btn-primary-modern {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .btn-outline-modern {
                border: 2px solid #667eea;
                color: #667eea;
                background: transparent;
            }

            .btn-outline-modern:hover {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
        <!-- Top Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/faculty/dashboard">
                    <i class="fas fa-graduation-cap me-2"></i>Faculty Portal
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto align-items-center">
                        <li class="nav-item">
                            <a class="nav-link active px-3" href="${pageContext.request.contextPath}/faculty/dashboard">
                                <i class="fas fa-home me-1"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/faculty/members">
                                <i class="fas fa-users me-1"></i> Members
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/faculty/events">
                                <i class="fas fa-calendar me-1"></i> Events
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/faculty/news">
                                <i class="fas fa-newspaper me-1"></i> News
                            </a>
                        </li>
                        <li class="nav-item dropdown ms-3">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-1"></i> ${sessionScope.user.userName}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>