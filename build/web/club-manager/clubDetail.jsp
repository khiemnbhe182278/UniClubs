<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${club.clubName} - Club Details</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background: #fafafa;
                color: #1a1a1a;
                line-height: 1.6;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                min-height: 100vh;
            }

            .header {
                border-bottom: 1px solid #e5e7eb;
                padding: 40px 40px 30px;
            }

            .club-info h1 {
                font-size: 2.5rem;
                font-weight: 600;
                color: #111827;
                margin-bottom: 8px;
            }

            .club-description {
                font-size: 1.1rem;
                color: #6b7280;
                margin-bottom: 16px;
            }

            .status-indicator {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 0.875rem;
                font-weight: 500;
            }

            .status-approved {
                background: #f0fdf4;
                color: #166534;
            }

            .status-pending {
                background: #fefce8;
                color: #a16207;
            }

            .club-meta {
                margin-top: 16px;
                padding: 12px 16px;
                background: #f8fafc;
                border-left: 3px solid #059669;
                border-radius: 0 4px 4px 0;
                font-size: 0.95rem;
                color: #374151;
            }

            .meta-item {
                margin-bottom: 4px;
            }

            .stats {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 1px;
                background: #e5e7eb;
                margin: 30px 40px;
                border-radius: 8px;
                overflow: hidden;
            }

            .stat-item {
                background: white;
                padding: 24px;
                text-align: center;
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                color: #111827;
                margin-bottom: 4px;
            }

            .stat-label {
                font-size: 0.875rem;
                color: #6b7280;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .content {
                padding: 0 40px 40px;
            }

            .tabs {
                border-bottom: 1px solid #e5e7eb;
                margin-bottom: 40px;
            }

            .tab-list {
                display: flex;
                gap: 0;
                overflow-x: auto;
            }

            .tab {
                padding: 16px 24px;
                border: none;
                background: none;
                font-size: 0.95rem;
                color: #6b7280;
                cursor: pointer;
                border-bottom: 2px solid transparent;
                transition: all 0.2s ease;
                white-space: nowrap;
                font-weight: 500;
            }

            .tab:hover {
                color: #374151;
            }

            .tab.active {
                color: #111827;
                border-bottom-color: #111827;
            }

            .tab-content {
                display: none;
            }

            .tab-content.active {
                display: block;
            }

            .section {
                margin-bottom: 40px;
            }

            .section-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #111827;
                margin-bottom: 20px;
            }

            .card {
                background: white;
                border: 1px solid #e5e7eb;
                border-radius: 8px;
                padding: 24px;
                margin-bottom: 16px;
                transition: border-color 0.2s ease;
            }

            .card:hover {
                border-color: #d1d5db;
            }

            .table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                border: 1px solid #e5e7eb;
                border-radius: 8px;
                overflow: hidden;
            }

            .table th {
                background: #f9fafb;
                padding: 12px 16px;
                text-align: left;
                font-weight: 600;
                color: #374151;
                font-size: 0.875rem;
                border-bottom: 1px solid #e5e7eb;
            }

            .table td {
                padding: 12px 16px;
                border-bottom: 1px solid #f3f4f6;
                color: #374151;
            }

            .table tbody tr:last-child td {
                border-bottom: none;
            }

            .table tbody tr:hover {
                background: #f9fafb;
            }

            .badge {
                display: inline-block;
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 0.75rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .badge-approved {
                background: #f0fdf4;
                color: #166534;
            }

            .badge-pending {
                background: #fefce8;
                color: #a16207;
            }

            .button {
                display: inline-block;
                padding: 10px 20px;
                background: #111827;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-size: 0.875rem;
                font-weight: 500;
                border: none;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            .button:hover {
                background: #374151;
            }

            .button-secondary {
                background: white;
                color: #374151;
                border: 1px solid #d1d5db;
            }

            .button-secondary:hover {
                background: #f9fafb;
                color: #111827;
            }

            .button-group {
                display: flex;
                gap: 12px;
                margin-top: 24px;
                flex-wrap: wrap;
            }

            .empty-state {
                text-align: center;
                color: #6b7280;
                font-style: italic;
                padding: 40px 20px;
            }

            @media (max-width: 768px) {
                .header,
                .content {
                    padding-left: 20px;
                    padding-right: 20px;
                }

                .stats {
                    margin-left: 20px;
                    margin-right: 20px;
                }

                .club-info h1 {
                    font-size: 2rem;
                }

                .tab-list {
                    flex-wrap: wrap;
                }

                .button-group {
                    flex-direction: column;
                }

                .table {
                    font-size: 0.875rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <c:if test="${club != null}">
                <div class="header">
                    <div class="club-info">
                        <h1>${club.clubName}</h1>
                        <p class="club-description">${club.description}</p>
                        <span class="status-indicator ${club.status ? 'status-approved' : 'status-pending'}">
                            ${club.status ? 'Approved' : 'Pending'}
                        </span>
                        <div class="club-meta">
                            <c:if test="${club.leaderName != null}">
                                <div class="meta-item"><strong>Leader:</strong> ${club.leaderName}</div>
                            </c:if>
                            <c:if test="${club.facultyName != null}">
                                <div class="meta-item"><strong>Faculty:</strong> ${club.facultyName}</div>
                            </c:if>
                            <div class="meta-item"><strong>Created:</strong> 
                                <fmt:formatDate value="${club.createdAt}" pattern="MMM dd, yyyy" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="stats">
                    <div class="stat-item">
                        <div class="stat-number">${memberCount}</div>
                        <div class="stat-label">Members</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">${eventCount}</div>
                        <div class="stat-label">Events</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number">${newsCount}</div>
                        <div class="stat-label">News</div>
                    </div>
                </div>

                <div class="content">
                    <div class="tabs">
                        <div class="tab-list">
                            <button class="tab active" onclick="showTab('overview')">Overview</button>
                            <button class="tab" onclick="showTab('members')">Members</button>
                            <button class="tab" onclick="showTab('activities')">Events & News</button>
                        </div>
                    </div>

                    <div id="overview" class="tab-content active">
                        <div class="section">
                            <h2 class="section-title">About This Club</h2>
                            <div class="card">
                                <p>${club.description}</p>
                            </div>
                        </div>

                        <div class="section">
                            <h2 class="section-title">Club Information</h2>
                            <div class="card">
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px;">
                                    <div>
                                        <strong>Status:</strong> 
                                        <span class="${club.status ? 'status-approved' : 'status-pending'}" style="padding: 2px 8px; border-radius: 4px; font-size: 0.875rem;">
                                            ${club.status ? 'Active' : 'Pending Approval'}
                                        </span>
                                    </div>
                                    <div>
                                        <strong>Created Date:</strong> 
                                        <fmt:formatDate value="${club.createdAt}" pattern="MMM dd, yyyy" />
                                    </div>
                                    <div>
                                        <strong>Last Updated:</strong> 
                                        <fmt:formatDate value="${club.updatedAt}" pattern="MMM dd, yyyy" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Upcoming Event Section -->
                        <c:if test="${upcomingEvent != null}">
                            <div class="section">
                                <h2 class="section-title">Upcoming Event</h2>
                                <div class="card">
                                    <h3 style="color: #111827; margin-bottom: 8px;">${upcomingEvent.eventName}</h3>
                                    <p style="color: #6b7280; margin-bottom: 12px;">${upcomingEvent.description}</p>
                                    <div style="display: flex; align-items: center; gap: 16px; font-size: 0.875rem;">
                                        <span style="color: #374151;"><strong>Date:</strong> 
                                            <fmt:formatDate value="${upcomingEvent.eventDate}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                        </span>
                                        <span class="badge badge-approved">${upcomingEvent.status}</span>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Latest News Section -->
                        <c:if test="${latestNews != null}">
                            <div class="section">
                                <h2 class="section-title">Latest News</h2>
                                <div class="card">
                                    <h3 style="color: #111827; margin-bottom: 8px;">${latestNews.title}</h3>
                                    <p style="color: #6b7280; margin-bottom: 12px; line-height: 1.5;">
                                        ${fn:length(latestNews.content) > 200 ? 
                                          fn:substring(latestNews.content, 0, 200).concat('...') : 
                                          latestNews.content}
                                    </p>
                                    <div style="display: flex; align-items: center; gap: 16px; font-size: 0.875rem;">
                                        <span style="color: #374151;"><strong>Published:</strong> 
                                            <fmt:formatDate value="${latestNews.createdAt}" pattern="MMM dd, yyyy" />
                                        </span>
                                        <span class="badge badge-approved">${latestNews.status}</span>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>

                    <div id="members" class="tab-content">
                        <div class="section">
                            <h2 class="section-title">Club Members (${memberCount})</h2>
                            <c:choose>
                                <c:when test="${not empty members}">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Role</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="member" items="${members}">
                                                <tr>
                                                    <td>${member.userName}</td>
                                                    <td>${member.email}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${member.userID == club.leaderID}">
                                                                Club Leader
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${member.role}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        No members found for this club.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div id="activities" class="tab-content">
                        <!-- Events Section -->
                        <div class="section">
                            <h2 class="section-title">Club Events (${eventCount})</h2>
                            <c:choose>
                                <c:when test="${not empty events}">
                                    <c:forEach var="event" items="${events}">
                                        <div class="card">
                                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px;">
                                                <div style="flex: 1;">
                                                    <h3 style="color: #111827; margin-bottom: 8px; font-size: 1.1rem;">${event.eventName}</h3>
                                                    <p style="color: #6b7280; margin-bottom: 12px; line-height: 1.5;">${event.description}</p>
                                                </div>
                                                <span class="badge ${event.status == 'Approved' ? 'badge-approved' : 'badge-pending'}">
                                                    ${event.status}
                                                </span>
                                            </div>
                                            <div style="display: flex; align-items: center; gap: 20px; font-size: 0.875rem; color: #6b7280;">
                                                <div>
                                                    <strong>Event Date:</strong> 
                                                    <fmt:formatDate value="${event.eventDate}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                                </div>
                                                <div>
                                                    <strong>Created:</strong> 
                                                    <fmt:formatDate value="${event.createdAt}" pattern="MMM dd, yyyy" />
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        No events found for this club.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- News Section -->
                        <div class="section">
                            <h2 class="section-title">Club News (${newsCount})</h2>
                            <c:choose>
                                <c:when test="${not empty newsList}">
                                    <c:forEach var="news" items="${newsList}">
                                        <div class="card">
                                            <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px;">
                                                <div style="flex: 1;">
                                                    <h3 style="color: #111827; margin-bottom: 8px; font-size: 1.1rem;">${news.title}</h3>
                                                    <p style="color: #6b7280; margin-bottom: 12px; line-height: 1.5;">
                                                        ${fn:length(news.content) > 300 ? 
                                                          fn:substring(news.content, 0, 300).concat('...') : 
                                                          news.content}
                                                    </p>
                                                </div>
                                                <span class="badge ${news.status == 'Approved' ? 'badge-approved' : 'badge-pending'}">
                                                    ${news.status}
                                                </span>
                                            </div>
                                            <div style="font-size: 0.875rem; color: #6b7280;">
                                                <strong>Published:</strong> 
                                                <fmt:formatDate value="${news.createdAt}" pattern="MMM dd, yyyy 'at' HH:mm" />
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="empty-state">
                                        No news articles found for this club.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Club Statistics -->
                        <div class="section">
                            <h2 class="section-title">Club Statistics</h2>
                            <div class="card">
                                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; text-align: center;">
                                    <div>
                                        <div style="font-size: 2rem; font-weight: bold; color: #059669; margin-bottom: 8px;">
                                            ${memberCount}
                                        </div>
                                        <div style="color: #6b7280; font-size: 0.875rem;">Total Members</div>
                                    </div>
                                    <div>
                                        <div style="font-size: 2rem; font-weight: bold; color: #dc2626; margin-bottom: 8px;">
                                            ${eventCount}
                                        </div>
                                        <div style="color: #6b7280; font-size: 0.875rem;">Total Events</div>
                                    </div>
                                    <div>
                                        <div style="font-size: 2rem; font-weight: bold; color: #2563eb; margin-bottom: 8px;">
                                            ${newsCount}
                                        </div>
                                        <div style="color: #6b7280; font-size: 0.875rem;">News Articles</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="button-group">
                        <c:if test="${club.status}">
                            <button class="button">Join Club</button>
                        </c:if>
                        <button class="button button-secondary">Contact Leader</button>
                        <a href="clubs" class="button button-secondary">Back to Clubs</a>
                    </div>
                </div>
            </c:if>

            <c:if test="${club == null}">
                <div class="content">
                    <div class="empty-state">
                        <h2>Club Not Found</h2>
                        <p>The requested club could not be found.</p>
                        <div class="button-group" style="justify-content: center; margin-top: 20px;">
                            <a href="clubs" class="button">Back to Clubs</a>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <script>
            function showTab(tabName) {
                // Hide all tab contents
                const tabContents = document.querySelectorAll('.tab-content');
                tabContents.forEach(content => {
                    content.classList.remove('active');
                });

                // Remove active class from all tabs
                const tabs = document.querySelectorAll('.tab');
                tabs.forEach(tab => {
                    tab.classList.remove('active');
                });

                // Show selected tab content
                document.getElementById(tabName).classList.add('active');

                // Add active class to clicked tab
                event.target.classList.add('active');
            }
        </script>
    </body>
</html>