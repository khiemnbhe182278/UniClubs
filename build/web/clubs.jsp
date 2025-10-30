<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Clubs - UniClubs</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                line-height: 1.6;
                color: #1a1a1a;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding-top: 80px;
            }

            header {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                padding: 1.2rem 0;
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1000;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            nav {
                max-width: 1400px;
                margin: 0 auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0 2rem;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: 800;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            nav ul {
                list-style: none;
                display: flex;
                gap: 2.5rem;
            }

            nav a {
                color: #333;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s;
                position: relative;
            }

            nav a:hover {
                color: #667eea;
            }

            nav a::after {
                content: '';
                position: absolute;
                bottom: -5px;
                left: 0;
                width: 0;
                height: 2px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                transition: width 0.3s;
            }

            nav a:hover::after {
                width: 100%;
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 3rem 2rem;
            }

            .page-hero {
                text-align: center;
                margin-bottom: 4rem;
                color: white;
            }

            .page-hero h1 {
                font-size: 3.5rem;
                font-weight: 800;
                margin-bottom: 1rem;
                text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            }

            .page-hero p {
                font-size: 1.3rem;
                opacity: 0.95;
                font-weight: 300;
            }

            .search-section {
                max-width: 700px;
                margin: 0 auto 3rem;
            }

            .search-box {
                display: flex;
                gap: 1rem;
                background: white;
                padding: 0.5rem;
                border-radius: 50px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
            }

            .search-box input {
                flex: 1;
                padding: 1rem 1.5rem;
                border: none;
                border-radius: 50px;
                font-size: 1rem;
                outline: none;
            }

            .search-box input::placeholder {
                color: #999;
            }

            .search-box button {
                padding: 1rem 2.5rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 50px;
                font-size: 1rem;
                cursor: pointer;
                font-weight: 700;
                transition: all 0.3s;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            }

            .search-box button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
            }

            .total-count {
                text-align: center;
                color: white;
                margin-bottom: 2rem;
                font-size: 1.2rem;
                font-weight: 500;
            }

            .clubs-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
                gap: 2.5rem;
            }

            .club-card {
                background: white;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                cursor: pointer;
                position: relative;
            }

            .club-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 5px;
                background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
                transform: scaleX(0);
                transition: transform 0.3s;
            }

            .club-card:hover::before {
                transform: scaleX(1);
            }

            .club-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
            }

            .club-card-header {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                padding: 3rem 2rem 2rem;
                text-align: center;
                position: relative;
            }

            .club-initial {
                width: 100px;
                height: 100px;
                margin: 0 auto 1.5rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2.5rem;
                font-weight: 800;
                color: white;
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            }

            .club-card h2 {
                font-size: 1.6rem;
                margin-bottom: 0.5rem;
                color: #1a1a1a;
                font-weight: 700;
            }

            .club-card-body {
                padding: 2rem;
            }

            .club-description {
                color: #666;
                margin-bottom: 2rem;
                min-height: 60px;
                font-size: 0.95rem;
                line-height: 1.7;
            }

            .club-stats {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-item {
                background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
                padding: 1.5rem;
                border-radius: 15px;
                text-align: center;
                transition: all 0.3s;
            }

            .stat-item:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .stat-number {
                font-size: 1.8rem;
                font-weight: 800;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 0.3rem;
            }

            .stat-label {
                font-size: 0.85rem;
                color: #666;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .btn-view {
                display: block;
                width: 100%;
                padding: 1rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 12px;
                font-weight: 700;
                transition: all 0.3s;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }

            .btn-view:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            }

            .no-clubs {
                text-align: center;
                padding: 5rem 2rem;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                margin: 0 auto;
            }

            .no-clubs h2 {
                font-size: 2rem;
                margin-bottom: 1rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-weight: 800;
            }

            .no-clubs p {
                color: #666;
                font-size: 1.1rem;
                line-height: 1.7;
            }

            @media (max-width: 768px) {
                .page-hero h1 {
                    font-size: 2.5rem;
                }

                .clubs-grid {
                    grid-template-columns: 1fr;
                    gap: 2rem;
                }

                nav ul {
                    gap: 1.5rem;
                }

                .search-box {
                    flex-direction: column;
                    border-radius: 20px;
                    padding: 1rem;
                }

                .search-box button {
                    border-radius: 12px;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container">
            <div class="page-hero">
                <h1>Explore Our Clubs</h1>
                <p>Find your passion and connect with like-minded students</p>
            </div>

            <!-- Search Box -->
            <div class="search-section">
                <form action="${pageContext.request.contextPath}/clubs" method="get" class="search-box">
                    <input type="text" 
                           name="search" 
                           placeholder="Search clubs by name or description..." 
                           value="${searchKeyword}">
                    <button type="submit">Search</button>
                </form>
            </div>

            <!-- Total Count -->
            <c:if test="${not empty clubs}">
                <div class="total-count">
                    Found ${clubs.size()} club${clubs.size() > 1 ? 's' : ''}
                </div>
            </c:if>

            <!-- Clubs Grid -->
            <c:choose>
                <c:when test="${not empty clubs}">
                    <div class="clubs-grid">
                        <c:forEach var="club" items="${clubs}">
                            <div class="club-card" onclick="window.location.href = '${pageContext.request.contextPath}/club-detail?id=${club.clubID}'">
                                <div class="club-card-header">
                                    <div class="club-initial">
                                        ${club.clubName.substring(0, 1).toUpperCase()}
                                    </div>
                                    <h2>${club.clubName}</h2>
                                </div>
                                <div class="club-card-body">
                                    <p class="club-description">${club.description}</p>

                                    <div class="club-stats">
                                        <div class="stat-item">
                                            <div class="stat-number">${club.memberCount}</div>
                                            <div class="stat-label">Members</div>
                                        </div>
                                        <div class="stat-item">
                                            <div class="stat-number">${club.status}</div>
                                            <div class="stat-label">Status</div>
                                        </div>
                                    </div>

                                    <a href="${pageContext.request.contextPath}/club-detail?id=${club.clubID}" 
                                       class="btn-view">View Details</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-clubs">
                        <h2>No Clubs Found</h2>
                        <p>
                            <c:choose>
                                <c:when test="${not empty searchKeyword}">
                                    No clubs match your search "${searchKeyword}". Try a different keyword.
                                </c:when>
                                <c:otherwise>
                                    There are no active clubs at the moment. Check back later!
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>