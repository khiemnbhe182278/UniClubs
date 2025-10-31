<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Members - Faculty Portal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --success-gradient: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
                --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            }

            body {
                background: #f5f7fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .navbar {
                background: var(--primary-gradient) !important;
                box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            }

            .page-header {
                background: white;
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
                margin-bottom: 2rem;
            }

            .page-header h2 {
                color: #2d3748;
                font-weight: 700;
                margin: 0;
            }

            .page-header p {
                color: #718096;
                margin: 0.5rem 0 0 0;
            }

            /* Member Card */
            .member-card {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
                border-left: 4px solid;
                border-left-color: #fbbf24;
                transition: all 0.3s ease;
            }

            .member-card:hover {
                transform: translateX(5px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            }

            .member-avatar {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: var(--primary-gradient);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 2rem;
                font-weight: 700;
                text-transform: uppercase;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }

            .member-info {
                flex-grow: 1;
            }

            .member-name {
                font-size: 1.25rem;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 0.5rem;
            }

            .info-row {
                display: flex;
                align-items: center;
                margin-bottom: 0.5rem;
                color: #718096;
            }

            .info-row i {
                width: 20px;
                margin-right: 0.5rem;
            }

            .info-badge {
                display: inline-block;
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 500;
                margin-right: 0.5rem;
            }

            .badge-club {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .badge-faculty {
                background: #e2e8f0;
                color: #4a5568;
            }

            .badge-pending {
                background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
                color: white;
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            /* Action Buttons */
            .action-buttons {
                display: flex;
                flex-direction: column;
                gap: 0.75rem;
                min-width: 140px;
            }

            .btn-modern {
                border-radius: 10px;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                border: none;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
            }

            .btn-approve {
                background: var(--success-gradient);
                color: white;
            }

            .btn-approve:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 20px rgba(132, 250, 176, 0.4);
                color: white;
            }

            .btn-reject {
                background: var(--danger-gradient);
                color: white;
            }

            .btn-reject:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 20px rgba(250, 112, 154, 0.4);
                color: white;
            }

            .btn-back {
                background: white;
                color: #667eea;
                border: 2px solid #667eea;
            }

            .btn-back:hover {
                background: var(--primary-gradient);
                color: white;
                border-color: transparent;
            }

            /* Empty State */
            .empty-state {
                background: white;
                border-radius: 15px;
                padding: 4rem 2rem;
                text-align: center;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
            }

            .empty-state i {
                font-size: 5rem;
                background: var(--success-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1.5rem;
            }

            .empty-state h3 {
                color: #2d3748;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .empty-state p {
                color: #718096;
            }

            /* Stats Summary */
            .stats-summary {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
                margin-bottom: 2rem;
            }

            .stat-item {
                text-align: center;
                padding: 1rem;
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                background: var(--primary-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .stat-label {
                color: #718096;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            /* Modal Customization */
            .modal-content {
                border-radius: 15px;
                border: none;
            }

            .modal-header {
                background: var(--primary-gradient);
                color: white;
                border-radius: 15px 15px 0 0;
                border: none;
            }

            .modal-footer {
                border: none;
                padding: 1.5rem;
            }

            /* Search & Filter */
            .search-box {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
                margin-bottom: 2rem;
            }

            .search-input {
                border: 2px solid #e2e8f0;
                border-radius: 10px;
                padding: 0.75rem 1rem;
                transition: all 0.3s;
            }

            .search-input:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/faculty/dashboard">
                    <i class="fas fa-graduation-cap me-2"></i>Faculty Portal
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto align-items-center">
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/faculty/dashboard">
                                <i class="fas fa-home me-1"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active px-3" href="${pageContext.request.contextPath}/faculty/members">
                                <i class="fas fa-users me-1"></i> Members
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/faculty/events">
                                <i class="fas fa-calendar me-1"></i> Events
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/faculty/news">
                                <i class="fas fa-newspaper me-1"></i> News
                            </a>
                        </li>
                        <li class="nav-item dropdown ms-3">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-circle me-1"></i> ${sessionScope.user.userName}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt me-2"></i>Logout
                                    </a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid px-4 py-4">
            <!-- Alert Messages -->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-${sessionScope.messageType} alert-dismissible fade show" role="alert">
                    <i class="fas fa-${sessionScope.messageType == 'success' ? 'check-circle' : 'exclamation-circle'} me-2"></i>
                    ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
                <c:remove var="message" scope="session"/>
                <c:remove var="messageType" scope="session"/>
            </c:if>

            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2><i class="fas fa-user-clock me-2"></i>Pending Member Applications</h2>
                        <p>Review and approve student membership requests for your supervised clubs</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/faculty/dashboard" class="btn btn-modern btn-back">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </div>

            <!-- Statistics Summary -->
            <c:if test="${not empty pendingMembers}">
                <div class="stats-summary">
                    <div class="row">
                        <div class="col-md-4 stat-item">
                            <div class="stat-number">${pendingMembers.size()}</div>
                            <div class="stat-label">Pending Applications</div>
                        </div>
                        <div class="col-md-4 stat-item">
                            <div class="stat-number">
                                <c:set var="uniqueClubs" value="${0}"/>
                                <c:set var="clubSet" value=""/>
                                <c:forEach items="${pendingMembers}" var="member">
                                    <c:if test="${!clubSet.contains(member.clubName)}">
                                        <c:set var="uniqueClubs" value="${uniqueClubs + 1}"/>
                                        <c:set var="clubSet" value="${clubSet}${member.clubName},"/>
                                    </c:if>
                                </c:forEach>
                                ${uniqueClubs}
                            </div>
                            <div class="stat-label">Clubs Affected</div>
                        </div>
                        <div class="col-md-4 stat-item">
                            <div class="stat-number">
                                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd"/>
                            </div>
                            <div class="stat-label">
                                <fmt:formatDate value="<%= new java.util.Date() %>" pattern="MMMM yyyy"/>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Search Box -->
                <div class="search-box">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-text bg-transparent border-0">
                                    <i class="fas fa-search text-muted"></i>
                                </span>
                                <input type="text" class="form-control search-input border-0" 
                                       id="searchInput" placeholder="Search by name, student ID, or club..."
                                       onkeyup="filterMembers()">
                            </div>
                        </div>
                        <div class="col-md-6 text-end">
                            <small class="text-muted">
                                Showing <span id="visibleCount">${pendingMembers.size()}</span> of ${pendingMembers.size()} applications
                            </small>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Empty State -->
            <c:if test="${empty pendingMembers}">
                <div class="empty-state">
                    <i class="fas fa-check-circle"></i>
                    <h3>All Applications Processed!</h3>
                    <p class="mb-4">There are no pending member applications at the moment.</p>
                    <a href="${pageContext.request.contextPath}/faculty/dashboard" class="btn btn-modern" 
                       style="background: var(--primary-gradient); color: white;">
                        <i class="fas fa-home me-2"></i>Back to Dashboard
                    </a>
                </div>
            </c:if>

            <!-- Member Cards -->
            <div id="membersList">
                <c:forEach items="${pendingMembers}" var="member">
                    <div class="member-card" data-search="${member.fullName} ${member.studentID} ${member.clubName} ${member.email}">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <div class="member-avatar">
                                    ${member.fullName.substring(0, 1)}
                                </div>
                            </div>
                            <div class="col member-info">
                                <div class="member-name">${member.fullName}</div>
                                <div class="info-row">
                                    <i class="fas fa-id-card text-primary"></i>
                                    <strong>Student ID:</strong> ${member.studentID}
                                </div>
                                <div class="info-row">
                                    <i class="fas fa-envelope text-primary"></i>
                                    <strong>Email:</strong> ${member.email}
                                </div>
                                <div class="info-row">
                                    <i class="fas fa-building text-primary"></i>
                                    <strong>Faculty:</strong> ${member.faculty}
                                </div>
                                <div class="mt-2">
                                    <span class="info-badge badge-club">
                                        <i class="fas fa-users me-1"></i>${member.clubName}
                                    </span>
                                    <span class="info-badge badge-pending">
                                        <i class="fas fa-clock me-1"></i>
                                        Applied: <fmt:formatDate value="${member.joinedAt}" pattern="dd MMM yyyy"/>
                                    </span>
                                </div>
                            </div>
                            <div class="col-auto">
                                <div class="action-buttons">
                                    <button type="button" class="btn btn-modern btn-approve" 
                                            onclick="showConfirmModal(${member.memberID}, 'approve', '${member.fullName}')">
                                        <i class="fas fa-check"></i> Approve
                                    </button>
                                    <button type="button" class="btn btn-modern btn-reject" 
                                            onclick="showConfirmModal(${member.memberID}, 'reject', '${member.fullName}')">
                                        <i class="fas fa-times"></i> Reject
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Confirmation Modal -->
        <div class="modal fade" id="confirmModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <i class="fas fa-exclamation-triangle me-2"></i>Confirm Action
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmMessage" class="mb-0"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-modern" style="background: #e2e8f0; color: #4a5568;" data-bs-dismiss="modal">
                            Cancel
                        </button>
                        <button type="button" class="btn btn-modern" id="confirmBtn" style="background: var(--primary-gradient); color: white;">
                            Confirm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <form id="memberForm" method="post" action="${pageContext.request.contextPath}/faculty/members">
            <input type="hidden" name="action" id="action">
            <input type="hidden" name="memberID" id="memberID">
        </form>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                let confirmModal;

                                                document.addEventListener('DOMContentLoaded', function () {
                                                    confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
                                                });

                                                function showConfirmModal(memberID, action, memberName) {
                                                    const messages = {
                                                        approve: `Are you sure you want to <strong>approve</strong> the membership application for <strong>${memberName}</strong>?`,
                                                        reject: `Are you sure you want to <strong>reject</strong> the membership application for <strong>${memberName}</strong>?`
                                                    };

                                                    document.getElementById('confirmMessage').innerHTML = messages[action];
                                                    document.getElementById('memberID').value = memberID;
                                                    document.getElementById('action').value = action;

                                                    const confirmBtn = document.getElementById('confirmBtn');
                                                    confirmBtn.className = 'btn btn-modern';

                                                    if (action === 'approve') {
                                                        confirmBtn.style.background = 'linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%)';
                                                        confirmBtn.innerHTML = '<i class="fas fa-check me-2"></i>Approve';
                                                    } else {
                                                        confirmBtn.style.background = 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)';
                                                        confirmBtn.innerHTML = '<i class="fas fa-times me-2"></i>Reject';
                                                    }
                                                    confirmBtn.style.color = 'white';

                                                    confirmBtn.onclick = function () {
                                                        document.getElementById('memberForm').submit();
                                                    };

                                                    confirmModal.show();
                                                }

                                                function filterMembers() {
                                                    const searchText = document.getElementById('searchInput').value.toLowerCase();
                                                    const memberCards = document.querySelectorAll('.member-card');
                                                    let visibleCount = 0;

                                                    memberCards.forEach(card => {
                                                        const searchData = card.getAttribute('data-search').toLowerCase();
                                                        if (searchData.includes(searchText)) {
                                                            card.style.display = '';
                                                            visibleCount++;
                                                        } else {
                                                            card.style.display = 'none';
                                                        }
                                                    });

                                                    document.getElementById('visibleCount').textContent = visibleCount;
                                                }
        </script>
    </body>
</html>