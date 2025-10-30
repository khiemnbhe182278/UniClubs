<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        <style>
            body {
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
                padding: 2rem 0;
            }

            .page-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 2.5rem;
                border-radius: 20px;
                margin-bottom: 2rem;
                box-shadow: 0 10px 40px rgba(102, 126, 234, 0.3);
            }

            .page-header h1 {
                font-size: 2.5rem;
                font-weight: 800;
                margin-bottom: 0.5rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            }

            .page-header p {
                font-size: 1.1rem;
                opacity: 0.9;
                margin: 0;
            }

            .btn-create-rule {
                background: white;
                color: #667eea;
                border: 3px solid white;
                padding: 12px 30px;
                border-radius: 50px;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 5px 20px rgba(0,0,0,0.2);
            }

            .btn-create-rule:hover {
                background: transparent;
                color: white;
                transform: translateY(-3px);
                box-shadow: 0 8px 30px rgba(0,0,0,0.3);
            }

            .rule-card {
                background: white;
                border-radius: 20px;
                padding: 2rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
                border: 2px solid transparent;
                transition: all 0.3s ease;
            }

            .rule-card:hover {
                border-color: #667eea;
                box-shadow: 0 10px 40px rgba(102, 126, 234, 0.2);
                transform: translateY(-5px);
            }

            .rule-number {
                display: inline-block;
                width: 50px;
                height: 50px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 50%;
                text-align: center;
                line-height: 50px;
                font-weight: 700;
                font-size: 1.2rem;
                margin-right: 1rem;
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            }

            .rule-title {
                color: #2d3748;
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
            }

            .rule-content {
                color: #6c757d;
                line-height: 1.8;
                padding: 1rem;
                background: #f8f9fa;
                border-radius: 12px;
                margin-bottom: 1.5rem;
                border-left: 4px solid #667eea;
                white-space: pre-wrap;
                word-wrap: break-word;
            }

            .rule-actions {
                display: flex;
                gap: 10px;
                justify-content: flex-end;
            }

            .btn-action {
                padding: 10px 25px;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s ease;
                border: none;
            }

            .btn-edit-rule {
                background: #3498db;
                color: white;
            }

            .btn-edit-rule:hover {
                background: #2980b9;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            }

            .btn-delete-rule {
                background: #e74c3c;
                color: white;
            }

            .btn-delete-rule:hover {
                background: #c0392b;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
            }

            .modal-content {
                border-radius: 20px;
                border: none;
                box-shadow: 0 15px 50px rgba(0,0,0,0.3);
            }

            .modal-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 20px 20px 0 0;
                padding: 1.5rem 2rem;
                border: none;
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
                border-radius: 15px;
                border: none;
                padding: 1rem 1.5rem;
                margin-bottom: 1.5rem;
            }

            .alert-success {
                background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
                color: white;
            }

            .alert-danger {
                background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
                color: white;
            }

            @media (max-width: 768px) {
                .page-header h1 {
                    font-size: 1.8rem;
                }

                .rule-title {
                    font-size: 1.2rem;
                }

                .rule-actions {
                    flex-direction: column;
                }

                .btn-action {
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="../header.jsp" %>

        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center flex-wrap">
                    <div>
                        <h1><i class="bi bi-file-text-fill"></i> Club Rules</h1>
                        <p><i class="bi bi-building"></i> ${club.clubName}</p>
                    </div>
                    <button type="button" class="btn btn-create-rule mt-3 mt-md-0" data-bs-toggle="modal" data-bs-target="#createModal">
                        <i class="bi bi-plus-circle-fill"></i> Create New Rule
                    </button>
                </div>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${param.success == 'created'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill"></i> Rule created successfully!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.success == 'updated'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill"></i> Rule updated successfully!
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
                                        onclick="openEditModal(${rule.ruleID}, '${fn:escapeXml(rule.title)}', `${fn:escapeXml(rule.ruleText)}`)">
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
                        <h5 class="modal-title" id="createModalLabel">
                            <i class="bi bi-plus-circle-fill"></i> Create New Rule
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/leader/create-rule" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="clubId" value="${club.clubID}">

                            <div class="mb-3">
                                <label for="title" class="form-label">
                                    <i class="bi bi-tag-fill"></i> Rule Title *
                                </label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       placeholder="Enter rule title" required>
                            </div>

                            <div class="mb-3">
                                <label for="ruleText" class="form-label">
                                    <i class="bi bi-card-text"></i> Rule Description *
                                </label>
                                <textarea class="form-control" id="ruleText" name="ruleText" 
                                          placeholder="Enter detailed rule description" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">
                                <i class="bi bi-x-circle"></i> Cancel
                            </button>
                            <button type="submit" class="btn btn-submit">
                                <i class="bi bi-check-circle-fill"></i> Create Rule
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
                        <h5 class="modal-title" id="editModalLabel">
                            <i class="bi bi-pencil-fill"></i> Edit Rule
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/leader/update-rule" method="post">
                        <div class="modal-body">
                            <input type="hidden" id="editRuleId" name="ruleId">
                            <input type="hidden" name="clubId" value="${club.clubID}">

                            <div class="mb-3">
                                <label for="editTitle" class="form-label">
                                    <i class="bi bi-tag-fill"></i> Rule Title *
                                </label>
                                <input type="text" class="form-control" id="editTitle" name="title" required>
                            </div>

                            <div class="mb-3">
                                <label for="editRuleText" class="form-label">
                                    <i class="bi bi-card-text"></i> Rule Description *
                                </label>
                                <textarea class="form-control" id="editRuleText" name="ruleText" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">
                                <i class="bi bi-x-circle"></i> Cancel
                            </button>
                            <button type="submit" class="btn btn-submit">
                                <i class="bi bi-check-circle-fill"></i> Update Rule
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="../footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
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