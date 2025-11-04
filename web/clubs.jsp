<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Clubs - UniClubs</title>
        <!-- page-level inline styles removed in favour of shared minimal CSS (admin.css) -->
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="hero-content">
                    <h1>Explore Our Clubs</h1>
                    <p>Find your passion and connect with like-minded students in our diverse community of university clubs</p>
                </div>

                <!-- Search Box -->
                <div class="search-section">
                    <form action="${pageContext.request.contextPath}/clubs" method="get" class="search-box">
                        <input type="text" 
                               name="search" 
                               placeholder="Search clubs by name or description..." 
                               value="${searchKeyword}">
                        <button type="submit">Search Clubs</button>
                    </form>
                </div>

                <!-- Total Count -->
                <c:if test="${not empty clubs}">
                    <div class="text-center text-muted mb-4">
                        Found ${clubs.size()} club${clubs.size() > 1 ? 's' : ''}
                    </div>
                </c:if>
            </div>
        </section>

            <!-- Clubs Grid -->
            <section class="py-5 bg-white">
                <div class="container">
                    <c:choose>
                        <c:when test="${not empty clubs}">
                            <div class="clubs-grid">
                                <c:forEach var="club" items="${clubs}">
                                    <div class="club-card">
                                        <div class="club-card-header">
                                            <div class="club-logo d-flex align-items-center justify-content-center bg-gradient-primary text-white fs-3 fw-bold">
                                                ${club.clubName.substring(0, 1).toUpperCase()}
                                            </div>
                                            <h4>${club.clubName}</h4>
                                        </div>
                                        <div class="club-card-body">
                                            <p class="club-description">${club.description}</p>

                                            <div class="club-meta">
                                                <div class="club-meta-item">
                                                    ${club.memberCount} Members · ${club.status}
                                                </div>
                                            </div>

                                            <a href="${pageContext.request.contextPath}/club-detail?id=${club.clubID}" 
                                               class="btn btn-primary w-100">View Details</a>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <div class="card mx-auto" style="max-width: 500px;">
                            <div class="card-body p-5">
                                <h2 class="h3 mb-4">No Clubs Found</h2>
                                <p class="text-muted mb-4">
                                    <c:choose>
                                        <c:when test="${not empty searchKeyword}">
                                            No clubs match your search "${searchKeyword}". Try a different keyword.
                                        </c:when>
                                        <c:otherwise>
                                            There are no active clubs at the moment. Check back later!
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                <a href="${pageContext.request.contextPath}/clubs" class="btn btn-primary">
                                    Browse All Clubs
                                </a>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
        <%@ include file="footer.jsp" %>
    </body>
</html>