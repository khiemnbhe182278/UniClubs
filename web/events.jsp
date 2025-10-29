<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard - UniClubs</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
                padding-top: 70px;
            }

            header {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                padding: 1rem 0;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            nav {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 2rem;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: bold;
            }

            nav ul {
                list-style: none;
                display: flex;
                gap: 2rem;
            }

            nav a {
                color: white;
                text-decoration: none;
                font-weight: 500;
            }

            .user-menu {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            .welcome-banner {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .welcome-banner h1 {
                color: #2193b0;
                margin-bottom: 0.5rem;
            }

            .section {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .section h2 {
                color: #333;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #eee;
            }

            .clubs-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 1.5rem;
            }

            .club-card {
                border: 2px solid #eee;
                padding: 1.5rem;
                border-radius: 10px;
                transition: all 0.3s;
            }

            .club-card:hover {
                border-color: #2193b0;
                box-shadow: 0 5px 15px rgba(33,147,176,0.2);
            }

            .club-card h3 {
                color: #2193b0;
                margin-bottom: 0.5rem;
            }

            .club-status {
                display: inline-block;
                padding: 0.3rem 1rem;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 500;
                margin-top: 0.5rem;
            }

            .status-approved {
                background: #d4edda;
                color: #155724;
            }

            .status-pending {
                background: #fff3cd;
                color: #856404;
            }

            .status-rejected {
                background: #f8d7da;
                color: #721c24;
            }

            .events-list {
                list-style: none;
            }

            .event-item {
                padding: 1rem;
                border-left: 4px solid #2193b0;
                margin-bottom: 1rem;
                background: #f9f9f9;
                border-radius: 5px;
            }

            .event-item h4 {
                color: #2193b0;
                margin-bottom: 0.3rem;
            }

            .event-date {
                color: #666;
                font-size: 0.9rem;
            }

            .btn {
                display: inline-block;
                padding: 0.7rem 1.5rem;
                background: #2193b0;
                color: white;
                text-decoration: none;
                border-radius: 10px;
                font-weight: 500;
                transition: background 0.3s;
            }

            .btn:hover {
                background: #1a7a94;
            }

            .empty-state {
                text-align: center;
                padding: 3rem;
                color: #999;
            }

            .empty-state .icon {
                font-size: 4rem;
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body>
        <header>
            <nav>
                <div class="logo">🎓 UniClubs</div>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/clubs">Browse Clubs</a></li>
                    <li><a href="${pageContext.request.contextPath}/events">Events</a></li>
                </ul>
                <div class="user-menu">
                    <span>Welcome, ${sessionScope.userName}!</span>
                    <a href="${pageContext.request.contextPath}/profile" class="btn">Profile</a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn">Logout</a>
                </div>
            </nav>
        </header>

        <div class="container">
            <div class="welcome-banner">
                <h1>Welcome back, ${sessionScope.userName}!</h1>
                <p>Here's what's happening with your clubs</p>
            </div>

            <div class="section">
                <h2>My Clubs</h2>
                <c:choose>
                    <c:when test="${not empty myClubs}">
                        <div class="clubs-grid">
                            <c:forEach var="membership" items="${myClubs}">
                                <div class="club-card">
                                    <h3>${membership.clubName}</h3>
                                    <p>Joined: <fmt:formatDate value="${membership.joinedAt}" pattern="MMM dd, yyyy"/></p>
                                    <span class="club-status status-${membership.joinStatus.toLowerCase()}">
                                        ${membership.joinStatus}
                                    </span>
                                    <c:if test="${membership.joinStatus == 'Approved'}">
                                        <div style="margin-top: 1rem;">
                                            <a href="${pageContext.request.contextPath}/club-detail?id=${membership.clubID}" 
                                               class="btn">View Club</a>
                                        </div>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="icon">📭</div>
                            <h3>You haven't joined any clubs yet</h3>
                            <p>Start exploring and join clubs that interest you!</p>
                            <a href="${pageContext.request.contextPath}/clubs" class="btn" 
                               style="margin-top: 1rem;">Browse Clubs</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="section">
                <h2>Upcoming Events</h2>
                <c:choose>
                    <c:when test="${not empty upcomingEvents}">
                        <ul class="events-list">
                            <c:forEach var="event" items="${upcomingEvents}" end="4">
                                <li class="event-item">
                                    <h4>${event.eventName}</h4>
                                    <p>${event.clubName}</p>
                                    <p class="event-date">
                                        📅 <fmt:formatDate value="${event.eventDate}" pattern="EEEE, MMM dd, yyyy 'at' HH:mm"/>
                                    </p>
                                    <a href="${pageContext.request.contextPath}/event-detail?id=${event.eventID}" 
                                       class="btn" style="margin-top: 0.5rem;">View Details</a>
                                </li>
                            </c:forEach>
                        </ul>
                        <a href="${pageContext.request.contextPath}/events" class="btn" 
                           style="margin-top: 1rem;">View All Events</a>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="icon">📅</div>
                            <p>No upcoming events at the moment</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>