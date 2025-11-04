<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Events - Faculty Portal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            
            /* Sidebar Styles */
            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                bottom: 0;
                width: 260px;
                background-color: #fff;
                padding: 1rem;
                overflow-y: auto;
                z-index: 1000;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .sidebar-header {
                padding: 1rem;
                border-bottom: 1px solid #eee;
                margin-bottom: 1rem;
            }

            .sidebar-header h2 {
                font-size: 1.25rem;
                margin-bottom: 0.5rem;
                color: #333;
            }

            .sidebar-header p {
                font-size: 0.9rem;
                color: #666;
                margin: 0;
            }

            .sidebar-menu {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .sidebar-menu li {
                margin-bottom: 0.5rem;
            }

            .sidebar-menu a {
                display: flex;
                align-items: center;
                padding: 0.75rem 1rem;
                color: #333;
                text-decoration: none;
                border-radius: 0.5rem;
                transition: all 0.3s;
            }

            .sidebar-menu a:hover {
                background-color: #f8f9fa;
                color: #007bff;
            }

            .sidebar-menu a.active {
                background-color: #e7f1ff;
                color: #007bff;
            }

            .sidebar-menu i {
                margin-right: 0.5rem;
                font-size: 1.1rem;
            }

            /* Main Content */
            .main-content {
                margin-left: 260px;
                padding: 2rem;
                min-height: 100vh;
            }

            .page-header {
                background: white;
                padding: 1.5rem;
                border-radius: 0.5rem;
                border: 1px solid #e9ecef;
                margin-bottom: 2rem;
            }

            /* Filter Section */
            .filter-section {
                background: white;
                border-radius: 0.5rem;
                padding: 1.5rem;
                border: 1px solid #e9ecef;
                margin-bottom: 2rem;
            }

            .filter-pills {
                display: flex;
                gap: 1rem;
                flex-wrap: wrap;
            }

            .filter-pill {
                padding: 0.75rem 1.5rem;
                border-radius: 25px;
                border: 2px solid #e2e8f0;
                background: white;
                color: #718096;
                cursor: pointer;
                transition: all 0.3s;
                font-weight: 500;
            }

            .filter-pill:hover {
                border-color: #667eea;
                color: #667eea;
                transform: translateY(-2px);
            }

            .filter-pill.active {
                background: var(--primary-gradient);
                color: white;
                border-color: transparent;
            }

            .search-input {
                border: 2px solid #e2e8f0;
                border-radius: 10px;
                padding: 0.75rem 1rem 0.75rem 3rem;
                transition: all 0.3s;
            }

            .search-input:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .search-icon {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: #a0aec0;
            }

            /* Event Card */
            .event-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
                transition: all 0.3s;
                height: 100%;
                border-left: 4px solid;
            }

            .event-card.status-pending {
                border-left-color: #fbbf24;
            }
            .event-card.status-approved {
                border-left-color: #10b981;
            }
            .event-card.status-rejected {
                border-left-color: #ef4444;
            }

            .event-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            }

            .event-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }

            .event-image-placeholder {
                width: 100%;
                height: 200px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 3rem;
            }

            .event-body {
                padding: 1.5rem;
            }

            .event-title {
                font-size: 1.25rem;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 1rem;
            }

            .event-info {
                display: flex;
                align-items: center;
                margin-bottom: 0.75rem;
                color: #718096;
                font-size: 0.9rem;
            }

            .event-info i {
                width: 20px;
                margin-right: 0.5rem;
                color: #667eea;
            }

            .event-badge {
                display: inline-block;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 600;
                margin-right: 0.5rem;
                margin-bottom: 0.5rem;
            }

            .badge-club {
                background: #e0e7ff;
                color: #5b21b6;
            }

            .badge-participants {
                background: #dbeafe;
                color: #1e40af;
            }

            .badge-status-pending {
                background: var(--warning-gradient);
                color: white;
            }

            .badge-status-approved {
                background: var(--success-gradient);
                color: white;
            }

            .badge-status-rejected {
                background: var(--danger-gradient);
                color: white;
            }

            /* Action Buttons */
            .btn-modern {
                border-radius: 10px;
                padding: 0.5rem 1.25rem;
                font-weight: 600;
                border: none;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .btn-view {
                background: var(--primary-gradient);
                color: white;
            }

            .btn-view:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
                color: white;
            }

            .btn-approve {
                background: var(--success-gradient);
                color: white;
            }

            .btn-approve:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(132, 250, 176, 0.4);
                color: white;
            }

            .btn-reject {
                background: var(--danger-gradient);
                color: white;
            }

            .btn-reject:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(250, 112, 154, 0.4);
                color: white;
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
                background: var(--primary-gradient);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                margin-bottom: 1.5rem;
            }

            /* Stats Bar */
            .stats-bar {
                background: white;
                border-radius: 15px;
                padding: 1rem 1.5rem;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
                margin-bottom: 2rem;
            }

            .stat-inline {
                display: inline-flex;
                align-items: center;
                margin-right: 2rem;
            }

            .stat-inline i {
                font-size: 1.5rem;
                margin-right: 0.75rem;
            }

            .stat-inline .number {
                font-size: 1.5rem;
                font-weight: 700;
                color: #2d3748;
            }

            .stat-inline .label {
                color: #718096;
                font-size: 0.9rem;
            }
        </style>
    </head>
    <body>
        
        <div class="sidebar">
            <div class="sidebar-header">
                <h2><i class="bi bi-person-badge"></i> Faculty Portal</h2>
                <p>${sessionScope.user.userName}</p>
                <div class="d-flex mt-3">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                        <i class="bi bi-box-arrow-right"></i> Sign Out
                    </a>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/faculty/dashboard" <c:if test="${fn:contains(pageContext.request.requestURI, '/faculty/dashboard')}">class="active"</c:if>>
                        <i class="bi bi-speedometer2"></i> Dashboard
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/faculty/members" <c:if test="${fn:contains(pageContext.request.requestURI, '/faculty/members')}">class="active"</c:if>>
                        <i class="bi bi-people"></i> Members
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/faculty/events" <c:if test="${fn:contains(pageContext.request.requestURI, '/faculty/events')}">class="active"</c:if>>
                        <i class="bi bi-calendar3"></i> Events
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/faculty/news" <c:if test="${fn:contains(pageContext.request.requestURI, '/faculty/news')}">class="active"</c:if>>
                        <i class="bi bi-newspaper"></i> News
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content">

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
                        <h2><i class="fas fa-calendar-alt me-2"></i>Manage Events</h2>
                        <p class="mb-0">Oversee and approve events from your supervised clubs</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/faculty/dashboard" class="btn btn-modern" 
                       style="background: white; color: #667eea; border: 2px solid #667eea;">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                </div>
            </div>

            <!-- Statistics Bar -->
            <c:if test="${not empty events}">
                <div class="stats-bar">
                    <div class="stat-inline">
                        <i class="fas fa-calendar-alt text-primary"></i>
                        <div>
                            <div class="number">${events.size()}</div>
                            <div class="label">Total Events</div>
                        </div>
                    </div>
                    <div class="stat-inline">
                        <i class="fas fa-clock text-warning"></i>
                        <div>
                            <div class="number">
                                <c:set var="pendingCount" value="0"/>
                                <c:forEach items="${events}" var="event">
                                    <c:if test="${event.status == 'Pending'}">
                                        <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${pendingCount}
                            </div>
                            <div class="label">Pending</div>
                        </div>
                    </div>
                    <div class="stat-inline">
                        <i class="fas fa-check-circle text-success"></i>
                        <div>
                            <div class="number">
                                <c:set var="approvedCount" value="0"/>
                                <c:forEach items="${events}" var="event">
                                    <c:if test="${event.status == 'Approved'}">
                                        <c:set var="approvedCount" value="${approvedCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${approvedCount}
                            </div>
                            <div class="label">Approved</div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Filter Section -->
            <c:if test="${not empty events}">
                <div class="filter-section">
                    <div class="row g-3 align-items-center">
                        <div class="col-md-6">
                            <div class="filter-pills">
                                <button class="filter-pill active" onclick="filterEvents('all')">
                                    <i class="fas fa-list me-2"></i>All Events
                                </button>
                                <button class="filter-pill" onclick="filterEvents('Pending')">
                                    <i class="fas fa-clock me-2"></i>Pending
                                </button>
                                <button class="filter-pill" onclick="filterEvents('Approved')">
                                    <i class="fas fa-check me-2"></i>Approved
                                </button>
                                <button class="filter-pill" onclick="filterEvents('Rejected')">
                                    <i class="fas fa-times me-2"></i>Rejected
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="position-relative">
                                <i class="fas fa-search search-icon"></i>
                                <input type="text" class="form-control search-input" id="searchInput"
                                       placeholder="Search events by name, club, or location..."
                                       onkeyup="searchEvents()">
                            </div>
                        </div>
                    </div>
                    <div class="mt-3">
                        <small class="text-muted">
                            Showing <span id="visibleCount">${events.size()}</span> of ${events.size()} events
                        </small>
                    </div>
                </div>
            </c:if>

            <!-- Empty State -->
            <c:if test="${empty events}">
                <div class="empty-state">
                    <i class="fas fa-calendar-times"></i>
                    <h3>No Events Found</h3>
                    <p class="mb-4">Your supervised clubs haven't created any events yet.</p>
                    <a href="${pageContext.request.contextPath}/faculty/dashboard" class="btn btn-modern btn-view">
                        <i class="fas fa-home me-2"></i>Back to Dashboard
                    </a>
                </div>
            </c:if>

            <!-- Event Cards -->
            <div class="row g-4" id="eventsContainer">
                <c:forEach items="${events}" var="event">
                    <div class="col-xl-4 col-lg-6 event-item" 
                         data-status="${event.status}" 
                         data-search="${event.eventName} ${event.clubName} ${event.location}">
                        <div class="event-card status-${event.status.toLowerCase()}">
                            <c:choose>
                                <c:when test="${not empty event.eventImage}">
                                    <img src="${pageContext.request.contextPath}/uploads/${event.eventImage}" 
                                         class="event-image" alt="${event.eventName}">
                                </c:when>
                                <c:otherwise>
                                    <div class="event-image-placeholder">
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <div class="event-body">
                                <div class="event-title">${event.eventName}</div>

                                <div class="event-info">
                                    <i class="fas fa-users"></i>
                                    <span>${event.clubName}</span>
                                </div>

                                <div class="event-info">
                                    <i class="fas fa-calendar"></i>
                                    <span><fmt:formatDate value="${event.eventDate}" pattern="dd MMM yyyy, HH:mm"/></span>
                                </div>

                                <div class="event-info">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${event.location}</span>
                                </div>

                                <c:if test="${not empty event.registrationDeadline}">
                                    <div class="event-info">
                                        <i class="fas fa-clock"></i>
                                        <span>Deadline: <fmt:formatDate value="${event.registrationDeadline}" pattern="dd MMM yyyy"/></span>
                                    </div>
                                </c:if>

                                <div class="mt-3 mb-3">
                                    <span class="event-badge badge-participants">
                                        <i class="fas fa-user-friends me-1"></i>
                                        ${event.currentParticipants}
                                        <c:if test="${event.maxParticipants > 0}">/ ${event.maxParticipants}</c:if>
                                        participants
                                    </span>
                                    <span class="event-badge badge-status-${event.status.toLowerCase()}">
                                        ${event.status}
                                    </span>
                                </div>

                                <div class="d-grid gap-2">
                                    <a href="${pageContext.request.contextPath}/faculty/events?eventID=${event.eventID}" 
                                       class="btn btn-modern btn-view">
                                        <i class="fas fa-eye"></i> View Participants
                                    </a>

                                    <c:if test="${event.status == 'Pending'}">
                                        <div class="btn-group" role="group">
                                            <button class="btn btn-modern btn-approve flex-fill" 
                                                    onclick="updateEventStatus(${event.eventID}, 'approveEvent', '${event.eventName}')">
                                                <i class="fas fa-check"></i> Approve
                                            </button>
                                            <button class="btn btn-modern btn-reject flex-fill" 
                                                    onclick="updateEventStatus(${event.eventID}, 'rejectEvent', '${event.eventName}')">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </div>
                                    </c:if>
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
                <div class="modal-content" style="border-radius: 15px; border: none;">
                    <div class="modal-header" style="background: var(--primary-gradient); color: white; border-radius: 15px 15px 0 0;">
                        <h5 class="modal-title">
                            <i class="fas fa-exclamation-triangle me-2"></i>Confirm Action
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmMessage" class="mb-0"></p>
                    </div>
                    <div class="modal-footer" style="border: none;">
                        <button type="button" class="btn btn-modern" style="background: #e2e8f0; color: #4a5568;" data-bs-dismiss="modal">
                            Cancel
                        </button>
                        <button type="button" class="btn btn-modern" id="confirmBtn">
                            Confirm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <form id="eventForm" method="post" action="${pageContext.request.contextPath}/faculty/events">
            <input type="hidden" name="action" id="action">
            <input type="hidden" name="eventID" id="eventID">
        </form>

    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                        let confirmModal;
                                                        let currentFilter = 'all';

                                                        document.addEventListener('DOMContentLoaded', function () {
                                                            confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
                                                        });

                                                        function updateEventStatus(eventID, action, eventName) {
                                                            const messages = {
                                                                approveEvent: `Are you sure you want to <strong>approve</strong> the event "<strong>${eventName}</strong>"?`,
                                                                rejectEvent: `Are you sure you want to <strong>reject</strong> the event "<strong>${eventName}</strong>"?`
                                                            };

                                                            document.getElementById('confirmMessage').innerHTML = messages[action];
                                                            document.getElementById('eventID').value = eventID;
                                                            document.getElementById('action').value = action;

                                                            const confirmBtn = document.getElementById('confirmBtn');
                                                            confirmBtn.className = 'btn btn-modern';

                                                            if (action === 'approveEvent') {
                                                                confirmBtn.style.background = 'linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%)';
                                                                confirmBtn.innerHTML = '<i class="fas fa-check me-2"></i>Approve Event';
                                                            } else {
                                                                confirmBtn.style.background = 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)';
                                                                confirmBtn.innerHTML = '<i class="fas fa-times me-2"></i>Reject Event';
                                                            }
                                                            confirmBtn.style.color = 'white';

                                                            confirmBtn.onclick = function () {
                                                                document.getElementById('eventForm').submit();
                                                            };

                                                            confirmModal.show();
                                                        }

                                                        function filterEvents(status) {
                                                            currentFilter = status;

                                                            // Update active pill
                                                            document.querySelectorAll('.filter-pill').forEach(pill => {
                                                                pill.classList.remove('active');
                                                            });
                                                            event.target.closest('.filter-pill').classList.add('active');

                                                            applyFilters();
                                                        }

                                                        function searchEvents() {
                                                            applyFilters();
                                                        }

                                                        function applyFilters() {
                                                            const searchText = document.getElementById('searchInput').value.toLowerCase();
                                                            const eventItems = document.querySelectorAll('.event-item');
                                                            let visibleCount = 0;

                                                            eventItems.forEach(item => {
                                                                const status = item.getAttribute('data-status');
                                                                const searchData = item.getAttribute('data-search').toLowerCase();

                                                                const statusMatch = currentFilter === 'all' || status === currentFilter;
                                                                const searchMatch = !searchText || searchData.includes(searchText);

                                                                if (statusMatch && searchMatch) {
                                                                    item.style.display = '';
                                                                    visibleCount++;
                                                                } else {
                                                                    item.style.display = 'none';
                                                                }
                                                            });

                                                            document.getElementById('visibleCount').textContent = visibleCount;
                                                        }
        </script>
    </body>
</html>