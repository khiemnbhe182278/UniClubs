<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Users - Admin</title>
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
                <h1>Manage Users</h1>
                <p>View and manage all system users</p>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Created Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td><strong>${user.userName}</strong></td>
                                <td>${user.email}</td>
                                <td>
                                    <span style="padding: 0.3rem 1rem; background: #e3f2fd; border-radius: 20px; color: #1976d2;">
                                        ${user.roleName}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status}">
                                            <span style="color: #2ecc71;">● Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: #e74c3c;">● Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy"/></td>
                                <td>
                                    <form method="post" style="display: inline;">
                                        <input type="hidden" name="userId" value="${user.userID}">
                                        <button type="submit" class="btn" 
                                                style="background: ${user.status ? '#e74c3c' : '#2ecc71'}; color: white;">
                                            ${user.status ? 'Deactivate' : 'Activate'}
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>