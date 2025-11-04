<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${club.clubName} - UniClubs</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            :root {
                --primary: #667eea;
                --primary-dark: #5568d3;
                --text-primary: #1e293b;
                --text-secondary: #64748b;
                --border: #e2e8f0;
                --bg-light: #f8f9fa;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background: #f8f9fa;
                color: var(--text-primary);
                line-height: 1.6;
                padding-top: 76px;
            }

            /* Header */
            header {
                background: white;
                border-bottom: 1px solid var(--border);
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1000;
            }

            nav {
                padding: 1.25rem 0;
            }

            .logo {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--primary);
                text-decoration: none;
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
                color: var(--text-secondary);
                text-decoration: none;
                font-weight: 500;
                transition: color 0.2s ease;
            }

            .nav-links a:hover {
                color: var(--primary);
            }

            /* Container */
            .main-container {
                max-width: 900px;
                margin: 0 auto;
                padding: 2rem 1rem;
            }

            /* Back Link */
            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--text-secondary);
                text-decoration: none;
                font-size: 0.9375rem;
                font-weight: 500;
                margin-bottom: 2rem;
                transition: color 0.2s ease;
            }

            .back-link:hover {
                color: var(--primary);
            }

            /* Alerts */
            .alert {
                padding: 0.875rem 1rem;
                border-radius: 8px;
                margin-bottom: 1.5rem;
                border: 1px solid;
                font-size: 0.9375rem;
            }

            .alert-success {
                background: #f0fdf4;
                border-color: #86efac;
                color: #166534;
            }

            .alert-danger {
                background: #fef2f2;
                border-color: #fca5a5;
                color: #991b1b;
            }

            /* Club Header */
            .club-header {
                background: white;
                border: 1px solid var(--border);
                border-radius: 12px;
                padding: 2.5rem;
                margin-bottom: 1.5rem;
            }

            .club-logo-container {
                width: 80px;
                height: 80px;
                background: var(--bg-light);
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 1.5rem;
                border: 1px solid var(--border);
            }

            .club-logo-container img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 12px;
            }

            .club-logo-placeholder {
                font-size: 2rem;
                color: var(--text-secondary);
            }

            .club-header h1 {
                font-size: 2rem;
                font-weight: 700;
                color: var(--text-primary);
                margin-bottom: 0.5rem;
                letter-spacing: -0.02em;
            }

            .club-header p {
                color: var(--text-secondary);
                font-size: 1rem;
                margin: 0;
            }

            /* Stats */
            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .stat-box {
                background: white;
                border: 1px solid var(--border);
                border-radius: 12px;
                padding: 1.5rem;
            }

            .stat-label {
                font-size: 0.875rem;
                color: var(--text-secondary);
                margin-bottom: 0.5rem;
                font-weight: 500;
            }

            .stat-value {
                font-size: 1.75rem;
                font-weight: 700;
                color: var(--text-primary);
            }

            /* Content Section */
            .content-section {
                background: white;
                border: 1px solid var(--border);
                border-radius: 12px;
                padding: 2rem;
                margin-bottom: 1.5rem;
            }

            .content-section h2 {
                font-size: 1.25rem;
                font-weight: 700;
                color: var(--text-primary);
                margin-bottom: 1rem;
            }

            .content-section p {
                color: var(--text-secondary);
                line-height: 1.7;
                margin: 0;
            }

            /* Features List */
            .features-list {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .feature-item {
                padding: 1rem 0;
                border-bottom: 1px solid var(--border);
            }

            .feature-item:last-child {
                border-bottom: none;
            }

            .feature-item h3 {
                font-size: 1rem;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 0.25rem;
            }

            .feature-item p {
                font-size: 0.9375rem;
                color: var(--text-secondary);
                margin: 0;
            }

            /* Join Button */
            .btn-join {
                display: inline-block;
                background: var(--primary);
                color: white;
                padding: 0.875rem 2rem;
                border-radius: 8px;
                font-size: 0.9375rem;
                font-weight: 600;
                text-decoration: none;
                border: none;
                cursor: pointer;
                transition: background 0.2s ease;
            }

            .btn-join:hover {
                background: var(--primary-dark);
                color: white;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .main-container {
                    padding: 1.5rem 1rem;
                }

                .club-header {
                    padding: 1.5rem;
                }

                .club-header h1 {
                    font-size: 1.5rem;
                }

                .content-section {
                    padding: 1.5rem;
                }

                .stats-container {
                    grid-template-columns: 1fr;
                }

                body {
                    padding-top: 70px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="main-container">
            <a href="${pageContext.request.contextPath}/clubs" class="back-link">
                ← Back to Clubs
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

            <!-- Club Header -->
            <div class="club-header">
                <div class="club-logo-container">
                    <c:choose>
                        <c:when test="${not empty club.logo}">
                            <img src="${pageContext.request.contextPath}/images/clubs/${club.logo}" 
                                 alt="${club.clubName}">
                        </c:when>
                        <c:otherwise>
                            <span class="club-logo-placeholder">UC</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <h1>${club.clubName}</h1>
                <p>Join us and be part of our community</p>
            </div>

            <!-- Stats -->
            <div class="stats-container">
                <div class="stat-box">
                    <div class="stat-label">Members</div>
                    <div class="stat-value">${club.memberCount}</div>
                </div>
                <div class="stat-box">
                    <div class="stat-label">Status</div>
                    <div class="stat-value">${club.status}</div>
                </div>
            </div>

            <!-- About Section -->
            <div class="content-section">
                <h2>About This Club</h2>
                <p>${club.description}</p>
            </div>

            <!-- Join Button -->
            <div class="content-section">
                <a href="${pageContext.request.contextPath}/join-club?id=${club.clubID}" class="btn-join">
                    Join This Club
                </a>
            </div>

            <!-- Why Join Section -->
            <div class="content-section">
                <h2>Why Join?</h2>
                <ul class="features-list">
                    <li class="feature-item">
                        <h3>Learn & Grow</h3>
                        <p>Develop new skills and expand your knowledge</p>
                    </li>
                    <li class="feature-item">
                        <h3>Network</h3>
                        <p>Connect with like-minded students and mentors</p>
                    </li>
                    <li class="feature-item">
                        <h3>Events</h3>
                        <p>Participate in exciting activities and workshops</p>
                    </li>
                </ul>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>