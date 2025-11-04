<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - UniClubs</title>
    
    <!-- Load baseline CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    
    <style>
        body {
            background: var(--bg);
            padding-top: 76px;
        }

        /* Header Styles */
        header {
            background: var(--panel-bg);
            box-shadow: var(--shadow-sm);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1030;
            border-bottom: 1px solid var(--border-color);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--heading) !important;
            letter-spacing: -0.01em;
            transition: all 0.2s ease;
        }

        .navbar-brand:hover {
            color: var(--primary) !important;
        }

        .navbar-nav .nav-link {
            color: var(--text) !important;
            font-weight: 500;
            padding: 0.75rem 1rem !important;
            transition: all 0.2s ease;
            font-size: 0.95rem;
        }

        .navbar-nav .nav-link:hover {
            color: var(--primary) !important;
            background: var(--bg-light);
            border-radius: var(--border-radius);
        }

        /* Welcome Banner */
        .welcome-banner {
            background: var(--panel-bg);
            border-radius: var(--border-radius-lg);
            padding: 2.5rem 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
            position: relative;
            overflow: hidden;
        }

        .welcome-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--accent) 0%, var(--primary) 100%);
        }

        .welcome-banner h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: var(--heading);
            letter-spacing: -0.02em;
            line-height: 1.2;
        }

        .welcome-banner p {
            font-size: 1.1rem;
            color: var(--text);
            opacity: 0.9;
            margin: 0;
            line-height: 1.6;
        }

        /* Section Cards */
        .section-card {
            background: var(--panel-bg);
            border-radius: var(--border-radius);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
            transition: all 0.2s ease;
        }

        .section-card:hover {
            border-color: var(--border-hover);
            box-shadow: var(--shadow-md);
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--heading);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
            letter-spacing: -0.01em;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        /* Club Cards */
        .club-card {
            background: var(--bg-light);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            padding: 1.75rem;
            height: 100%;
            transition: all 0.2s ease;
        }

        .club-card:hover {
            border-color: var(--primary);
            box-shadow: var(--shadow-sm);
            transform: translateY(-2px);
            background: var(--bg);
        }

        .club-card h3 {
            color: var(--heading);
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
            letter-spacing: -0.01em;
        }

        .club-info {
            color: var(--text);
            font-size: 0.95rem;
            margin-bottom: 1rem;
            line-height: 1.6;
            opacity: 0.9;
        }

        /* Status Badges */
        .badge-status {
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius);
            font-weight: 500;
            font-size: 0.875rem;
            text-transform: capitalize;
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
        }

        .badge-approved {
            background: rgba(16, 185, 129, 0.1);
            color: rgb(6, 95, 70);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .badge-pending {
            background: rgba(245, 158, 11, 0.1);
            color: rgb(146, 64, 14);
            border: 1px solid rgba(245, 158, 11, 0.2);
        }

        .badge-rejected {
            background: rgba(239, 68, 68, 0.1);
            color: rgb(153, 27, 27);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        /* Event Items */
        .event-item {
            background: var(--bg-light);
            border: 1px solid var(--border-color);
            border-left: 3px solid var(--primary);
            border-radius: var(--border-radius);
            padding: 1.25rem;
            margin-bottom: 1rem;
            transition: all 0.2s ease;
        }

        .event-item:hover {
            background: var(--bg);
            border-color: var(--border-hover);
            border-left-color: var(--accent);
            transform: translateX(4px);
        }

        .event-item h4 {
            color: var(--heading);
            font-size: 1.05rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            letter-spacing: -0.01em;
        }

        .event-club-name {
            color: var(--heading);
            font-weight: 500;
            margin-bottom: 0.5rem;
            opacity: 0.9;
        }

        .event-date {
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        /* Buttons */
        .btn-primary-custom {
            background: linear-gradient(135deg, var(--accent) 0%, var(--primary) 100%);
            border: none;
            color: white;
            padding: 0.875rem 1.5rem;
            border-radius: var(--border-radius);
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            box-shadow: var(--shadow-sm);
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            filter: brightness(1.05);
            color: white;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            background: var(--bg-light);
            border-radius: var(--border-radius);
            border: 1px dashed var(--border-color);
        }

        .empty-state h3 {
            color: var(--heading);
            font-weight: 600;
            margin-bottom: 0.75rem;
            font-size: 1.25rem;
        }

        .empty-state p {
            color: var(--text);
            margin-bottom: 1.5rem;
            opacity: 0.9;
            font-size: 1rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding-top: 64px;
            }
            
            .welcome-banner {
                padding: 1.75rem;
            }
            
            .welcome-banner h1 {
                font-size: 1.75rem;
            }
            
            .section-card {
                padding: 1.5rem;
            }

            .club-card, .event-item {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container py-4">
        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <h1>Welcome back, ${sessionScope.userName}!</h1>
            <p>Here's what's happening with your clubs</p>
        </div>

        <!-- My Clubs Section -->
        <div class="section-card">
            <h2 class="section-title">My Clubs</h2>
            <c:choose>
                <c:when test="${not empty myClubs}">
                    <div class="row g-4">
                        <c:forEach var="membership" items="${myClubs}">
                            <div class="col-lg-4 col-md-6">
                                <div class="club-card">
                                    <h3>${membership.clubName}</h3>
                                    <p class="club-info">
                                        Joined: <fmt:setLocale value="en_US"/><fmt:formatDate value="${membership.joinedAt}" pattern="MMM dd, yyyy"/>
                                    </p>
                                    <div class="mb-3">
                                        <span class="badge-status badge-${membership.joinStatus.toLowerCase()}">
                                            ${membership.joinStatus}
                                        </span>
                                    </div>
                                    <c:if test="${membership.joinStatus == 'Approved'}">
                                        <a href="${pageContext.request.contextPath}/member-club-detail?id=${membership.clubID}" 
                                           class="btn btn-primary-custom w-100">
                                            View Details
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>You haven't joined any clubs yet</h3>
                        <p>Start exploring and join clubs that interest you!</p>
                        <a href="${pageContext.request.contextPath}/clubs" class="btn btn-primary-custom">
                            Browse Clubs
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Upcoming Events Section -->
        <div class="section-card">
            <h2 class="section-title">Upcoming Events</h2>
            <c:choose>
                <c:when test="${not empty upcomingEvents}">
                    <div class="mb-3">
                        <c:forEach var="event" items="${upcomingEvents}" end="4">
                            <div class="event-item">
                                <h4>${event.eventName}</h4>
                                <p class="event-club-name">${event.clubName}</p>
                                <p class="event-date mb-3">
                                    Time: <fmt:setLocale value="en_US"/><fmt:formatDate value="${event.eventDate}" pattern="EEEE, dd/MM/yyyy 'at' HH:mm"/>
                                </p>
                                <a href="${pageContext.request.contextPath}/event-detail?id=${event.eventID}" 
                                   class="btn btn-primary-custom btn-sm">
                                    View Details
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/events" class="btn btn-primary-custom">
                            View All Events
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>No Upcoming Events</h3>
                        <p>New events will be updated soon</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>