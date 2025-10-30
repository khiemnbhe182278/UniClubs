<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Members - Admin</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
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
                <h1>Manage Pending Members</h1>
                <p>Review and approve membership requests</p>
            </div>

            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty pendingMembers}">
                        <table>
                            <thead>
                                <tr>
                                    <th>Student Name</th>
                                    <th>Email</th>
                                    <th>Club Name</th>
                                    <th>Request Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="member" items="${pendingMembers}">
                                    <tr>
                                        <td><strong>${member.userName}</strong></td>
                                        <td>${member.email}</td>
                                        <td>${member.clubName}</td>
                                        <td><fmt:formatDate value="${member.joinedAt}" pattern="MMM dd, yyyy"/></td>
                                        <td>
                                            <form method="post" style="display: inline;">
                                                <input type="hidden" name="memberId" value="${member.memberID}">
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
                            <h3>No pending membership requests</h3>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>
