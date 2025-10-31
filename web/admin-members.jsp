<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Members - Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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
                display: flex;
            }

            /* Sidebar Styles */
            .sidebar {
                width: 280px;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                box-shadow: 4px 0 20px rgba(0, 0, 0, 0.1);
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                transition: all 0.3s ease;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 30px 20px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .sidebar-header h2 {
                font-size: 24px;
                font-weight: 700;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .sidebar-menu {
                list-style: none;
                padding: 20px 0;
            }

            .sidebar-menu li {
                margin: 5px 15px;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 14px 18px;
                color: #4a5568;
                text-decoration: none;
                border-radius: 12px;
                transition: all 0.3s ease;
                font-weight: 500;
                font-size: 15px;
            }

            .sidebar-menu a:hover {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                transform: translateX(5px);
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
            }

            /* Main Content */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 40px;
                min-height: 100vh;
            }

            .page-header {
                background: white;
                padding: 30px;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
                position: relative;
                overflow: hidden;
            }

            .page-header::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 4px;
                background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            }

            .page-header h1 {
                color: #2d3748;
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 8px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .page-header p {
                color: #718096;
                font-size: 16px;
            }

            /* Stats Cards */
            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                display: flex;
                align-items: center;
                gap: 15px;
                transition: all 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
            }

            .stat-icon {
                width: 50px;
                height: 50px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            .stat-content h3 {
                font-size: 24px;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 4px;
            }

            .stat-content p {
                font-size: 13px;
                color: #718096;
                font-weight: 500;
            }

            /* Table Container */
            .table-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .table-header {
                padding: 25px 30px;
                background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
                border-bottom: 2px solid #e2e8f0;
            }

            .table-header h2 {
                font-size: 20px;
                font-weight: 700;
                color: #2d3748;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            thead th {
                padding: 18px 20px;
                text-align: left;
                color: white;
                font-weight: 600;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            tbody tr {
                border-bottom: 1px solid #e2e8f0;
                transition: all 0.3s ease;
            }

            tbody tr:hover {
                background: linear-gradient(90deg, rgba(102, 126, 234, 0.03) 0%, rgba(118, 75, 162, 0.03) 100%);
            }

            tbody tr:last-child {
                border-bottom: none;
            }

            tbody td {
                padding: 20px;
                color: #4a5568;
                font-size: 14px;
                vertical-align: middle;
            }

            tbody td strong {
                color: #2d3748;
                font-weight: 600;
                font-size: 15px;
            }

            /* User Avatar */
            .user-info {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 700;
                font-size: 16px;
                flex-shrink: 0;
            }

            .user-details strong {
                display: block;
                margin-bottom: 2px;
            }

            .user-details .user-id {
                font-size: 12px;
                color: #a0aec0;
            }

            /* Email Badge */
            .email-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 6px 12px;
                background: #edf2f7;
                border-radius: 8px;
                font-size: 13px;
                color: #4a5568;
                font-weight: 500;
            }

            /* Club Badge */
            .club-badge {
                display: inline-block;
                padding: 8px 16px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 600;
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
            }

            /* Date Badge */
            .date-badge {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 14px;
                background: #f7fafc;
                border: 1px solid #e2e8f0;
                border-radius: 10px;
                font-weight: 500;
                color: #2d3748;
                font-size: 13px;
            }

            /* Buttons */
            .btn {
                padding: 10px 18px;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                font-size: 13px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                text-transform: uppercase;
                letter-spacing: 0.3px;
            }

            .btn-approve {
                background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
                color: white;
                margin-right: 8px;
            }

            .btn-approve:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(72, 187, 120, 0.4);
            }

            .btn-approve:active {
                transform: translateY(0);
            }

            .btn-reject {
                background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
                color: white;
            }

            .btn-reject:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(245, 101, 101, 0.4);
            }

            .btn-reject:active {
                transform: translateY(0);
            }

            /* No Data State */
            .no-data {
                padding: 80px 40px;
                text-align: center;
            }

            .no-data::before {
                content: "👥";
                font-size: 64px;
                display: block;
                margin-bottom: 20px;
                opacity: 0.5;
            }

            .no-data h3 {
                color: #718096;
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 8px;
            }

            .no-data p {
                color: #a0aec0;
                font-size: 14px;
            }

            /* Loading Animation */
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

            .table-container {
                animation: fadeIn 0.6s ease;
            }

            /* Responsive Design */
            @media (max-width: 1024px) {
                .sidebar {
                    width: 240px;
                }

                .main-content {
                    margin-left: 240px;
                    padding: 20px;
                }
            }

            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                }

                .main-content {
                    margin-left: 0;
                    padding: 15px;
                }

                .page-header {
                    padding: 20px;
                }

                .page-header h1 {
                    font-size: 24px;
                }

                table {
                    font-size: 12px;
                }

                .user-info {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 8px;
                }

                .user-avatar {
                    width: 32px;
                    height: 32px;
                    font-size: 14px;
                }

                thead th, tbody td {
                    padding: 12px 8px;
                }

                .btn {
                    padding: 8px 12px;
                    font-size: 11px;
                }
            }

            /* Scrollbar Styling */
            ::-webkit-scrollbar {
                width: 8px;
                height: 8px;
            }

            ::-webkit-scrollbar-track {
                background: #f1f1f1;
            }

            ::-webkit-scrollbar-thumb {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 10px;
            }

            ::-webkit-scrollbar-thumb:hover {
                background: #764ba2;
            }

            /* Status Indicator */
            .status-pending {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 4px 10px;
                background: #fef5e7;
                color: #f39c12;
                border-radius: 12px;
                font-size: 11px;
                font-weight: 600;
                text-transform: uppercase;
            }

            .status-pending::before {
                content: "⏱";
                font-size: 12px;
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
                <h1>Manage Pending Members</h1>
                <p>Review and approve membership requests from students</p>
            </div>

            <c:if test="${not empty pendingMembers}">
                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon">👥</div>
                        <div class="stat-content">
                            <h3>${pendingMembers.size()}</h3>
                            <p>Pending Requests</p>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="table-container">
                <c:choose>
                    <c:when test="${not empty pendingMembers}">
                        <div class="table-header">
                            <h2>📋 Membership Requests</h2>
                        </div>
                        <table>
                            <thead>
                                <tr>
                                    <th>Student</th>
                                    <th>Email</th>
                                    <th>Club</th>
                                    <th>Request Date</th>
                                    <th>Status</th>
                                    <th style="text-align: center;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="member" items="${pendingMembers}">
                                    <tr>
                                        <td>
                                            <div class="user-info">
                                                <div class="user-avatar">
                                                    ${member.userName.substring(0, 1).toUpperCase()}
                                                </div>
                                                <div class="user-details">
                                                    <strong>${member.userName}</strong>
                                                    <span class="user-id">ID: ${member.memberID}</span>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="email-badge">
                                                📧 ${member.email}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="club-badge">${member.clubName}</span>
                                        </td>
                                        <td>
                                            <span class="date-badge">
                                                📅 <fmt:formatDate value="${member.joinedAt}" pattern="MMM dd, yyyy"/>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="status-pending">Pending</span>
                                        </td>
                                        <td style="text-align: center;">
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
                            <p>All membership applications have been processed</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </body>
</html>