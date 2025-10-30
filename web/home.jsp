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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

        <style>
            /* Hero Section */
            .hero-section {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 120px 0 80px;
                position: relative;
                overflow: hidden;
            }

            .hero-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="rgba(255,255,255,0.1)" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,122.7C672,117,768,139,864,154.7C960,171,1056,181,1152,165.3C1248,149,1344,107,1392,85.3L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') no-repeat bottom;
                background-size: cover;
                opacity: 0.3;
            }

            .hero-content {
                position: relative;
                z-index: 1;
                text-align: center;
            }

            .hero-content h1 {
                font-size: 3.5rem;
                font-weight: 800;
                margin-bottom: 1.5rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
                line-height: 1.2;
            }

            .hero-content p {
                font-size: 1.3rem;
                margin-bottom: 2.5rem;
                max-width: 700px;
                margin-left: auto;
                margin-right: auto;
                opacity: 0.95;
            }

            .hero-buttons .btn {
                padding: 15px 40px;
                font-size: 1.1rem;
                font-weight: 600;
                border-radius: 50px;
                margin: 0 10px;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
            }

            .btn-hero-primary {
                background: white;
                color: #667eea;
                border: 3px solid white;
            }

            .btn-hero-primary:hover {
                background: transparent;
                color: white;
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }

            .btn-hero-secondary {
                background: transparent;
                color: white;
                border: 3px solid white;
            }

            .btn-hero-secondary:hover {
                background: white;
                color: #667eea;
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }

            /* Stats Section */
            .stats-section {
                background: #f8f9fa;
                padding: 60px 0;
                margin-top: -40px;
                position: relative;
                z-index: 2;
            }

            .stat-card {
                background: white;
                border-radius: 20px;
                padding: 40px 20px;
                text-align: center;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                height: 100%;
            }

            .stat-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(102, 126, 234, 0.3);
            }

            .stat-icon {
                font-size: 3rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 15px;
            }

            .stat-number {
                font-size: 3rem;
                font-weight: 800;
                color: #667eea;
                display: block;
                margin-bottom: 10px;
            }

            .stat-label {
                font-size: 1.1rem;
                color: #6c757d;
                font-weight: 600;
            }

            /* Featured Clubs Section */
            .clubs-section {
                padding: 80px 0;
            }

            .section-title {
                font-size: 2.5rem;
                font-weight: 800;
                text-align: center;
                margin-bottom: 60px;
                color: #2d3748;
                position: relative;
                padding-bottom: 20px;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 4px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 2px;
            }

            .club-card {
                background: white;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
                transition: all 0.3s ease;
                height: 100%;
                border: 2px solid transparent;
            }

            .club-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(102, 126, 234, 0.2);
                border-color: #667eea;
            }

            .club-card-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                padding: 40px 20px;
                text-align: center;
                position: relative;
            }

            .club-logo {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                border: 5px solid white;
                box-shadow: 0 5px 20px rgba(0,0,0,0.2);
                object-fit: cover;
            }

            .club-emoji {
                font-size: 80px;
                filter: drop-shadow(0 5px 10px rgba(0,0,0,0.2));
            }

            .club-card-body {
                padding: 30px;
            }

            .club-card-body h4 {
                font-size: 1.5rem;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 15px;
            }

            .club-card-body p {
                color: #6c757d;
                line-height: 1.6;
                margin-bottom: 20px;
                min-height: 72px;
            }

            .club-meta {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 15px 0;
                border-top: 2px solid #f1f3f5;
                margin-bottom: 20px;
            }

            .club-meta-item {
                display: flex;
                align-items: center;
                gap: 8px;
                color: #667eea;
                font-weight: 600;
            }

            .club-meta-item i {
                font-size: 1.2rem;
            }

            .btn-view-club {
                display: block;
                width: 100%;
                padding: 12px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-align: center;
                border-radius: 50px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .btn-view-club:hover {
                transform: scale(1.05);
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
                color: white;
            }

            /* CTA Section */
            .cta-section {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 100px 0;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .cta-section::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
                background-size: 50px 50px;
                animation: moveBackground 20s linear infinite;
            }

            @keyframes moveBackground {
                0% {
                    transform: translate(0, 0);
                }
                100% {
                    transform: translate(50px, 50px);
                }
            }

            .cta-section h2 {
                font-size: 3rem;
                font-weight: 800;
                margin-bottom: 20px;
                position: relative;
                z-index: 1;
            }

            .cta-section p {
                font-size: 1.3rem;
                margin-bottom: 40px;
                opacity: 0.95;
                position: relative;
                z-index: 1;
            }

            .btn-cta {
                padding: 18px 50px;
                font-size: 1.2rem;
                font-weight: 700;
                background: white;
                color: #667eea;
                border: 3px solid white;
                border-radius: 50px;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s ease;
                position: relative;
                z-index: 1;
            }

            .btn-cta:hover {
                background: transparent;
                color: white;
                transform: translateY(-5px) scale(1.05);
                box-shadow: 0 15px 40px rgba(0,0,0,0.3);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .hero-content h1 {
                    font-size: 2.2rem;
                }

                .hero-content p {
                    font-size: 1.1rem;
                }

                .hero-buttons .btn {
                    display: block;
                    margin: 10px auto;
                    max-width: 300px;
                }

                .stat-number {
                    font-size: 2.5rem;
                }

                .section-title {
                    font-size: 2rem;
                }

                .cta-section h2 {
                    font-size: 2rem;
                }
            }

            /* Features Section */
            .features-section {
                padding: 80px 0;
                background: #f8f9fa;
            }

            .feature-card {
                text-align: center;
                padding: 40px 30px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
                transition: all 0.3s ease;
                height: 100%;
            }

            .feature-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(102, 126, 234, 0.2);
            }

            .feature-icon {
                width: 80px;
                height: 80px;
                margin: 0 auto 20px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2rem;
                color: white;
            }

            .feature-card h4 {
                font-size: 1.3rem;
                font-weight: 700;
                margin-bottom: 15px;
                color: #2d3748;
            }

            .feature-card p {
                color: #6c757d;
                line-height: 1.6;
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
                        <a href="${pageContext.request.contextPath}/clubs" class="btn btn-hero-primary">
                            <i class="bi bi-compass"></i> Explore Clubs
                        </a>
                        <a href="${pageContext.request.contextPath}/create-club" class="btn btn-hero-secondary">
                            <i class="bi bi-plus-circle"></i> Register a Club
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
                            <div class="stat-icon">
                                <i class="bi bi-people-fill"></i>
                            </div>
                            <span class="stat-number">${stats.totalClubs}+</span>
                            <span class="stat-label">Active Clubs</span>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="200">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-person-check-fill"></i>
                            </div>
                            <span class="stat-number"><fmt:formatNumber value="${stats.totalMembers}" type="number" groupingUsed="true"/>+</span>
                            <span class="stat-label">Student Members</span>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="300">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-calendar-event-fill"></i>
                            </div>
                            <span class="stat-number">${stats.totalEvents}+</span>
                            <span class="stat-label">Events This Year</span>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="400">
                        <div class="stat-card">
                            <div class="stat-icon">
                                <i class="bi bi-emoji-smile-fill"></i>
                            </div>
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
                            <div class="club-card">
                                <div class="club-card-header">
                                    <c:choose>
                                        <c:when test="${not empty club.logo}">
                                            <img src="${pageContext.request.contextPath}/images/clubs/${club.logo}" 
                                                 alt="${club.clubName}" class="club-logo">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="club-emoji">🎯</div>
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
                                            <i class="bi bi-people-fill"></i>
                                            <span>${club.memberCount} Members</span>
                                        </div>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/club-detail?id=${club.clubID}" class="btn-view-club">
                                        <i class="bi bi-arrow-right-circle"></i> View Details
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
                    <h2>Ready to Get Involved?</h2>
                    <p>Join a club today and make the most of your university experience!</p>
                    <a href="${pageContext.request.contextPath}/clubs" class="btn-cta">
                        <i class="bi bi-rocket-takeoff"></i> Browse All Clubs
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