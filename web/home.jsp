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

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <!-- AOS Animation -->
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <style>
            .hero-section {
                padding: 5rem 0;
                background: var(--primary-gradient);
                margin-bottom: 2rem;
            }
            
            .hero-content {
                text-align: center;
                color: white;
            }
            
            .hero-content h1 {
                font-size: 2.5rem;
                margin-bottom: 1rem;
                font-weight: 600;
            }
            
            .hero-content p {
                font-size: 1.2rem;
                margin-bottom: 2rem;
                opacity: 0.9;
            }
            
            .hero-buttons .btn {
                margin: 0.5rem;
                padding: 0.75rem 2rem;
                border-radius: var(--border-radius);
                transition: var(--transition);
            }
            
            .stats-section {
                padding: 4rem 0;
                background: var(--bg-light);
            }
            
            .stat-card {
                text-align: center;
                padding: 2rem;
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-sm);
                transition: var(--transition);
            }
            
            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-md);
            }
            
            .stat-number {
                display: block;
                font-size: 2.5rem;
                font-weight: 600;
                color: var(--primary);
                margin-bottom: 0.5rem;
            }
            
            .stat-label {
                color: var(--text-muted);
                font-size: 1.1rem;
            }
            
            .clubs-section {
                padding: 4rem 0;
            }
            
            .club-card {
                height: 100%;
                transition: var(--transition);
                border: none;
                box-shadow: var(--shadow-sm);
            }
            
            .club-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-md);
            }
            
            .club-emoji {
                font-size: 3rem;
                text-align: center;
                padding: 1.5rem;
                background: var(--bg-light);
                border-radius: var(--border-radius) var(--border-radius) 0 0;
            }
            
            .club-logo {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: var(--border-radius) var(--border-radius) 0 0;
            }
            
            .club-meta {
                margin: 1rem 0;
                color: var(--text-muted);
                font-size: 0.9rem;
            }
            
            .features-section {
                padding: 4rem 0;
                background: var(--bg-light);
            }
            
            .feature-card {
                text-align: center;
                padding: 2rem;
                background: white;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-sm);
                height: 100%;
                transition: var(--transition);
            }
            
            .feature-card:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-md);
            }
            
            .feature-icon {
                font-size: 2.5rem;
                color: var(--primary);
                margin-bottom: 1rem;
            }
            
            .feature-card h4 {
                margin-bottom: 1rem;
                color: var(--heading);
            }
            
            .feature-card p {
                color: var(--text-muted);
                font-size: 0.95rem;
                margin-bottom: 0;
            }
            
            .cta-section {
                padding: 5rem 0;
                text-align: center;
                background: var(--bg-light);
                border-top: 1px solid var(--border-color);
                border-bottom: 1px solid var(--border-color);
            }
            
            .cta-section h2 {
                font-size: 2.5rem;
                font-weight: 600;
                color: var(--primary);
            }
            
            .cta-section .lead {
                font-size: 1.25rem;
                color: var(--text);
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }
            
            .btn-cta {
                padding: 1rem 2.5rem;
                font-size: 1.1rem;
                box-shadow: var(--shadow-sm);
            }
            
            .btn-cta:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
            }
            
            .section-title {
                text-align: center;
                margin-bottom: 3rem;
                color: var(--heading);
                font-weight: 600;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                    <div class="hero-content" data-aos="fade-up">
                    <h1>University Club Management System</h1>
                    <p>Empowering university students to discover, join, and manage campus clubs and organizations</p>
                    <div class="hero-buttons">
                        <a href="${pageContext.request.contextPath}/clubs" class="btn btn-primary">
                            Explore Clubs
                        </a>
                        <a href="${pageContext.request.contextPath}/create-club" class="btn btn-outline-primary">
                            Register a Club
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <!-- Stats Section -->
        <section class="stats-section">
            <div class="container">
                <div class="row g-4">
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="100">
                        <div class="stat-card">
                            <span class="stat-number">${stats.totalClubs}+</span>
                            <span class="stat-label">Active Clubs</span>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="200">
                        <div class="stat-card">
                            <span class="stat-number"><fmt:formatNumber value="${stats.totalMembers}" type="number" groupingUsed="true"/>+</span>
                            <span class="stat-label">Student Members</span>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="300">
                        <div class="stat-card">
                            <span class="stat-number">${stats.totalEvents}+</span>
                            <span class="stat-label">Events This Year</span>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="400">
                        <div class="stat-card">
                            <span class="stat-number"><fmt:formatNumber value="${stats.satisfactionRate}" type="number" maxFractionDigits="0"/>%</span>
                            <span class="stat-label">Satisfaction Rate</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Featured Clubs Section -->
        <section class="clubs-section">
            <div class="container">
                <h2 class="section-title" data-aos="fade-up">Featured Clubs</h2>
                <div class="row g-4">
                    <c:forEach var="club" items="${featuredClubs}" varStatus="status">
                        <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                            <div class="club-card card">
                                <div class="club-card-header">
                                    <c:choose>
                                        <c:when test="${not empty club.logo}">
                                            <img src="${pageContext.request.contextPath}/images/clubs/${club.logo}" 
                                                 alt="${club.clubName}" class="club-logo">
                                        </c:when>
                                        <c:otherwise>
                                                <div class="club-emoji">�</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="club-card-body">
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
                                        <div class="club-meta-item">
                                            <span>${club.memberCount} Members</span>
                                        </div>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/club-detail?id=${club.clubID}" class="btn btn-primary" style="display:block; width:100%">
                                        View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features-section">
            <div class="container">
                <h2 class="section-title" data-aos="fade-up">Why Choose UniClubs?</h2>
                <div class="row g-4">
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="100">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-search"></i>
                            </div>
                            <h4>Easy Discovery</h4>
                            <p>Find clubs that match your interests with our smart search system</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="200">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-calendar-check"></i>
                            </div>
                            <h4>Event Management</h4>
                            <p>Stay updated with upcoming events and activities</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="300">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-chat-dots"></i>
                            </div>
                            <h4>Communication</h4>
                            <p>Connect and communicate with club members easily</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="400">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="bi bi-graph-up"></i>
                            </div>
                            <h4>Track Progress</h4>
                            <p>Monitor your involvement and achievements</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="cta-section">
            <div class="container">
                <div data-aos="zoom-in">
                    <h2 class="mb-3">Ready to Get Involved?</h2>
                    <p class="lead mb-4">Join a club today and make the most of your university experience!</p>
                    <a href="${pageContext.request.contextPath}/clubs" class="btn btn-primary btn-lg btn-cta">
                        <i class="bi bi-rocket-takeoff me-2"></i> Browse All Clubs
                    </a>
                </div>
            </div>
        </section>

        <%@ include file="footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- AOS Animation -->
        <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
        <script>
            AOS.init({
                duration: 800,
                once: true,
                offset: 100
            });
        </script>
    </body>
</html>