<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - UniClubs</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #2193b0;
            --primary-gradient: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
            --shadow-sm: 0 2px 8px rgba(0,0,0,0.08);
            --shadow-md: 0 4px 16px rgba(0,0,0,0.12);
            --border-radius: 12px;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f8f9fa;
            padding-top: 76px;
        }

        /* Header Styles */
        header {
            background: var(--primary-gradient);
            box-shadow: var(--shadow-md);
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1030;
        }

        .navbar-brand {
            font-size: 1.75rem;
            font-weight: 700;
            color: white !important;
            letter-spacing: -0.5px;
        }

        .navbar-nav .nav-link {
            color: rgba(255,255,255,0.9) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.3s;
        }

        .navbar-nav .nav-link:hover {
            color: white !important;
            background: rgba(255,255,255,0.1);
            border-radius: 8px;
        }

        /* Welcome Banner */
        .welcome-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: var(--border-radius);
            padding: 2.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
        }

        .welcome-banner h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .welcome-banner p {
            font-size: 1.1rem;
            opacity: 0.95;
            margin: 0;
        }

        /* Section Cards */
        .section-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #212529;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 3px solid #e9ecef;
        }

        /* Club Cards */
        .club-card {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            height: 100%;
            transition: all 0.3s ease;
        }

        .club-card:hover {
            border-color: var(--primary-color);
            box-shadow: var(--shadow-md);
            transform: translateY(-4px);
        }

        .club-card h3 {
            color: var(--primary-color);
            font-size: 1.25rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .club-info {
            color: #6c757d;
            font-size: 0.95rem;
            margin-bottom: 1rem;
        }

        /* Status Badges */
        .badge-status {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.875rem;
            text-transform: capitalize;
        }

        .badge-approved {
            background: #d4edda;
            color: #155724;
        }

        .badge-pending {
            background: #fff3cd;
            color: #856404;
        }

        .badge-rejected {
            background: #f8d7da;
            color: #721c24;
        }

        /* Event Items */
        .event-item {
            background: #f8f9fa;
            border-left: 4px solid var(--primary-color);
            border-radius: 8px;
            padding: 1.25rem;
            margin-bottom: 1rem;
            transition: all 0.3s;
        }

        .event-item:hover {
            background: white;
            box-shadow: var(--shadow-sm);
        }

        .event-item h4 {
            color: var(--primary-color);
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .event-club-name {
            color: #495057;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .event-date {
            color: #6c757d;
            font-size: 0.95rem;
        }

        /* Buttons */
        .btn-primary-custom {
            background: var(--primary-gradient);
            border: none;
            color: white;
            padding: 0.625rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(33,147,176,0.4);
            color: white;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            color: #6c757d;
        }

        .empty-state h3 {
            color: #495057;
            font-weight: 600;
            margin-bottom: 0.75rem;
        }

        .empty-state p {
            color: #6c757d;
            margin-bottom: 1.5rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .welcome-banner {
                padding: 1.5rem;
            }
            
            .welcome-banner h1 {
                font-size: 1.5rem;
            }
            
            .section-card {
                padding: 1.5rem;
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
                                        Joined: <fmt:formatDate value="${membership.joinedAt}" pattern="MMM dd, yyyy"/>
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
            <h2 class="section-title">Sự kiện sắp diễn ra</h2>
            <c:choose>
                <c:when test="${not empty upcomingEvents}">
                    <div class="mb-3">
                        <c:forEach var="event" items="${upcomingEvents}" end="4">
                            <div class="event-item">
                                <h4>${event.eventName}</h4>
                                <p class="event-club-name">${event.clubName}</p>
                                <p class="event-date mb-3">
                                    Thời gian: <fmt:formatDate value="${event.eventDate}" pattern="EEEE, dd/MM/yyyy 'lúc' HH:mm"/>
                                </p>
                                <a href="${pageContext.request.contextPath}/event-detail?id=${event.eventID}" 
                                   class="btn btn-primary-custom btn-sm">
                                    Xem chi tiết
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/events" class="btn btn-primary-custom">
                            Xem tất cả sự kiện
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>Chưa có sự kiện sắp tới</h3>
                        <p>Các sự kiện mới sẽ được cập nhật sớm</p>
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