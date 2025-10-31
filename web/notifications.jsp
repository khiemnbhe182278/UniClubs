<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Notifications - UniClubs</title>
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

            .container {
                max-width: 900px;
                margin: 2rem auto;
                padding: 0 2rem;
            }

            .page-header {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .page-header h1 {
                color: #2193b0;
                margin-bottom: 0.5rem;
            }

            .notification-list {
                list-style: none;
            }

            .notification-item {
                background: white;
                padding: 1.5rem;
                border-radius: 10px;
                margin-bottom: 1rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                display: flex;
                gap: 1rem;
                transition: transform 0.3s;
            }

            .notification-item:hover {
                transform: translateX(5px);
            }

            .notification-item.unread {
                border-left: 4px solid #2193b0;
                background: #f0f8ff;
            }

            .notification-icon {
                font-size: 2rem;
                width: 50px;
                height: 50px;
                background: #e3f2fd;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-shrink: 0;
            }

            .notification-content {
                flex: 1;
            }

            .notification-content h3 {
                color: #2193b0;
                margin-bottom: 0.3rem;
                font-size: 1.1rem;
            }

            .notification-content p {
                color: #666;
                line-height: 1.6;
                margin-bottom: 0.5rem;
            }

            .notification-time {
                color: #999;
                font-size: 0.9rem;
            }

            .notification-actions {
                display: flex;
                align-items: center;
            }

            .btn-mark-read {
                background: #2193b0;
                color: white;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 5px;
                cursor: pointer;
                font-size: 0.9rem;
            }

            .empty-state {
                text-align: center;
                padding: 3rem;
                background: white;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .empty-state .icon {
                font-size: 4rem;
                margin-bottom: 1rem;
            }

            .btn-back {
                display: inline-block;
                color: #2193b0;
                text-decoration: none;
                margin-bottom: 1rem;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-back">← Back to Dashboard</a>

            <div class="page-header">
                <h1>Notifications</h1>
                <p>
                    <c:choose>
                        <c:when test="${unreadCount > 0}">
                            You have ${unreadCount} unread notification(s)
                        </c:when>
                        <c:otherwise>
                            All caught up! No new notifications
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <c:choose>
                <c:when test="${not empty notifications}">
                    <ul class="notification-list">
                        <c:forEach var="notif" items="${notifications}">
                            <li class="notification-item ${notif.read ? '' : 'unread'}">
                                <div class="notification-icon">
                                    <c:choose>
                                        <c:when test="${notif.notificationType == 'Event'}">📅</c:when>
                                        <c:when test="${notif.notificationType == 'News'}">📰</c:when>
                                        <c:when test="${notif.notificationType == 'Membership'}">👥</c:when>
                                        <c:otherwise>🔔</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="notification-content">
                                    <h3>${notif.title}</h3>
                                    <p>${notif.content}</p>
                                    <span class="notification-time">
                                        <fmt:formatDate value="${notif.createdAt}" pattern="MMM dd, yyyy 'at' hh:mm a"/>
                                    </span>
                                </div>
                                <c:if test="${!notif.read}">
                                    <div class="notification-actions">
                                        <form method="post" style="display: inline;">
                                            <input type="hidden" name="notificationId" value="${notif.notificationID}">
                                            <button type="submit" class="btn-mark-read">Mark as Read</button>
                                        </form>
                                    </div>
                                </c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="icon">📭</div>
                        <h3>No notifications yet</h3>
                        <p>You'll see notifications here when there's activity in your clubs</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>