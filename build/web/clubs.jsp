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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
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
            transition: opacity 0.3s;
        }

        nav a:hover {
            opacity: 0.8;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-header h1 {
            font-size: 2.5rem;
            color: #2193b0;
            margin-bottom: 1rem;
        }

        .search-box {
            max-width: 600px;
            margin: 2rem auto;
            display: flex;
            gap: 1rem;
        }

        .search-box input {
            flex: 1;
            padding: 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
        }

        .search-box button {
            padding: 1rem 2rem;
            background: #2193b0;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            cursor: pointer;
            font-weight: 600;
        }

        .search-box button:hover {
            background: #1a7a94;
        }

        .clubs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .club-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }

        .club-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.15);
        }

        .club-card-header {
            background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
            padding: 2rem;
            text-align: center;
            color: white;
        }

        .club-logo {
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        .club-logo img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid white;
        }

        .club-card h2 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .club-card-body {
            padding: 1.5rem;
        }

        .club-description {
            color: #666;
            margin-bottom: 1.5rem;
            min-height: 60px;
        }

        .club-stats {
            display: flex;
            justify-content: space-around;
            padding: 1rem 0;
            border-top: 1px solid #e0e0e0;
            margin-top: 1rem;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2193b0;
        }

        .stat-label {
            font-size: 0.85rem;
            color: #666;
            margin-top: 0.25rem;
        }

        .btn-view {
            display: block;
            width: 100%;
            padding: 0.75rem;
            background: #2193b0;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            margin-top: 1rem;
            transition: background 0.3s;
        }

        .btn-view:hover {
            background: #1a7a94;
        }

        .no-clubs {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .no-clubs h2 {
            color: #2193b0;
            margin-bottom: 1rem;
        }

        .no-clubs p {
            color: #666;
            font-size: 1.1rem;
        }

        .total-count {
            text-align: center;
            color: #666;
            margin-bottom: 2rem;
            font-size: 1.1rem;
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
        <div class="page-header">
            <h1>Explore Our Clubs</h1>
            <p>Find your passion and connect with like-minded students</p>
        </div>

        <!-- Search Box -->
        <form action="${pageContext.request.contextPath}/clubs" method="get" class="search-box">
            <input type="text" 
                   name="search" 
                   placeholder="Search clubs..." 
                   value="${searchKeyword}">
            <button type="submit">Search</button>
        </form>

        <!-- Total Count -->
        <c:if test="${not empty clubs}">
            <div class="total-count">
                Found ${clubs.size()} club(s)
            </div>
        </c:if>

        <!-- Clubs Grid -->
        <c:choose>
            <c:when test="${not empty clubs}">
                <div class="clubs-grid">
                    <c:forEach var="club" items="${clubs}">
                        <div class="club-card" onclick="window.location.href='${pageContext.request.contextPath}/club-detail?id=${club.clubID}'">
                            <div class="club-card-header">
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
</body>
</html>