<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Club Rules - UniClubs</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            /* Minimal / flat theme for rules page */
            :root{
                --bg: #f7fafc;
                --surface: #ffffff;
                --muted: #6b7280;
                --primary: #2563eb;
                --sidebar-w: 250px;
            }

            *{box-sizing:border-box;margin:0;padding:0}

            body{font-family:'Inter',system-ui,-apple-system,sans-serif;background:var(--bg);color:#0f172a;display:flex;min-height:100vh}

            /* Sidebar (kept identical structure but simpler visuals) */
            .sidebar{width:var(--sidebar-w);background:var(--surface);border-right:1px solid #e6edf3;position:fixed;height:100vh;overflow:auto}
            .sidebar-header{padding:18px 20px;border-bottom:1px solid #f1f5f9}
            .sidebar-header h2{font-size:1.05rem;font-weight:600}
            .sidebar-header p{color:var(--muted);font-size:0.875rem;margin-top:4px}
            .sidebar-menu{list-style:none;padding:10px 0}
            .sidebar-menu li{margin:6px 8px}
            .sidebar-menu a{display:block;padding:10px 14px;color:var(--muted);text-decoration:none;border-radius:6px;font-weight:500}
            .sidebar-menu a:hover{background:#f1f5f9;color:var(--primary)}
            .sidebar-menu a.active{background:#eef2ff;color:var(--primary);font-weight:600}

            /* Main content */
            .main-content{margin-left:var(--sidebar-w);padding:28px;flex:1}

            /* Cards and simple UI */
            .overview,.rule-card,.empty-state{background:var(--surface);border:1px solid #eef2f6;border-radius:8px}
            .overview{padding:18px;margin-bottom:16px}
            .rule-card{padding:14px;border-radius:8px}
            .rule-number{width:36px;height:36px;background:var(--primary);color:#fff;border-radius:6px;display:inline-flex;align-items:center;justify-content:center;margin-right:10px}
            .rule-title{font-weight:600;color:#0f172a}
            .rule-content{color:var(--muted);padding:12px;background:#fbfdff;border-radius:6px}

            /* Buttons */
            .btn{display:inline-flex;align-items:center;gap:8px;padding:8px 12px;border-radius:8px;border:none;cursor:pointer;text-decoration:none}
            .btn-primary{background:var(--primary);color:#fff}
            .btn-danger{background:#ef4444;color:#fff}
            .btn-secondary{background:#f8fafc;color:#0f172a;border:1px solid #eef2f6}

            .alert{padding:12px;border-radius:8px;margin-bottom:12px}
            .alert.success{background:#f0fff4;color:#064e3b}
            .alert.error{background:#fff5f5;color:#7f1d1d}

            @media (max-width:768px){
                .main-content{margin-left:0;padding:16px}
                .sidebar{position:relative;width:100%;height:auto}
            }
        </style>
    </head>
    <body>
        <div class="sidebar">
            <div class="sidebar-header">
                <h2><i class="bi bi-person-badge"></i> Leader Dashboard</h2>
                <p>${club.clubName}</p>
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/leader/dashboard?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/dashboard')}">class="active"</c:if>>
                        <i class="bi bi-speedometer2"></i> Overview
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/club/members?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/club/members')}">class="active"</c:if>>
                        <i class="bi bi-people"></i> Members
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/events?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/events')}">class="active"</c:if>>
                        <i class="bi bi-calendar3"></i> Events
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/rules?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/rules')}">class="active"</c:if>>
                        <i class="bi bi-file-text"></i> Rules
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/leader/news?clubId=${club.clubID}&amp;clubID=${club.clubID}"
                       <c:if test="${fn:contains(pageContext.request.requestURI, '/leader/news')}">class="active"</c:if>>
                        <i class="bi bi-newspaper"></i> News
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content">
            <div class="overview">
                <div class="title">
                    <i class="bi bi-file-text"></i>
                    <h2>Club Rules</h2>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createModal">
                        <i class="bi bi-plus"></i> Create New Rule
                    </button>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty message}">
                    <div class="alert success">
                        <i class="bi bi-check-circle"></i> ${message}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert error">
                        <i class="bi bi-exclamation-circle"></i> ${error}
                    </div>
                </c:if>

                <!-- Rules List -->
                <div class="content">
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
                                            <button class="btn primary" 
                                                data-rule-id="${rule.ruleID}" 
                                                data-rule-title="${fn:escapeXml(rule.title)}"
                                                data-rule-text="${fn:escapeXml(rule.ruleText)}"
                                                onclick="editRule(this)">
                                                <i class="bi bi-pencil"></i>
                                                Edit
                                            </button>
                                            <button class="btn danger"
                                                data-rule-id="${rule.ruleID}"
                                                data-club-id="${club.clubID}"
                                                onclick="deleteRule(this)">
                                                <i class="bi bi-trash"></i>
                                                Delete
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="bi bi-file-text"></i>
                                <h3>No Rules Yet</h3>
                                <p>Start by creating your first club rule to establish guidelines for members.</p>
                                <button type="button" class="btn primary" data-bs-toggle="modal" data-bs-target="#createModal">
                                    <i class="bi bi-plus"></i> Create First Rule
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
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
                            <div class="form-group mb-4">
                                <label for="title" class="form-label">Rule Title</label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       placeholder="Enter a clear and concise title" required>
                            </div>
                            <div class="form-group mb-4">
                                <label for="ruleText" class="form-label">Rule Description</label>
                                <textarea class="form-control" id="ruleText" name="ruleText" rows="4"
                                          placeholder="Provide detailed guidelines and expectations" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn secondary" data-bs-dismiss="modal">
                                <i class="bi bi-x"></i> Cancel
                            </button>
                            <button type="submit" class="btn primary">
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
                            <div class="form-group mb-4">
                                <label for="editTitle" class="form-label">Rule Title</label>
                                <input type="text" class="form-control" id="editTitle" name="title" required>
                            </div>
                            <div class="form-group mb-4">
                                <label for="editRuleText" class="form-label">Rule Description</label>
                                <textarea class="form-control" id="editRuleText" name="ruleText" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn secondary" data-bs-dismiss="modal">
                                <i class="bi bi-x"></i> Cancel
                            </button>
                            <button type="submit" class="btn primary">
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
            // Function to handle rule editing
            function editRule(button) {
                const ruleId = button.getAttribute('data-rule-id');
                const title = button.getAttribute('data-rule-title');
                const ruleText = button.getAttribute('data-rule-text');
                
                document.getElementById('editRuleId').value = ruleId;
                document.getElementById('editTitle').value = title;
                document.getElementById('editRuleText').value = ruleText;
                
                new bootstrap.Modal(document.getElementById('editModal')).show();
            }

            // Function to handle rule deletion
            function deleteRule(button) {
                const ruleId = button.getAttribute('data-rule-id');
                const clubId = button.getAttribute('data-club-id');
                
                if (confirm('Are you sure you want to delete this rule? This action cannot be undone.')) {
                    window.location.href = '${pageContext.request.contextPath}/leader/delete-rule?ruleId=' + ruleId + '&clubId=' + clubId;
                }
            }

            // Auto-dismiss alerts after 5 seconds
            document.addEventListener('DOMContentLoaded', function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    setTimeout(() => {
                        alert.remove();
                    }, 5000);
                });
            });
        </script>
    </body>
</html>