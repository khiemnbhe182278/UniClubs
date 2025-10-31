<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Clubs - Admin</title>
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

            .sidebar-menu a:hover {
                background: #34495e;
            }

            .main-content {
                margin-left: 250px;
                flex: 1;
                padding: 2rem;
            }

            .page-header {
                background: white;
                padding: 1.5rem 2rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .page-header h1 {
                color: #2c3e50;
            }

            .table-container {
                background: white;
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                padding: 1rem;
                text-align: left;
                border-bottom: 1px solid #eee;
            }

            th {
                background: #f8f9fa;
                color: #2c3e50;
                font-weight: 600;
            }

            .btn {
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                margin-right: 0.5rem;
                font-size: 0.9rem;
            }

            .btn-approve {
                background: #2ecc71;
                color: white;
            }

            .btn-reject {
                background: #e74c3c;
                color: white;
            }

            .no-data {
                text-align: center;
                padding: 3rem;
                color: #999;
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h2>🎓 Admin Panel</h2>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard">📊 Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/clubs">🏛️ Manage Clubs</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/members">👥 Manage Members</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/events">📅 Manage Events</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users">👤 Manage Users</a></li>
            </ul>
        </div>

        <div class="main-content">
            <div class="page-header">
                <h1>Manage Pending Clubs</h1>
                <p>Review and approve club registration requests</p>
            </div>

            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty pendingClubs}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Club Name</th>
                                    <th>Description</th>
                                    <th>Created Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="club" items="${pendingClubs}">
                                    <tr>
                                        <td><strong>${club.clubName}</strong></td>
                                        <td>${club.description}</td>
                                        <td><fmt:formatDate value="${club.createdAt}" pattern="MMM dd, yyyy"/></td>
                                        <td>
                                            <form method="post" style="display: inline;">
                                                <input type="hidden" name="clubId" value="${club.clubID}">
                                                <button type="submit" name="action" value="approve" class="btn btn-approve">
                                                    ✓ Approve
                                                </button>
                                                <button type="submit" name="action" value="reject" class="btn btn-reject">
                                                    ✗ Reject
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="no-data">
                            <h3>No pending clubs</h3>
                            <p>All club requests have been reviewed</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>
