<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Find Your Club - UniClubs</title>
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

            nav a {
                color: white;
                text-decoration: none;
            }

            .container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            .search-section {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .search-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .search-header h1 {
                color: #2193b0;
                margin-bottom: 0.5rem;
            }

            .search-form {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1rem;
                margin-bottom: 1.5rem;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            .form-group label {
                margin-bottom: 0.5rem;
                color: #333;
                font-weight: 500;
            }

            .form-group input,
            .form-group select {
                padding: 0.8rem;
                border: 2px solid #ddd;
                border-radius: 10px;
                font-size: 1rem;
            }

            .form-group input:focus,
            .form-group select:focus {
                outline: none;
                border-color: #2193b0;
            }

            .filter-buttons {
                display: flex;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .filter-tag {
                padding: 0.5rem 1rem;
                background: #e3f2fd;
                color: #2193b0;
                border: 2px solid #2193b0;
                border-radius: 20px;
                cursor: pointer;
                transition: all 0.3s;
            }

            .filter-tag:hover,
            .filter-tag.active {
                background: #2193b0;
                color: white;
            }

            .btn-search {
                padding: 1rem 3rem;
                background: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                margin-top: 1rem;
            }

            .btn-clear {
                padding: 1rem 2rem;
                background: white;
                color: #2193b0;
                border: 2px solid #2193b0;
                border-radius: 10px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                margin-top: 1rem;
            }

            .results-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .results-count {
                color: #666;
                font-size: 1.1rem;
            }

            .sort-select {
                padding: 0.7rem 1rem;
                border: 2px solid #ddd;
                border-radius: 10px;
                font-size: 1rem;
            }

            .clubs-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 1.5rem;
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

            .club-body h3 {
                color: #2193b0;
                margin-bottom: 0.5rem;
            }

            .club-tags {
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                margin: 0.5rem 0;
            }

            .tag {
                padding: 0.3rem 0.8rem;
                background: #f0f0f0;
                border-radius: 15px;
                font-size: 0.85rem;
                color: #666;
            }

            .club-meta {
                display: flex;
                justify-content: space-between;
                padding-top: 1rem;
                border-top: 1px solid #eee;
                margin-top: 1rem;
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
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container">
            <div class="search-section">
                <div class="search-header">
                    <h1>Find Your Perfect Club</h1>
                    <p>Discover clubs that match your interests and passions</p>
                </div>

                <form action="${pageContext.request.contextPath}/clubs/search" method="get">
                    <div class="search-form">
                        <div class="form-group">
                            <label for="keyword">Search Keywords</label>
                            <input type="text" id="keyword" name="keyword" 
                                   placeholder="Technology, Art, Sports..." 
                                   value="${param.keyword}">
                        </div>

                        <div class="form-group">
                            <label for="category">Category</label>
                            <select id="category" name="category">
                                <option value="">All Categories</option>
                                <option value="Technology" ${param.category == 'Technology' ? 'selected' : ''}>Technology</option>
                                <option value="Arts" ${param.category == 'Arts' ? 'selected' : ''}>Arts & Culture</option>
                                <option value="Sports" ${param.category == 'Sports' ? 'selected' : ''}>Sports & Fitness</option>
                                <option value="Academic" ${param.category == 'Academic' ? 'selected' : ''}>Academic</option>
                                <option value="Social" ${param.category == 'Social' ? 'selected' : ''}>Social & Community</option>
                                <option value="Professional" ${param.category == 'Professional' ? 'selected' : ''}>Professional Development</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="memberCount">Minimum Members</label>
                            <select id="memberCount" name="memberCount">
                                <option value="">Any</option>
                                <option value="10" ${param.memberCount == '10' ? 'selected' : ''}>10+ members</option>
                                <option value="25" ${param.memberCount == '25' ? 'selected' : ''}>25+ members</option>
                                <option value="50" ${param.memberCount == '50' ? 'selected' : ''}>50+ members</option>
                                <option value="100" ${param.memberCount == '100' ? 'selected' : ''}>100+ members</option>
                            </select>
                        </div>
                    </div>

                    <div style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Quick Filters:</label>
                        <div class="filter-buttons">
                            <span class="filter-tag" onclick="selectCategory('Technology')">💻 Tech</span>
                            <span class="filter-tag" onclick="selectCategory('Arts')">🎨 Arts</span>
                            <span class="filter-tag" onclick="selectCategory('Sports')">⚽ Sports</span>
                            <span class="filter-tag" onclick="selectCategory('Academic')">📚 Academic</span>
                            <span class="filter-tag" onclick="selectCategory('Social')">🤝 Social</span>
                        </div>
                    </div>

                    <div style="display: flex; gap: 1rem;">
                        <button type="submit" class="btn-search">🔍 Search Clubs</button>
                        <button type="button" class="btn-clear" onclick="clearFilters()">Clear Filters</button>
                    </div>
                </form>
            </div>

            <div class="results-header">
                <div class="results-count">
                    Found <strong>${clubs.size()}</strong> clubs
                </div>
                <select class="sort-select" onchange="sortResults(this.value)">
                    <option value="name">Sort by Name</option>
                    <option value="members">Sort by Members</option>
                    <option value="newest">Newest First</option>
                </select>
            </div>

            <div class="clubs-grid">
                <c:forEach var="club" items="${clubs}">
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
                            <h3>${club.clubName}</h3>
                            <div class="club-tags">
                                <span class="tag">${club.categoryName}</span>
                                <c:if test="${club.memberCount > 50}">
                                    <span class="tag">⭐ Popular</span>
                                </c:if>
                            </div>
                            <p>${club.description}</p>
                            <div class="club-meta">
                                <span>👥 ${club.memberCount} Members</span>
                                <span>📍 Active</span>
                            </div>
                            <a href="${pageContext.request.contextPath}/club-detail?id=${club.clubID}" class="btn-view">
                                View Details →
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
    </div>
    <%@ include file="footer.jsp" %>
        
    <script>
            function selectCategory(category) {
                document.getElementById('category').value = category;
                document.querySelector('form').submit();
            }

            function clearFilters() {
                document.getElementById('keyword').value = '';
                document.getElementById('category').value = '';
                document.getElementById('memberCount').value = '';
            }

            function sortResults(sortBy) {
                const url = new URL(window.location);
                url.searchParams.set('sort', sortBy);
                window.location = url;
            }
        </script>
    </body>
</html>