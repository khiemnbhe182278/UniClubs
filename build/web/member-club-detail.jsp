<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${club.clubName} - Club Details</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 40px 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                color: white;
                text-decoration: none;
                font-weight: 600;
                font-size: 14px;
                margin-bottom: 25px;
                transition: all 0.3s ease;
            }

            .back-link:hover {
                gap: 12px;
            }

            /* Club Header */
            .club-header {
                background: white;
                border-radius: 20px;
                padding: 40px;
                margin-bottom: 30px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                position: relative;
                overflow: hidden;
            }

            .club-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 6px;
                background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            }

            .club-title {
                font-size: 36px;
                font-weight: 800;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 15px;
            }

            .club-description {
                color: #4a5568;
                font-size: 16px;
                line-height: 1.7;
                margin-bottom: 25px;
            }

            .club-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 30px;
                margin-bottom: 25px;
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 10px;
                color: #718096;
                font-size: 14px;
                font-weight: 500;
            }

            .meta-item strong {
                color: #2d3748;
                font-weight: 600;
            }

            .join-button {
                padding: 14px 32px;
                background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
                color: white;
                border: none;
                border-radius: 12px;
                font-weight: 600;
                font-size: 15px;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(72, 187, 120, 0.3);
            }

            .join-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 25px rgba(72, 187, 120, 0.5);
            }

            .joined-button {
                background: linear-gradient(135deg, #cbd5e0 0%, #a0aec0 100%);
                cursor: not-allowed;
            }

            .pending-button {
                background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
            }

            /* Stats Grid */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 25px;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
                text-align: center;
                transition: all 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
            }

            .stat-icon {
                font-size: 40px;
                margin-bottom: 12px;
            }

            .stat-value {
                font-size: 32px;
                font-weight: 800;
                color: #2d3748;
                margin-bottom: 8px;
            }

            .stat-label {
                color: #718096;
                font-size: 13px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* Section */
            .section {
                background: white;
                border-radius: 20px;
                padding: 35px;
                margin-bottom: 30px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
            }

            .section-header {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 25px;
                padding-bottom: 20px;
                border-bottom: 2px solid #e2e8f0;
            }

            .section-title {
                font-size: 24px;
                font-weight: 700;
                color: #2d3748;
            }

            /* Leadership */
            .leadership-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
            }

            .leader-card {
                background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
                padding: 25px;
                border-radius: 16px;
                text-align: center;
            }

            .leader-icon {
                width: 80px;
                height: 80px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 36px;
                margin: 0 auto 15px;
            }

            .leader-name {
                font-size: 18px;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 5px;
            }

            .leader-role {
                color: #718096;
                font-size: 13px;
                font-weight: 600;
                text-transform: uppercase;
            }

            .leader-email {
                color: #667eea;
                font-size: 14px;
                margin-top: 8px;
            }

            /* News Grid */
            .news-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 20px;
            }

            .news-card {
                background: #f7fafc;
                padding: 20px;
                border-radius: 16px;
                border-left: 4px solid #667eea;
                transition: all 0.3s ease;
            }

            .news-card:hover {
                background: #edf2f7;
                transform: translateX(5px);
            }

            .news-title {
                font-size: 16px;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 8px;
            }

            .news-content {
                color: #4a5568;
                font-size: 14px;
                line-height: 1.6;
                margin-bottom: 10px;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .news-date {
                color: #718096;
                font-size: 12px;
                font-weight: 500;
            }

            /* Rules List */
            .rules-list {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .rule-item {
                background: #f7fafc;
                padding: 20px;
                border-radius: 16px;
                border-left: 4px solid #764ba2;
            }

            .rule-title {
                font-size: 16px;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 8px;
            }

            .rule-text {
                color: #4a5568;
                font-size: 14px;
                line-height: 1.6;
            }

            /* Events List */
            .events-list {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .event-card {
                background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
                padding: 20px;
                border-radius: 16px;
                display: flex;
                gap: 20px;
                align-items: center;
                transition: all 0.3s ease;
            }

            .event-card:hover {
                transform: translateX(5px);
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            }

            .event-date-box {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 15px;
                border-radius: 12px;
                text-align: center;
                min-width: 80px;
            }

            .event-day {
                font-size: 28px;
                font-weight: 800;
                line-height: 1;
            }

            .event-month {
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
            }

            .event-info {
                flex: 1;
            }

            .event-name {
                font-size: 18px;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 5px;
            }

            .event-location {
                color: #718096;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .event-badge {
                padding: 6px 12px;
                background: #d4f4dd;
                color: #22543d;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }

            .no-data {
                text-align: center;
                padding: 40px;
                color: #718096;
            }

            @media (max-width: 768px) {
                .club-header {
                    padding: 25px;
                }

                .club-title {
                    font-size: 28px;
                }

                .club-meta {
                    flex-direction: column;
                    gap: 15px;
                }

                .section {
                    padding: 25px;
                }

                .event-card {
                    flex-direction: column;
                    text-align: center;
                }

                .stats-grid {
                    grid-template-columns: 1fr;
                }
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .club-header, .section {
                animation: fadeIn 0.5s ease;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <a href="${pageContext.request.contextPath}/dashboard" class="back-link">
                ← Back to Dashboard
            </a>

            <!-- Club Header -->
            <div class="club-header">
                <h1 class="club-title">🎓 ${club.clubName}</h1>
                <p class="club-description">${club.description}</p>

                <div class="club-meta">
                    <div class="meta-item">
                        📅 <strong>Founded:</strong> <fmt:formatDate value="${club.createdAt}" pattern="MMM yyyy"/>
                    </div>
                    <div class="meta-item">
                        ✅ <strong>Status:</strong> ${club.status}
                    </div>
                </div>

                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <c:choose>
                            <c:when test="${isMember}">
                                <button class="join-button joined-button" disabled>
                                    ✓ Already a Member
                                </button>
                            </c:when>
                            <c:when test="${isPendingMember}">
                                <button class="join-button pending-button" disabled>
                                    ⏱ Request Pending
                                </button>
                            </c:when>
                            <c:otherwise>
                                <form method="post" action="${pageContext.request.contextPath}/join-club" style="display: inline;">
                                    <input type="hidden" name="clubId" value="${club.clubID}">
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="join-button" style="display: inline-block; text-decoration: none;">
                            Login to Join
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Stats -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">👥</div>
                    <div class="stat-value">${memberCount}</div>
                    <div class="stat-label">Members</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📅</div>
                    <div class="stat-value">${events.size()}</div>
                    <div class="stat-label">Upcoming Events</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📰</div>
                    <div class="stat-value">${newsList.size()}</div>
                    <div class="stat-label">News Articles</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📜</div>
                    <div class="stat-value">${rules.size()}</div>
                    <div class="stat-label">Club Rules</div>
                </div>
            </div>

            <!-- Leadership -->
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">👔 Leadership</h2>
                </div>
                <div class="leadership-grid">
                    <c:if test="${not empty leader}">
                        <div class="leader-card">
                            <div class="leader-icon">👨‍💼</div>
                            <div class="leader-name">${leader.userName}</div>
                            <div class="leader-role">Club Leader</div>
                            <div class="leader-email">${leader.email}</div>
                        </div>
                    </c:if>
                    <c:if test="${not empty faculty}">
                        <div class="leader-card">
                            <div class="leader-icon">👨‍🏫</div>
                            <div class="leader-name">${faculty.userName}</div>
                            <div class="leader-role">Faculty Advisor</div>
                            <div class="leader-email">${faculty.email}</div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Upcoming Events -->
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">📅 Upcoming Events</h2>
                </div>
                <c:choose>
                    <c:when test="${not empty events}">
                        <div class="events-list">
                            <c:forEach var="event" items="${events}">
                                <div class="event-card">
                                    <div class="event-date-box">
                                        <div class="event-day"><fmt:formatDate value="${event.eventDate}" pattern="dd"/></div>
                                        <div class="event-month"><fmt:formatDate value="${event.eventDate}" pattern="MMM"/></div>
                                    </div>
                                    <div class="event-info">
                                        <div class="event-name">${event.eventName}</div>
                                        <div class="event-location">
                                            📍 ${event.location} • 🕐 <fmt:formatDate value="${event.eventDate}" pattern="HH:mm"/>
                                        </div>
                                    </div>
                                    <span class="event-badge">${event.status}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">No upcoming events</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Latest News -->
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">📰 Latest News</h2>
                </div>
                <c:choose>
                    <c:when test="${not empty newsList}">
                        <div class="news-grid">
                            <c:forEach var="news" items="${newsList}">
                                <div class="news-card">
                                    <div class="news-title">${news.title}</div>
                                    <div class="news-content">${news.content}</div>
                                    <div class="news-date">
                                        📅 <fmt:formatDate value="${news.createdAt}" pattern="MMM dd, yyyy"/>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">No news yet</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Club Rules -->
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">📜 Club Rules</h2>
                </div>
                <c:choose>
                    <c:when test="${not empty rules}">
                        <div class="rules-list">
                            <c:forEach var="rule" items="${rules}">
                                <div class="rule-item">
                                    <div class="rule-title">${rule.title}</div>
                                    <div class="rule-text">${rule.ruleText}</div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">No rules defined yet</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>