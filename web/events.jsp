<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Upcoming Events - UniClubs</title>
        
        <style>
            /* Override with more specific styles */
            body.events-page {
                background: var(--bg);
                min-height: 100vh;
                color: var(--text);
            }

            .events-container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 3rem 2rem;
            }

            .events-hero {
                text-align: center;
                margin-bottom: 3rem;
                padding: 3rem 0;
                background: white;
                border-radius: var(--border-radius);
                border: 1px solid var(--border-color);
            }

            .page-hero h1 {
                font-size: 2.5rem;
                font-weight: 600;
                margin-bottom: 1rem;
                color: var(--heading);
            }

            .events-hero p {
                font-size: 1.1rem;
                color: var(--muted);
                max-width: 600px;
                margin: 0 auto;
            }

            .events-page .events-grid {
                display: grid;
                gap: 1.5rem;
            }

            .events-page .event-card {
                background: var(--panel-bg);
                border-radius: 12px;
                overflow: hidden;
                box-shadow: var(--shadow-sm);
                display: grid;
                grid-template-columns: 160px 1fr;
                transition: var(--transition);
                position: relative;
                border: 1px solid rgba(0,0,0,0.05);
            }

            .events-page .event-card:hover {
                transform: translateY(-3px);
                box-shadow: var(--shadow-lg);
            }

            .events-page .event-date-box {
                background: var(--bg);
                color: var(--accent);
                padding: 1.5rem;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                gap: 0.25rem;
                position: relative;
                border-right: 1px solid rgba(0,0,0,0.05);
            }

            .events-page .event-date-box .month {
                font-size: 1rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                color: var(--muted);
            }

            .event-date-box .day {
                font-size: 2.5rem;
                font-weight: 600;
                line-height: 1;
            }

            .event-date-box .year {
                font-size: 0.9rem;
                color: var(--text-muted);
            }

            .events-page .event-content {
                padding: 1.5rem;
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
            }

            .events-page .event-content h3 {
                font-size: 1.25rem;
                font-weight: 600;
                color: var(--text);
                margin-bottom: 0.25rem;
            }

            .events-page .event-club {
                display: inline-block;
                padding: 0.4rem 1rem;
                background: var(--bg);
                color: var(--accent);
                font-weight: 500;
                border-radius: 8px;
                font-size: 0.9rem;
                align-self: flex-start;
            }

            .events-page .event-description {
                color: var(--muted);
                line-height: 1.7;
                font-size: 1rem;
            }

            .events-page .event-meta {
                display: flex;
                gap: 2rem;
                margin-top: 0.5rem;
            }

            .events-page .meta-item {
                display: flex;
                flex-direction: column;
                gap: 0.3rem;
            }

            .events-page .meta-label {
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                color: var(--muted);
                font-weight: 600;
            }

            .meta-value {
                color: #333;
                font-weight: 600;
                font-size: 1rem;
            }

            .event-actions {
                display: flex;
                gap: 1rem;
                margin-top: 1rem;
            }

            .events-page .btn-view {
                flex: 1;
                padding: 0.75rem 1.5rem;
                background: var(--accent);
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                text-align: center;
                transition: var(--transition);
                box-shadow: var(--shadow-sm);
            }

            .events-page .btn-view:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
            }

            .events-page .no-events {
                text-align: center;
                padding: 4rem 2rem;
                background: var(--panel-bg);
                border-radius: 12px;
                box-shadow: var(--shadow-md);
                max-width: 600px;
                margin: 0 auto;
            }

            .events-page .no-events h2 {
                font-size: 1.75rem;
                margin-bottom: 1rem;
                color: var(--text);
                font-weight: 600;
            }

            .no-events p {
                color: #666;
                font-size: 1.1rem;
                line-height: 1.7;
            }

            @media (max-width: 968px) {
                .event-card {
                    grid-template-columns: 140px 1fr;
                }

                .event-date-box .day {
                    font-size: 2.8rem;
                }

                .event-content {
                    padding: 2rem;
                }
            }

            @media (max-width: 768px) {
                .page-hero h1 {
                    font-size: 2.5rem;
                }

                .event-card {
                    grid-template-columns: 1fr;
                }

                .event-date-box {
                    padding: 1.5rem;
                    flex-direction: row;
                    justify-content: center;
                }

                .event-date-box::after {
                    display: none;
                }

                .event-date-box .day {
                    font-size: 2.5rem;
                }

                .event-meta {
                    flex-direction: column;
                    gap: 1rem;
                }

                nav ul {
                    gap: 1.5rem;
                }
            }
        </style>
    </head>
    <body class="events-page">
        <%@ include file="header.jsp" %>

        <div class="events-container">
            <div class="events-hero">
                <h1>Upcoming Events</h1>
                <p>Don't miss out on exciting club activities and events</p>
            </div>

            <c:choose>
                <c:when test="${not empty events}">
                    <div class="events-grid">
                        <c:forEach var="event" items="${events}">
                            <div class="event-card">
                                <div class="event-date-box">
                                    <fmt:setLocale value="en_US"/>
                                    <div class="month">
                                        <fmt:formatDate value="${event.eventDate}" pattern="MMM"/>
                                    </div>
                                    <div class="day">
                                        <fmt:formatDate value="${event.eventDate}" pattern="dd"/>
                                    </div>
                                    <div class="year">
                                        <fmt:formatDate value="${event.eventDate}" pattern="yyyy"/>
                                    </div>
                                </div>
                                <div class="event-content">
                                    <h3>${event.eventName}</h3>
                                    <span class="event-club">${event.clubName}</span>
                                    <p class="event-description">${event.description}</p>

                                    <div class="event-meta">
                                        <div class="meta-item">
                                            <span class="meta-label">Day</span>
                                            <span class="meta-value">
                                                <fmt:formatDate value="${event.eventDate}" pattern="EEEE"/>
                                            </span>
                                        </div>
                                        <div class="meta-item">
                                            <span class="meta-label">Time</span>
                                            <span class="meta-value">
                                                <fmt:formatDate value="${event.eventDate}" pattern="h:mm a"/>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="event-actions">
                                        <a href="${pageContext.request.contextPath}/event-detail?id=${event.eventID}" 
                                           class="btn-view">View Details</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-events">
                        <h2>No Upcoming Events</h2>
                        <p>There are no events scheduled at the moment. Check back later for exciting activities!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>