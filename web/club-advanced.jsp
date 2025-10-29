<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${club.clubName} - UniClubs</title>
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

            .container {
                max-width: 1000px;
                margin: 3rem auto;
                padding: 0 2rem;
            }

            .club-banner {
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                padding: 3rem 2rem;
                border-radius: 15px;
                text-align: center;
                margin-bottom: 3rem;
            }

            .club-banner .logo {
                font-size: 5rem;
                margin-bottom: 1rem;
            }

            .club-banner h1 {
                font-size: 2.5rem;
                margin-bottom: 1rem;
            }

            .club-content {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }

            .club-content h2 {
                color: #2193b0;
                margin-bottom: 1rem;
            }

            .club-stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
                margin: 2rem 0;
            }

            .stat-box {
                background: #f5f7fa;
                padding: 1.5rem;
                border-radius: 10px;
                text-align: center;
            }

            .stat-box .number {
                font-size: 2rem;
                font-weight: bold;
                color: #2193b0;
            }

            .stat-box .label {
                color: #666;
                margin-top: 0.5rem;
            }

            .btn-join {
                display: inline-block;
                background: #2193b0;
                color: white;
                padding: 1rem 3rem;
                border-radius: 30px;
                text-decoration: none;
                font-weight: 600;
                font-size: 1.1rem;
                margin-top: 2rem;
            }

            .btn-back {
                display: inline-block;
                color: #2193b0;
                text-decoration: none;
                margin-bottom: 2rem;
            }
            .alert {
                padding: 1rem 1.5rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                font-weight: 500;
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .alert-error {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
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
            </nav>
        </header>

        <div class="container">
            <a href="${pageContext.request.contextPath}/clubs" class="btn-back">← Back to Clubs</a>

            <!-- Success/Error Messages -->
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">
                    ${sessionScope.success}
                </div>
                <c:remove var="success" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="alert alert-error">
                    ${sessionScope.error}
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <a href="${pageContext.request.contextPath}/clubs" class="btn-back">← Back to Clubs</a>

            <div class="club-banner">
                <div class="logo">
                    <c:choose>
                        <c:when test="${not empty club.logo}">
                            <img src="${pageContext.request.contextPath}/images/clubs/${club.logo}" 
                                 alt="${club.clubName}" style="width: 100px; height: 100px; border-radius: 50%;">
                        </c:when>
                        <c:otherwise>
                            🎯
                        </c:otherwise>
                    </c:choose>
                </div>
                <h1>${club.clubName}</h1>
                <p>Join us and be part of something amazing!</p>
            </div>

            <div class="club-stats">
                <div class="stat-box">
                    <div class="number">${club.memberCount}</div>
                    <div class="label">Active Members</div>
                </div>
                <div class="stat-box">
                    <div class="number">${club.status}</div>
                    <div class="label">Status</div>
                </div>
            </div>

            <div class="club-content">
                <h2>About This Club</h2>
                <p>${club.description}</p>

                <a href="${pageContext.request.contextPath}/join-club?id=${club.clubID}" class="btn-join">Join This Club</a>
            </div>
        </div>
    </body>
</html>