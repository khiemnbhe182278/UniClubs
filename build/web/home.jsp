<%-- ==================== 1. home.jsp - Main Homepage ==================== --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>UniClubs - University Club Management System</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
                color: #333;
            }

            /* Header */
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
                transition: opacity 0.3s;
            }

            nav a:hover {
                opacity: 0.8;
            }

            .btn {
                background: white;
                color: #2193b0;
                padding: 0.6rem 1.5rem;
                border-radius: 25px;
                text-decoration: none;
                font-weight: 600;
                transition: transform 0.3s;
            }

            .btn:hover {
                transform: translateY(-2px);
            }

            /* Hero Section */
            .hero {
                margin-top: 70px;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                padding: 6rem 2rem;
                text-align: center;
            }

            .hero h1 {
                font-size: 3rem;
                margin-bottom: 1rem;
            }

            .hero p {
                font-size: 1.3rem;
                margin-bottom: 2rem;
            }

            .cta-buttons {
                display: flex;
                gap: 1rem;
                justify-content: center;
                flex-wrap: wrap;
            }

            .btn-primary {
                background: white;
                color: #2193b0;
                padding: 1rem 2.5rem;
                border-radius: 30px;
                text-decoration: none;
                font-weight: 600;
                font-size: 1.1rem;
            }

            .btn-secondary {
                background: transparent;
                color: white;
                padding: 1rem 2.5rem;
                border: 2px solid white;
                border-radius: 30px;
                text-decoration: none;
                font-weight: 600;
                font-size: 1.1rem;
            }

            /* Stats Section */
            .stats {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                padding: 4rem 2rem;
            }

            .stats-grid {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 2rem;
                text-align: center;
            }

            .stat-item {
                padding: 1.5rem;
            }

            .stat-number {
                font-size: 3rem;
                font-weight: bold;
                color: #2193b0;
                display: block;
            }

            .stat-label {
                font-size: 1.1rem;
                color: #555;
            }

            /* Clubs Section */
            .clubs-section {
                padding: 5rem 2rem;
                max-width: 1200px;
                margin: 0 auto;
            }

            .section-title {
                text-align: center;
                font-size: 2.5rem;
                margin-bottom: 3rem;
                color: #333;
            }

            .clubs-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 2rem;
            }

            .club-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                transition: transform 0.3s;
            }

            .club-card:hover {
                transform: translateY(-10px);
            }

            .club-header {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                padding: 2rem;
                text-align: center;
                font-size: 3rem;
            }

            .club-body {
                padding: 1.5rem;
            }

            .club-body h4 {
                color: #2193b0;
                margin-bottom: 0.5rem;
                font-size: 1.3rem;
            }

            .club-body p {
                color: #666;
                margin-bottom: 1rem;
            }

            .club-meta {
                display: flex;
                justify-content: space-between;
                padding-top: 1rem;
                border-top: 1px solid #eee;
                font-size: 0.9rem;
                color: #888;
            }

            .btn-view {
                display: inline-block;
                background: #2193b0;
                color: white;
                padding: 0.5rem 1.5rem;
                border-radius: 20px;
                text-decoration: none;
                margin-top: 1rem;
                transition: background 0.3s;
            }

            .btn-view:hover {
                background: #1a7a94;
            }

            /* CTA Section */
            .cta-section {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                padding: 5rem 2rem;
                text-align: center;
            }

            .cta-section h2 {
                font-size: 2.5rem;
                margin-bottom: 1rem;
            }

            /* Footer */
            footer {
                background: #2d3748;
                color: white;
                padding: 3rem 2rem;
                text-align: center;
            }

            .footer-content {
                max-width: 1200px;
                margin: 0 auto;
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 2rem;
                text-align: left;
                margin-bottom: 2rem;
            }

            .footer-section h3 {
                margin-bottom: 1rem;
                color: #6dd5ed;
            }

            .footer-section ul {
                list-style: none;
            }

            .footer-section a {
                color: #ccc;
                text-decoration: none;
                line-height: 2;
            }

            .copyright {
                border-top: 1px solid #4a5568;
                padding-top: 2rem;
                color: #ccc;
            }

            @media (max-width: 768px) {
                .hero h1 {
                    font-size: 2rem;
                }
                nav ul {
                    display: none;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <nav>
                <div class="logo">🎓 UniClubs</div>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/clubs">Clubs</a></li>
                    <li><a href="${pageContext.request.contextPath}/events">Events</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                </ul>
                <a href="${pageContext.request.contextPath}/login" class="btn">Student Portal</a>
            </nav>
        </header>

        <section class="hero">
            <div class="hero-content">
                <h1>University Club Management System</h1>
                <p>Empowering university students to discover, join, and manage campus clubs and organizations</p>
                <div class="cta-buttons">
                    <a href="${pageContext.request.contextPath}/clubs" class="btn-primary">Explore Clubs</a>
                    <a href="${pageContext.request.contextPath}/register-club" class="btn-secondary">Register a Club</a>
                </div>
            </div>
        </section>

        <section class="stats">
            <div class="stats-grid">
                <div class="stat-item">
                    <span class="stat-number">${stats.totalClubs}+</span>
                    <span class="stat-label">Active Clubs</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number"><fmt:formatNumber value="${stats.totalMembers}" type="number" groupingUsed="true"/>+</span>
                    <span class="stat-label">Student Members</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">${stats.totalEvents}+</span>
                    <span class="stat-label">Events This Year</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number"><fmt:formatNumber value="${stats.satisfactionRate}" type="number" maxFractionDigits="0"/>%</span>
                    <span class="stat-label">Satisfaction Rate</span>
                </div>
            </div>
        </section>

        <section class="clubs-section">
            <h2 class="section-title">Featured Clubs</h2>
            <div class="clubs-grid">
                <c:forEach var="club" items="${featuredClubs}">
                    <div class="club-card">
                        <div class="club-header">
                            <c:choose>
                                <c:when test="${not empty club.logo}">
                                    <img src="${pageContext.request.contextPath}/images/clubs/${club.logo}" 
                                         alt="${club.clubName}" style="width: 80px; height: 80px; border-radius: 50%;">
                                </c:when>
                                <c:otherwise>
                                    🎯
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="club-body">
                            <h4>${club.clubName}</h4>
                            <p>
                                <c:choose>
                                    <c:when test="${fn:length(club.description) > 100}">
                                        ${fn:substring(club.description, 0, 100)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${club.description}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <div class="club-meta">
                                <span>👥 ${club.memberCount} Members</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/club-detail?id=${club.clubID}" class="btn-view">View Details</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <section class="cta-section">
            <h2>Ready to Get Involved?</h2>
            <p>Join a club today and make the most of your university experience!</p>
            <a href="${pageContext.request.contextPath}/clubs" class="btn-primary">Browse All Clubs</a>
        </section>

        <footer>
            <div class="footer-content">
                <div class="footer-section">
                    <h3>Quick Links</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/clubs">All Clubs</a></li>
                        <li><a href="${pageContext.request.contextPath}/events">Events</a></li>
                        <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>For Students</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/join">Join a Club</a></li>
                        <li><a href="${pageContext.request.contextPath}/dashboard">My Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/guidelines">Guidelines</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>For Club Leaders</h3>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/register-club">Register Club</a></li>
                        <li><a href="${pageContext.request.contextPath}/manage">Manage Members</a></li>
                        <li><a href="${pageContext.request.contextPath}/resources">Resources</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h3>Contact</h3>
                    <ul>
                        <li><a href="mailto:clubs@university.edu">Email Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Contact Form</a></li>
                        <li><a href="${pageContext.request.contextPath}/feedback">Feedback</a></li>
                    </ul>
                </div>
            </div>
            <div class="copyright">
                <p>&copy; 2025 University Club Management System. All rights reserved.</p>
            </div>
        </footer>
    </body>
</html>