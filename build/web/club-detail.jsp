<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${club.clubName} - UniClubs</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --primary-color: #667eea;
                --secondary-color: #764ba2;
            }

            body {
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f8f9fa;
                padding-top: 76px;
            }

            /* Header */
            header {
                background: var(--primary-gradient);
                box-shadow: 0 4px 20px rgba(0,0,0,0.1);
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1000;
            }

            nav {
                padding: 1rem 0;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: 800;
                color: white;
                text-decoration: none;
                letter-spacing: -0.5px;
            }

            .nav-links {
                display: flex;
                gap: 2rem;
                list-style: none;
                margin: 0;
                padding: 0;
                align-items: center;
            }

            .nav-links a {
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                position: relative;
            }

            .nav-links a::after {
                content: '';
                position: absolute;
                width: 0;
                height: 2px;
                bottom: -5px;
                left: 0;
                background: white;
                transition: width 0.3s ease;
            }

            .nav-links a:hover::after {
                width: 100%;
            }

            /* Back Button */
            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
                margin-bottom: 2rem;
                transition: all 0.3s ease;
            }

            .back-link:hover {
                gap: 0.75rem;
                color: #764ba2;
            }

            /* Club Banner */
            .club-banner {
                background: var(--primary-gradient);
                border-radius: 24px;
                padding: 3rem 2rem;
                color: white;
                text-align: center;
                margin-bottom: 2rem;
                position: relative;
                overflow: hidden;
                box-shadow: 0 10px 40px rgba(102, 126, 234, 0.3);
            }

            .club-banner::before {
                content: '';
                position: absolute;
                width: 300px;
                height: 300px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                top: -100px;
                right: -100px;
            }

            .club-banner::after {
                content: '';
                position: absolute;
                width: 200px;
                height: 200px;
                background: rgba(255, 255, 255, 0.08);
                border-radius: 50%;
                bottom: -50px;
                left: -50px;
            }

            .club-banner-content {
                position: relative;
                z-index: 1;
            }

            .club-logo {
                width: 120px;
                height: 120px;
                margin: 0 auto 1.5rem;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 4rem;
                backdrop-filter: blur(10px);
                border: 4px solid rgba(255, 255, 255, 0.3);
            }

            .club-logo img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 50%;
            }

            .club-banner h1 {
                font-size: 3rem;
                font-weight: 800;
                margin-bottom: 1rem;
                letter-spacing: -1px;
            }

            .club-banner p {
                font-size: 1.25rem;
                opacity: 0.95;
            }

            /* Stats Grid */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                padding: 2rem;
                border-radius: 20px;
                text-align: center;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 30px rgba(102, 126, 234, 0.2);
                border-color: #667eea;
            }

            .stat-icon {
                width: 60px;
                height: 60px;
                background: var(--primary-gradient);
                border-radius: 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1rem;
                font-size: 1.5rem;
            }

            .stat-number {
                font-size: 2.5rem;
                font-weight: 800;
                background: var(--primary-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 0.5rem;
            }

            .stat-label {
                color: #6c757d;
                font-weight: 600;
                font-size: 1rem;
            }

            /* Content Card */
            .content-card {
                background: white;
                border-radius: 24px;
                padding: 2.5rem;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                margin-bottom: 2rem;
            }

            .content-card h2 {
                color: #1a1a2e;
                font-weight: 800;
                margin-bottom: 1.5rem;
                font-size: 2rem;
            }

            .content-card p {
                color: #6c757d;
                font-size: 1.1rem;
                line-height: 1.8;
                margin-bottom: 2rem;
            }

            /* Join Button */
            .btn-join {
                background: var(--primary-gradient);
                color: white;
                border: none;
                padding: 1rem 3rem;
                border-radius: 50px;
                font-size: 1.1rem;
                font-weight: 700;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .btn-join::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transition: left 0.5s ease;
            }

            .btn-join:hover::before {
                left: 100%;
            }

            .btn-join:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
                color: white;
            }

            /* Alerts */
            .alert {
                border-radius: 16px;
                border: none;
                padding: 1.25rem 1.5rem;
                margin-bottom: 2rem;
                font-weight: 500;
                animation: slideDown 0.3s ease;
            }

            @keyframes slideDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .alert-success {
                background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
                color: #155724;
                border-left: 4px solid #28a745;
            }

            .alert-danger {
                background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
                color: #721c24;
                border-left: 4px solid #dc3545;
            }

            /* Features Section */
            .features-section {
                background: white;
                border-radius: 24px;
                padding: 2.5rem;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                margin-bottom: 2rem;
            }

            .features-section h3 {
                color: #1a1a2e;
                font-weight: 700;
                margin-bottom: 1.5rem;
            }

            .feature-item {
                display: flex;
                align-items: start;
                gap: 1rem;
                padding: 1rem;
                background: #f8f9fa;
                border-radius: 12px;
                margin-bottom: 1rem;
                transition: all 0.3s ease;
            }

            .feature-item:hover {
                background: #e9ecef;
                transform: translateX(5px);
            }

            .feature-icon {
                width: 40px;
                height: 40px;
                background: var(--primary-gradient);
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-shrink: 0;
            }

            .feature-content h5 {
                color: #1a1a2e;
                font-weight: 600;
                margin-bottom: 0.25rem;
            }

            .feature-content p {
                color: #6c757d;
                margin: 0;
                font-size: 0.95rem;
            }

            /* Responsive */
            @media (max-width: 768px) {
                body {
                    padding-top: 70px;
                }

                .club-banner {
                    padding: 2rem 1.5rem;
                }

                .club-banner h1 {
                    font-size: 2rem;
                }

                .content-card {
                    padding: 1.5rem;
                }

                .stats-grid {
                    grid-template-columns: 1fr;
                }

                .nav-links {
                    gap: 1rem;
                    font-size: 0.9rem;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container py-4">
            <a href="${pageContext.request.contextPath}/clubs" class="back-link">
                <span>←</span> Back to Clubs
            </a>

            <!-- Alerts -->
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success" role="alert">
                    ${sessionScope.success}
                </div>
                <c:remove var="success" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-danger" role="alert">
                    ${sessionScope.error}
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <!-- Club Banner -->
            <div class="club-banner">
                <div class="club-banner-content">
                    <div class="club-logo">
                        <c:choose>
                            <c:when test="${not empty club.logo}">
                                <img src="${pageContext.request.contextPath}/images/clubs/${club.logo}" 
                                     alt="${club.clubName}">
                            </c:when>
                            <c:otherwise>
                                🎯
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h1>${club.clubName}</h1>
                    <p>Join us and be part of something amazing!</p>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">👥</div>
                    <div class="stat-number">${club.memberCount}</div>
                    <div class="stat-label">Active Members</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">✨</div>
                    <div class="stat-number">${club.status}</div>
                    <div class="stat-label">Club Status</div>
                </div>
            </div>

            <!-- About Section -->
            <div class="content-card">
                <h2>About This Club</h2>
                <p>${club.description}</p>
                <a href="${pageContext.request.contextPath}/join-club?id=${club.clubID}" class="btn-join">
                    Join This Club
                </a>
            </div>

            <!-- Features Section -->
            <div class="features-section">
                <h3>Why Join Us?</h3>
                <div class="feature-item">
                    <div class="feature-icon">🎓</div>
                    <div class="feature-content">
                        <h5>Learn & Grow</h5>
                        <p>Develop new skills and expand your knowledge</p>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">🤝</div>
                    <div class="feature-content">
                        <h5>Network</h5>
                        <p>Connect with like-minded students and mentors</p>
                    </div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">🎉</div>
                    <div class="feature-content">
                        <h5>Events</h5>
                        <p>Participate in exciting activities and workshops</p>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>