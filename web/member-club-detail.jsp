<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${club.clubName} - Club Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
        <style>
            body {
                background-color: #f8f9fa;
                min-height: 100vh;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 2rem;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                color: var(--text);
                text-decoration: none;
                font-weight: 600;
                font-size: 0.95rem;
                margin-bottom: 1.5rem;
                transition: all 0.2s ease;
                opacity: 0.8;
            }

            .back-link:hover {
                gap: 12px;
                opacity: 1;
                color: var(--primary);
            }

            /* Club Header */
            .club-header {
                background: var(--panel-bg);
                border-radius: var(--border-radius-lg);
                padding: 2.5rem 2rem;
                margin-bottom: 2rem;
                box-shadow: var(--shadow-lg);
                position: relative;
                overflow: hidden;
                border: 1px solid var(--border-color);
            }

            .club-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, var(--accent) 0%, var(--primary) 100%);
            }

            .club-title {
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--heading);
                margin-bottom: 1rem;
                letter-spacing: -0.02em;
            }

            .club-description {
                color: var(--text);
                font-size: 1.05rem;
                line-height: 1.7;
                margin-bottom: 1.5rem;
                opacity: 0.9;
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
                gap: 0.625rem;
                color: var(--text-muted);
                font-size: 0.95rem;
                font-weight: 500;
                padding: 0.5rem 1rem;
                background: var(--bg-light);
                border-radius: var(--border-radius);
            }

            .meta-item strong {
                color: var(--text);
                font-weight: 600;
                margin-left: 0.25rem;
            }

            .join-button {
                padding: 0.875rem 2rem;
                background: linear-gradient(135deg, var(--accent) 0%, var(--primary) 100%);
                color: white;
                border: none;
                border-radius: var(--border-radius);
                font-weight: 600;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: var(--shadow-sm);
            }

            .join-button:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
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
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 1.25rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: var(--panel-bg);
                padding: 1.75rem;
                border-radius: var(--border-radius);
                box-shadow: var(--shadow-sm);
                text-align: center;
                transition: all 0.2s ease;
                border: 1px solid var(--border-color);
            }

            .stat-card:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
                border-color: var(--border-hover);
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
                background: var(--panel-bg);
                border-radius: var(--border-radius);
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: var(--shadow-sm);
                border: 1px solid var(--border-color);
            }

            .section-header {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 1.75rem;
                padding-bottom: 1.25rem;
                border-bottom: 1px solid var(--border-color);
            }

            .section-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--heading);
                letter-spacing: -0.01em;
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
                background: var(--bg-light);
                padding: 1.25rem;
                border-radius: var(--border-radius);
                border-left: 3px solid var(--primary);
                transition: all 0.2s ease;
                border: 1px solid var(--border-color);
                border-left-width: 3px;
            }

            .news-card:hover {
                background: var(--bg);
                transform: translateX(4px);
                border-color: var(--border-hover);
                border-left-color: var(--accent);
            }

            .news-title {
                font-size: 1.05rem;
                font-weight: 600;
                color: var(--heading);
                margin-bottom: 0.75rem;
            }

            .news-content {
                color: var(--text);
                font-size: 0.95rem;
                line-height: 1.6;
                margin-bottom: 0.75rem;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                line-clamp: 3;
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
                background: var(--bg-light);
                padding: 1.25rem;
                border-radius: var(--border-radius);
                border: 1px solid var(--border-color);
                border-left: 3px solid var(--accent);
                transition: all 0.2s ease;
            }

            .rule-item:hover {
                background: var(--bg);
                border-color: var(--border-hover);
            }

            .rule-title {
                font-size: 1.05rem;
                font-weight: 600;
                color: var(--heading);
                margin-bottom: 0.75rem;
            }

            .rule-text {
                color: var(--text);
                font-size: 0.95rem;
                line-height: 1.6;
                opacity: 0.9;
            }

            /* Events List */
            .events-list {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .event-card {
                background: #ffffff;
                padding: 1.5rem;
                border-radius: 12px;
                display: grid;
                grid-template-columns: auto 1fr auto;
                gap: 1.5rem;
                align-items: center;
                position: relative;
                border: 1px solid #e2e8f0;
                margin-bottom: 1rem;
                transition: all 0.2s ease-in-out;
            }

            .event-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                border-color: #cbd5e0;
            }

            .event-date-box {
                background: #f8fafc;
                color: #1a202c;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                text-align: center;
                min-width: 4.5rem;
                border: 2px solid #e2e8f0;
            }

            .event-day {
                font-size: 1.75rem;
                font-weight: 700;
                line-height: 1;
                color: #2563eb;
                margin-bottom: 0.25rem;
            }

            .event-month {
                font-size: 0.875rem;
                font-weight: 600;
                text-transform: uppercase;
                color: #64748b;
            }

            .event-info {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .event-name {
                font-size: 1.125rem;
                font-weight: 600;
                color: #1a202c;
                line-height: 1.4;
            }

            .event-location {
                color: #64748b;
                font-size: 0.875rem;
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .event-location i {
                font-size: 1rem;
            }

            .event-actions {
                display: flex;
                gap: 0.75rem;
                align-items: center;
            }

            .event-badge {
                position: absolute;
                top: 1rem;
                right: 1rem;
                padding: 0.25rem 0.75rem;
                border-radius: 9999px;
                font-size: 0.75rem;
                font-weight: 500;
                letter-spacing: 0.025em;
            }

            .event-badge {
                position: absolute;
                top: 1rem;
                right: 1rem;
                padding: 0.25rem 0.75rem;
                border-radius: 0.5rem;
                font-size: 0.75rem;
                font-weight: 500;
                background: #e9ecef;
                color: #495057;
            }
            
            .open-badge {
                background-color: #dcfce7;
                color: #166534;
                border: 1px solid #86efac;
            }
            
            .full-badge {
                background-color: #fee2e2;
                color: #991b1b;
                border: 1px solid #fca5a5;
            }
            
            .closed-badge {
                background-color: #f1f5f9;
                color: #475569;
                border: 1px solid #cbd5e0;
            }            .no-data {
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
        <jsp:include page="header.jsp"/>
        <div class="container">
            <a href="${pageContext.request.contextPath}/dashboard" class="back-link">
                ← Back to Dashboard
            </a>

            <!-- Club Header -->
            <div class="club-header">
                <h1 class="club-title">🎓 ${club.clubName}</h1>
                <p class="club-description">${club.description}</p>



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
                                            <span><i class="bi bi-geo-alt-fill text-danger"></i> ${event.location}</span>
                                            <span><i class="bi bi-clock-fill text-primary"></i> <fmt:formatDate value="${event.eventDate}" pattern="HH:mm"/></span>
                                            <span><i class="bi bi-people-fill text-success"></i> ${event.maxParticipants} slots</span>
                                        </div>
                                    </div>
                                    <div class="event-actions">
                                        <form action="${pageContext.request.contextPath}/event/register" method="POST">
                                            <input type="hidden" name="eventID" value="${event.eventID}">
                                            <button type="submit" class="btn btn-primary btn-sm">
                                                <i class="bi bi-calendar-plus"></i> Register
                                            </button>
                                        </form>
                                        <a href="${pageContext.request.contextPath}/event-details?eventID=${event.eventID}" 
                                           class="btn btn-outline-secondary btn-sm">
                                            <i class="bi bi-info-circle"></i> Details
                                        </a>
                                    </div>
                                    <span class="event-badge ${fn:toLowerCase(event.status)}-badge">${event.status}</span>
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
        <script>
            document.querySelectorAll('form[action*="/event/register"]').forEach(form => {
                form.addEventListener('submit', function(e) {
                    if (!confirm('Are you sure you want to register for this event?')) {
                        e.preventDefault();
                    }
                });
            });
        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>