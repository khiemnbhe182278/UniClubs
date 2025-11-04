<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Club Rules - UniClubs</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #34495e;
                --accent-color: #3498db;
                --background-color: #f5f6fa;
                --surface-color: #ffffff;
                --text-primary: #2c3e50;
                --text-secondary: #666666;
                --border-color: #e1e4e8;
                --sidebar-width: 250px;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', system-ui, -apple-system, sans-serif;
                background: var(--background-color);
                color: var(--text-primary);
                min-height: 100vh;
                display: flex;
            }

            .dashboard {
                flex: 1;
                margin-left: var(--sidebar-width);
                padding: 2rem;
                max-width: calc(100% - var(--sidebar-width));
            }

            .sidebar {
                width: var(--sidebar-width);
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                background: var(--surface-color);
                border-right: 1px solid var(--border-color);
                padding: 1.5rem 0;
            }

            .sidebar-header {
                padding: 0 1.5rem;
                margin-bottom: 2rem;
            }

            .sidebar-logo {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--primary-color);
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .sidebar-nav {
                list-style: none;
                padding: 0;
            }

            .sidebar-nav a {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                padding: 0.75rem 1.5rem;
                color: var(--text-secondary);
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .sidebar-nav a:hover,
            .sidebar-nav a.active {
                color: var(--accent-color);
                background: var(--background-color);
            }

            .sidebar-nav i {
                font-size: 1.25rem;
            }

            .rules-container {
                display: grid;
                gap: 1.5rem;
            }

            .rule-card {
                background: var(--surface-color);
                border-radius: 0.5rem;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                padding: 1.5rem;
                border: 1px solid var(--border-color);
                transition: all 0.2s ease;
            }

            .rule-card:hover {
                border-color: var(--accent-color);
                box-shadow: 0 2px 6px rgba(0,0,0,0.15);
            }

            .rule-number {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 2rem;
                height: 2rem;
                background: var(--accent-color);
                color: white;
                border-radius: 0.375rem;
                font-weight: 600;
                font-size: 1rem;
                margin-right: 1rem;
            }

            .rule-title {
                color: var(--text-primary);
                font-size: 1.125rem;
                font-weight: 600;
                margin-bottom: 0.75rem;
                display: flex;
                align-items: center;
            }

            .rule-content {
                color: var(--text-secondary);
                line-height: 1.6;
                padding: 1rem;
                background: var(--background-color);
                border-radius: 0.375rem;
                margin-bottom: 1rem;
                border-left: 3px solid var(--accent-color);
                white-space: pre-wrap;
                word-wrap: break-word;
            }

            .rule-actions {
                display: flex;
                gap: 0.5rem;
                justify-content: flex-end;
            }

            .btn {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.5rem 1rem;
                border-radius: 0.375rem;
                font-weight: 500;
                transition: all 0.2s ease;
                cursor: pointer;
                border: none;
            }

            .btn-primary {
                background: var(--accent-color);
                color: white;
            }

            .btn-primary:hover {
                opacity: 0.9;
            }

            .btn-danger {
                background: #dc3545;
                color: white;
            }

            .btn-danger:hover {
                opacity: 0.9;
            }

            .modal {
                background: rgba(0, 0, 0, 0.5);
            }

            .modal-content {
                border: none;
                border-radius: 0.5rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .modal-header {
                border-bottom: 1px solid var(--border-color);
                padding: 1rem 1.5rem;
                background: var(--surface-color);
                color: var(--text-primary);
            }

            .modal-header h5 {
                font-weight: 700;
                font-size: 1.5rem;
            }

            .modal-header .btn-close {
                filter: brightness(0) invert(1);
                opacity: 0.8;
            }

            .modal-body {
                padding: 2rem;
            }

            .form-label {
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 0.5rem;
            }

            .form-control, .form-control:focus {
                border-radius: 12px;
                border: 2px solid #e2e8f0;
                padding: 12px 16px;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            }

            textarea.form-control {
                min-height: 150px;
                resize: vertical;
            }

            .modal-footer {
                border: none;
                padding: 1.5rem 2rem;
            }

            .btn-submit {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 12px 40px;
                border-radius: 50px;
                font-weight: 600;
                border: none;
                transition: all 0.3s ease;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }

            .btn-cancel {
                background: #6c757d;
                color: white;
                padding: 12px 40px;
                border-radius: 50px;
                font-weight: 600;
                border: none;
                transition: all 0.3s ease;
            }

            .btn-cancel:hover {
                background: #5a6268;
                transform: translateY(-2px);
            }

            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                background: white;
                border-radius: 20px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            }

            .empty-state i {
                font-size: 5rem;
                color: #667eea;
                margin-bottom: 1.5rem;
            }

            .empty-state h3 {
                color: #2d3748;
                font-weight: 700;
                margin-bottom: 1rem;
            }

            .empty-state p {
                color: #6c757d;
                font-size: 1.1rem;
            }

            .alert {
                border-radius: 0.375rem;
                padding: 1rem;
                margin: 1rem;
                border: 1px solid transparent;
            }

            .alert-success {
                background-color: #d1e7dd;
                border-color: #badbcc;
                color: #0f5132;
            }

            .alert-danger {
                background-color: #f8d7da;
                border-color: #f5c2c7;
                color: #842029;
            }

            .alert i {
                margin-right: 0.5rem;
            }

            /* Media Queries */
            @media (max-width: 768px) {
                .dashboard {
                    margin-left: 0;
                    padding: 1rem;
                    max-width: 100%;
                }

                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                }

                .sidebar.show {
                    transform: translateX(0);
                }
            }
        </style>
    </head>
    <body>
        <nav class="sidebar">
            <div class="sidebar-header">
                <a href="home.jsp" class="sidebar-logo">
                    <i class="bi bi-building"></i>
                    UniClubs
                </a>
            </div>
            <ul class="sidebar-nav">
                <li>
                    <a href="leader-dashboard.jsp?clubId=${clubId}" class="nav-link">
                        <i class="bi bi-speedometer2"></i>
                        Dashboard
                    </a>
                </li>
                <li>
                    <a href="leader-members.jsp?clubId=${clubId}" class="nav-link">
                        <i class="bi bi-people"></i>
                        Members
                    </a>
                </li>
                <li>
                    <a href="leader-events.jsp?clubId=${clubId}" class="nav-link">
                        <i class="bi bi-calendar-event"></i>
                        Events
                    </a>
                </li>
                <li>
                    <a href="leader-news.jsp?clubId=${clubId}" class="nav-link">
                        <i class="bi bi-newspaper"></i>
                        News
                    </a>
                </li>
                <li>
                    <a href="leader-rules.jsp?clubId=${clubId}" class="nav-link active">
                        <i class="bi bi-file-text"></i>
                        Rules
                    </a>
                </li>
            </ul>
        </nav>

        <main class="dashboard">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title m-0">Club Rules</h3>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createModal">
                        <i class="bi bi-plus"></i> Create New Rule
                    </button>
                </div>
                <div class="card-body">
                    <!-- Success/Error Messages -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="bi bi-check-circle"></i> ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="bi bi-exclamation-circle"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Rules List -->
                    <c:choose>
                        <c:when test="${not empty rules}">
                            <div class="rules-container">
                                <c:forEach var="rule" items="${rules}" varStatus="status">
                                    <div class="rule-card">
                                        <div class="rule-title">
                                            <span class="rule-number">${status.index + 1}</span>
                                            ${fn:escapeXml(rule.title)}
                                        </div>
                                        <div class="rule-content">
                                            ${fn:escapeXml(rule.ruleText)}
                                        </div>
                                        <div class="rule-actions">
                                            <button class="btn btn-primary"
                                                onclick="openEditModal(${rule.ruleID}, '${fn:escapeXml(rule.title)}', '${fn:escapeXml(rule.ruleText)}')">
                                                <i class="bi bi-pencil"></i>
                                                Edit
                                            </button>
                                            <button class="btn btn-danger"
                                                onclick="if(confirm('Are you sure you want to delete this rule?')) window.location.href='${pageContext.request.contextPath}/leader/delete-rule?ruleId=${rule.ruleID}&clubId=${clubId}'">
                                                <i class="bi bi-trash"></i>
                                                Delete
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center p-5">
                                <div class="mb-3">
                                    <i class="bi bi-file-text" style="font-size: 3rem; color: var(--accent-color);"></i>
                                </div>
                                <h3 class="text-muted">No Rules Yet</h3>
                                <p class="text-muted">Start by creating your first club rule to establish guidelines for members.</p>
                                <button type="button" class="btn btn-primary mt-3" data-bs-toggle="modal" data-bs-target="#createModal">
                                    <i class="bi bi-plus"></i> Create First Rule
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.success == 'deleted'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill"></i> Rule deleted successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.error == 'failed'}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle-fill"></i> Operation failed. Please try again.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Rules List -->
            <c:choose>
                <c:when test="${not empty rules}">
                    <c:forEach var="rule" items="${rules}" varStatus="status">
                        <div class="rule-card">
                            <div class="rule-title">
                                <span class="rule-number">${status.index + 1}</span>
                                <span>${rule.title}</span>
                            </div>
                            <div class="rule-content">
                                ${rule.ruleText}
                            </div>
                            <div class="rule-actions">
                                <button type="button" class="btn btn-action btn-edit-rule" 
                                        onclick="openEditModal(${rule.ruleID}, '${fn:escapeXml(rule.title)}', '${fn:escapeXml(rule.ruleText)}')">
                                    <i class="bi bi-pencil-fill"></i> Edit
                                </button>
                                <form method="post" action="${pageContext.request.contextPath}/leader/delete-rule" style="display: inline;" 
                                      onsubmit="return confirm('Are you sure you want to delete this rule?');">
                                    <input type="hidden" name="ruleId" value="${rule.ruleID}">
                                    <input type="hidden" name="clubId" value="${club.clubID}">
                                    <button type="submit" class="btn btn-action btn-delete-rule">
                                        <i class="bi bi-trash-fill"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="bi bi-inbox"></i>
                        <h3>No Rules Yet</h3>
                        <p>Start by creating your first club rule to establish guidelines for members.</p>
                        <button type="button" class="btn btn-submit mt-3" data-bs-toggle="modal" data-bs-target="#createModal">
                            <i class="bi bi-plus-circle-fill"></i> Create First Rule
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Create Rule Modal -->
        <div class="modal fade" id="createModal" tabindex="-1" aria-labelledby="createModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createModalLabel">Create New Rule</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/leader/create-rule" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="clubId" value="${club.clubID}">

                            <div class="form-group mb-3">
                                <label for="title" class="form-label">Rule Title</label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       placeholder="Enter rule title" required>
                            </div>

                            <div class="form-group mb-3">
                                <label for="ruleText" class="form-label">Rule Description</label>
                                <textarea class="form-control" id="ruleText" name="ruleText" rows="4"
                                          placeholder="Enter detailed rule description" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-plus"></i> Create Rule
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Rule Modal -->
        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">Edit Rule</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/leader/update-rule" method="post">
                        <div class="modal-body">
                            <input type="hidden" id="editRuleId" name="ruleId">
                            <input type="hidden" name="clubId" value="${club.clubID}">

                            <div class="form-group mb-3">
                                <label for="editTitle" class="form-label">Rule Title</label>
                                <input type="text" class="form-control" id="editTitle" name="title" required>
                            </div>

                            <div class="form-group mb-3">
                                <label for="editRuleText" class="form-label">Rule Description</label>
                                <textarea class="form-control" id="editRuleText" name="ruleText" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check"></i> Update Rule
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            function escapeHtml(text) {
                const div = document.createElement('div');
                div.innerText = text;
                return div.innerHTML;
            }

            function openEditModal(ruleId, title, ruleText) {
                document.getElementById('editRuleId').value = ruleId;
                document.getElementById('editTitle').value = title;
                document.getElementById('editRuleText').value = ruleText;
                new bootstrap.Modal(document.getElementById('editModal')).show();
            }

            // Auto-dismiss alerts after 5 seconds
            document.addEventListener('DOMContentLoaded', function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    setTimeout(() => {
                        const bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    }, 5000);
                });
            });
                                          function openEditModal(id, title, text) {
                                              document.getElementById('editRuleId').value = id;
                                              document.getElementById('editTitle').value = title;
                                              document.getElementById('editRuleText').value = text;

                                              var editModal = new bootstrap.Modal(document.getElementById('editModal'));
                                              editModal.show();
                                          }

                                          // Auto-dismiss alerts after 5 seconds
                                          document.addEventListener('DOMContentLoaded', function () {
                                              setTimeout(function () {
                                                  var alerts = document.querySelectorAll('.alert');
                                                  alerts.forEach(function (alert) {
                                                      var bsAlert = new bootstrap.Alert(alert);
                                                      bsAlert.close();
                                                  });
                                              }, 5000);
                                          });
        </script>
    </body>
</html>