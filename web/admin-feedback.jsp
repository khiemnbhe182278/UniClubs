<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Manage Feedback - Admin</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f5f7fa;
                display: flex;
            }
            .sidebar {
                width: 250px;
                background: #2c3e50;
                min-height: 100vh;
                color: white;
                position: fixed;
            }
            .sidebar-header {
                padding: 2rem;
                background: #34495e;
                text-align: center;
            }
            .sidebar-menu {
                list-style: none;
                padding: 1rem 0;
            }
            .sidebar-menu a {
                display: block;
                padding: 1rem 2rem;
                color: white;
                text-decoration: none;
            }
            .main-content {
                margin-left: 250px;
                flex: 1;
                padding: 2rem;
            }
            table {
                width: 100%;
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            th, td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            th {
                background: #f8f9fa;
                font-weight: 600;
            }
            .rating {
                color: #f39c12;
            }
            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-review {
                background: #3498db;
                color: white;
            }
            .btn-resolve {
                background: #2ecc71;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header"><h2>🎓 Admin Panel</h2></div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/feedback">💬 Feedback</a></li>
            </ul>
        </div>
        <div class="main-content">
            <h1>Manage Feedback</h1>
            <table>
                <thead>
                    <tr>
                        <th>Student</th>
                        <th>Club</th>
                        <th>Subject</th>
                        <th>Rating</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="feedback" items="${feedbacks}">
                        <tr>
                            <td>${feedback.userName}</td>
                            <td>${feedback.clubName}</td>
                            <td>${feedback.subject}</td>
                            <td class="rating">${'⭐'.repeat(feedback.rating)}</td>
                            <td><fmt:formatDate value="${feedback.createdAt}" pattern="MMM dd, yyyy"/></td>
                            <td>${feedback.status}</td>
                            <td>
                                <form method="post" style="display: inline;">
                                    <input type="hidden" name="feedbackId" value="${feedback.feedbackID}">
                                    <button type="submit" name="status" value="Reviewed" class="btn btn-review">Review</button>
                                    <button type="submit" name="status" value="Resolved" class="btn btn-resolve">Resolve</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>