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
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
                padding-top: 80px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                color: #1a1a1a;
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

            .events-grid {
                display: grid;
                gap: 2rem;
            }

            .event-card {
                background: white;
                border-radius: 20px;
                overflow: hidden;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                display: grid;
                grid-template-columns: 180px 1fr;
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                cursor: pointer;
                position: relative;
            }

            .event-card::before {
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

            .event-card:hover::before {
                transform: scaleX(1);
            }

            .event-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
            }

            .event-date-box {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 2rem;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                position: relative;
            }

            .event-date-box::after {
                content: '';
                position: absolute;
                right: -20px;
                top: 50%;
                transform: translateY(-50%);
                width: 0;
                height: 0;
                border-left: 20px solid #764ba2;
                border-top: 20px solid transparent;
                border-bottom: 20px solid transparent;
            }

            .event-date-box .month {
                font-size: 1.1rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                opacity: 0.9;
            }

            .event-date-box .day {
                font-size: 3.5rem;
                font-weight: 800;
                line-height: 1;
            }

            .event-date-box .year {
                font-size: 1rem;
                font-weight: 600;
                opacity: 0.85;
            }

            .event-content {
                padding: 2.5rem;
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }

            .event-content h3 {
                font-size: 1.8rem;
                font-weight: 700;
                color: #1a1a1a;
                margin-bottom: 0.5rem;
            }

            .event-club {
                display: inline-block;
                padding: 0.5rem 1.2rem;
                background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
                color: #667eea;
                font-weight: 700;
                border-radius: 20px;
                font-size: 0.95rem;
                align-self: flex-start;
            }

            .event-description {
                color: #666;
                line-height: 1.7;
                font-size: 1rem;
            }

            .event-meta {
                display: flex;
                gap: 2rem;
                margin-top: 0.5rem;
            }

            .meta-item {
                display: flex;
                flex-direction: column;
                gap: 0.3rem;
            }

            .meta-label {
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                color: #999;
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

            .btn-view {
                flex: 1;
                padding: 1rem 2rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-decoration: none;
                border-radius: 12px;
                font-weight: 700;
                text-align: center;
                transition: all 0.3s;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            }

            .btn-view:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            }

            .no-events {
                text-align: center;
                padding: 5rem 2rem;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                max-width: 600px;
                margin: 0 auto;
            }

            .no-events h2 {
                font-size: 2rem;
                margin-bottom: 1rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-weight: 800;
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
    <body>
        <%@ include file="header.jsp" %>

        <div class="container">
            <div class="page-hero">
                <h1>Upcoming Events</h1>
                <p>Don't miss out on exciting club activities and events</p>
            </div>

            <c:choose>
                <c:when test="${not empty events}">
                    <div class="events-grid">
                        <c:forEach var="event" items="${events}">
                            <div class="event-card">
                                <div class="event-date-box">
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