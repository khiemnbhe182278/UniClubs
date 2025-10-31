<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage News - Faculty Portal</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --success-gradient: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
                --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
                --warning-gradient: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
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

            /* Tab Navigation */
            .nav-tabs-modern {
                border: none;
                background: white;
                padding: 1rem;
                border-radius: 15px;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
                margin-bottom: 2rem;
            }

            .nav-tabs-modern .nav-link {
                border: none;
                color: #718096;
                font-weight: 600;
                padding: 0.75rem 1.5rem;
                border-radius: 10px;
                margin-right: 0.5rem;
                transition: all 0.3s;
            }

            .nav-tabs-modern .nav-link:hover {
                background: #f7fafc;
                color: #667eea;
            }

            .nav-tabs-modern .nav-link.active {
                background: var(--primary-gradient);
                color: white;
            }

            .nav-tabs-modern .badge {
                font-size: 0.75rem;
                padding: 0.25rem 0.5rem;
                border-radius: 10px;
                margin-left: 0.5rem;
            }

            /* News Card */
            .news-card {
                background: white;
                border-radius: 15px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 15px rgba(0,0,0,0.05);
                border-left: 4px solid;
                transition: all 0.3s;
            }

            .news-card.status-pending {
                border-left-color: #fbbf24;
            }
            .news-card.status-approved {
                border-left-color: #10b981;
            }
            .news-card.status-rejected {
                border-left-color: #ef4444;
            }

            .news-card:hover {
                transform: translateX(5px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            }

            .news-header {
                display: flex;
                justify-content: between;
                align-items: start;
                margin-bottom: 1rem;
            }

            .news-title {
                font-size: 1.25rem;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 0.5rem;
                flex-grow: 1;
            }

            .news-meta {
                display: flex;
                align-items: center;
                gap: 1rem;
                margin-bottom: 1rem;
                flex-wrap: wrap;
            }

            .news-badge {
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-size: 0.85rem;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .badge-club {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .badge-date {
                background: #e2e8f0;
                color: #4a5568;
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

            .news-content {
                color: #4a5568;
                line-height: 1.6;
                margin-bottom: 1rem;
            }

            .news-content.preview {
                max-height: 100px;
                overflow: hidden;
                position: relative;
            }

            .news-content.preview::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 40px;
                background: linear-gradient(transparent, white);
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

            /* Modal */
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

            .modal-body {
                padding: 2rem;
            }

            .modal-footer {
                border: none;
                padding: 1.5rem;
            }

            .news-full-content {
                color: #2d3748;
                line-height: 1.8;
                font-size: 1.05rem;
            }

            /* Stats */
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
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/faculty/members">
                                <i class="fas fa-users me-1"></i> Members
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link px-3" href="${pageContext.request.contextPath}/faculty/events">
                                <i class="fas fa-calendar me-1"></i> Events
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active px-3" href="${pageContext.request.contextPath}/faculty/news">
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
                        <h2><i class="fas fa-newspaper me-2"></i>Manage News Articles</h2>
                        <p class="mb-0">Review and moderate news content from your supervised clubs</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/faculty/dashboard" class="btn btn-modern" 
                       style="background: white; color: #667eea; border: 2px solid #667eea;">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                </div>
            </div>

            <!-- Statistics Bar -->
            <div class="stats-bar">
                <div class="stat-inline">
                    <i class="fas fa-newspaper text-primary"></i>
                    <div>
                        <div class="number">${newsList.size()}</div>
                        <div class="label">
                            <c:choose>
                                <c:when test="${currentStatus == 'Pending'}">Pending Articles</c:when>
                                <c:when test="${currentStatus == 'Approved'}">Approved Articles</c:when>
                                <c:when test="${currentStatus == 'Rejected'}">Rejected Articles</c:when>
                                <c:otherwise>Total Articles</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tab Navigation -->
            <ul class="nav nav-tabs nav-tabs-modern">
                <li class="nav-item">
                    <a class="nav-link ${empty currentStatus ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/faculty/news">
                        <i class="fas fa-list me-2"></i>All News
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'Pending' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/faculty/news?status=Pending">
                        <i class="fas fa-clock me-2"></i>Pending
                        <c:if test="${currentStatus == 'Pending' && not empty newsList}">
                            <span class="badge bg-warning">${newsList.size()}</span>
                        </c:if>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'Approved' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/faculty/news?status=Approved">
                        <i class="fas fa-check-circle me-2"></i>Approved
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${currentStatus == 'Rejected' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/faculty/news?status=Rejected">
                        <i class="fas fa-times-circle me-2"></i>Rejected
                    </a>
                </li>
            </ul>

            <!-- Empty State -->
            <c:if test="${empty newsList}">
                <div class="empty-state">
                    <i class="fas fa-newspaper"></i>
                    <h3>No News Articles Found</h3>
                    <p class="mb-4">
                    <c:choose>
                        <c:when test="${currentStatus == 'Pending'}">
                            There are no pending news articles to review at the moment.
                        </c:when>
                        <c:when test="${currentStatus == 'Approved'}">
                            No approved news articles yet.
                        </c:when>
                        <c:when test="${currentStatus == 'Rejected'}">
                            No rejected news articles.
                        </c:when>
                        <c:otherwise>
                            Your supervised clubs haven't published any news articles yet.
                        </c:otherwise>
                    </c:choose>
                    </p>
                    <a href="${pageContext.request.contextPath}/faculty/news" class="btn btn-modern btn-view">
                        <i class="fas fa-list me-2"></i>View All News
                    </a>
                </div>
            </c:if>

            <!-- News Cards -->
            <div class="row">
                <c:forEach items="${newsList}" var="news">
                    <div class="col-lg-6">
                        <div class="news-card status-${news.status.toLowerCase()}">
                            <div class="news-header">
                                <div class="news-title">${news.title}</div>
                            </div>

                            <div class="news-meta">
                                <span class="news-badge badge-club">
                                    <i class="fas fa-users"></i>
                                    ${news.clubName}
                                </span>
                                <span class="news-badge badge-date">
                                    <i class="far fa-calendar"></i>
                                    <fmt:formatDate value="${news.createdAt}" pattern="dd MMM yyyy"/>
                                </span>
                                <span class="news-badge badge-status-${news.status.toLowerCase()}">
                                    <i class="fas fa-${news.status == 'Approved' ? 'check-circle' : news.status == 'Pending' ? 'clock' : 'times-circle'}"></i>
                                    ${news.status}
                                </span>
                            </div>

                            <div class="news-content preview">
                                ${news.content}
                            </div>

                            <div class="d-flex gap-2 mt-3">
                                <button class="btn btn-modern btn-view flex-fill" 
                                        onclick="viewNews(${news.newsID}, '${fn:escapeXml(news.title)}', '${fn:escapeXml(news.clubName)}', `${fn:escapeXml(news.content)}`, '<fmt:formatDate value="${news.createdAt}" pattern="dd MMM yyyy, HH:mm"/>', '${news.status}')">
                                <i class="fas fa-eye"></i> Read Full Article
                                </button>

                                <c:if test="${news.status == 'Pending'}">
                                    <button class="btn btn-modern btn-approve" 
                                            onclick="updateNewsStatus(${news.newsID}, 'approve', '${fn:escapeXml(news.title)}')">
                                        <i class="fas fa-check"></i>
                                    </button>
                                    <button class="btn btn-modern btn-reject" 
                                            onclick="updateNewsStatus(${news.newsID}, 'reject', '${fn:escapeXml(news.title)}')">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- View News Modal -->
        <div class="modal fade" id="viewNewsModal" tabindex="-1">
            <div class="modal-dialog modal-lg modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="newsModalTitle"></h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <span class="news-badge badge-club" id="newsModalClub"></span>
                            <span class="news-badge badge-date" id="newsModalDate"></span>
                            <span class="news-badge" id="newsModalStatus"></span>
                        </div>
                        <hr>
                        <div class="news-full-content" id="newsModalContent"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-modern" style="background: #e2e8f0; color: #4a5568;" data-bs-dismiss="modal">
                            Close
                        </button>
                    </div>
                </div>
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
                        <button type="button" class="btn btn-modern" id="confirmBtn">
                            Confirm
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <form id="newsForm" method="post" action="${pageContext.request.contextPath}/faculty/news">
            <input type="hidden" name="action" id="action">
            <input type="hidden" name="newsID" id="newsID">
        </form>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                let confirmModal;
                                                let viewNewsModal;

                                                document.addEventListener('DOMContentLoaded', function () {
                                                    confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'));
                                                    viewNewsModal = new bootstrap.Modal(document.getElementById('viewNewsModal'));
                                                });

                                                function viewNews(newsID, title, club, content, date, status) {
                                                    document.getElementById('newsModalTitle').textContent = title;
                                                    document.getElementById('newsModalClub').innerHTML = '<i class="fas fa-users"></i> ' + club;
                                                    document.getElementById('newsModalDate').innerHTML = '<i class="far fa-calendar"></i> ' + date;

                                                    const statusBadge = document.getElementById('newsModalStatus');
                                                    statusBadge.className = 'news-badge badge-status-' + status.toLowerCase();
                                                    statusBadge.innerHTML = '<i class="fas fa-' +
                                                            (status === 'Approved' ? 'check-circle' : status === 'Pending' ? 'clock' : 'times-circle') +
                                                            '"></i> ' + status;

                                                    document.getElementById('newsModalContent').innerHTML = content;
                                                    viewNewsModal.show();
                                                }

                                                function updateNewsStatus(newsID, action, newsTitle) {
                                                    const messages = {
                                                        approve: `Are you sure you want to <strong>approve</strong> the news article "<strong>${newsTitle}</strong>"?`,
                                                        reject: `Are you sure you want to <strong>reject</strong> the news article "<strong>${newsTitle}</strong>"?`
                                                    };

                                                    document.getElementById('confirmMessage').innerHTML = messages[action];
                                                    document.getElementById('newsID').value = newsID;
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
                                                        document.getElementById('newsForm').submit();
                                                    };

                                                    confirmModal.show();
                                                }
        </script>
    </body>
</html>