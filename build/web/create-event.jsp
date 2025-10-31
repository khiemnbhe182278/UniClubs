<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create New Event - UniClubs</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            :root {
                --primary-color: #2193b0;
                --primary-gradient: linear-gradient(135deg, #2193b0 0%, #6dd5ed 100%);
                --shadow-sm: 0 2px 8px rgba(0,0,0,0.08);
                --shadow-md: 0 4px 16px rgba(0,0,0,0.12);
                --border-radius: 12px;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f8f9fa;
                padding-top: 76px;
                min-height: 100vh;
            }

            /* Header Styles */
            header {
                background: var(--primary-gradient);
                box-shadow: var(--shadow-md);
                position: fixed;
                width: 100%;
                top: 0;
                z-index: 1030;
            }

            .navbar-brand {
                font-size: 1.75rem;
                font-weight: 700;
                color: white !important;
                letter-spacing: -0.5px;
            }

            .navbar-nav .nav-link {
                color: rgba(255,255,255,0.9) !important;
                font-weight: 500;
                padding: 0.5rem 1rem !important;
                transition: all 0.3s;
            }

            .navbar-nav .nav-link:hover {
                color: white !important;
                background: rgba(255,255,255,0.1);
                border-radius: 8px;
            }

            /* Back Button */
            .btn-back {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 600;
                padding: 0.5rem 1rem;
                border-radius: 8px;
                transition: all 0.3s;
                margin-bottom: 1.5rem;
            }

            .btn-back:hover {
                background: rgba(33,147,176,0.1);
                color: var(--primary-color);
                transform: translateX(-4px);
            }

            /* Form Container */
            .form-container {
                background: white;
                border-radius: var(--border-radius);
                padding: 3rem;
                box-shadow: var(--shadow-sm);
                border: 1px solid rgba(0,0,0,0.05);
            }

            .form-header {
                text-align: center;
                margin-bottom: 2.5rem;
            }

            .form-header h1 {
                color: var(--primary-color);
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .form-header p {
                color: #6c757d;
                font-size: 1.05rem;
            }

            /* Form Styles */
            .form-label {
                font-weight: 600;
                color: #495057;
                margin-bottom: 0.5rem;
            }

            .form-control,
            .form-select {
                padding: 0.75rem 1rem;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                font-size: 1rem;
                transition: all 0.3s;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.2rem rgba(33,147,176,0.15);
            }

            textarea.form-control {
                min-height: 120px;
                resize: vertical;
            }

            /* Submit Button */
            .btn-submit {
                background: var(--primary-gradient);
                border: none;
                color: white;
                padding: 1rem;
                border-radius: 8px;
                font-size: 1.1rem;
                font-weight: 600;
                width: 100%;
                transition: all 0.3s;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(33,147,176,0.4);
            }

            /* Empty State */
            .empty-state {
                text-align: center;
                padding: 3rem 2rem;
            }

            .empty-state p {
                color: #6c757d;
                margin-bottom: 1.5rem;
                font-size: 1.05rem;
            }

            .empty-state a {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 600;
                padding: 0.75rem 1.5rem;
                background: rgba(33,147,176,0.1);
                border-radius: 8px;
                transition: all 0.3s;
            }

            .empty-state a:hover {
                background: rgba(33,147,176,0.2);
                transform: translateY(-2px);
            }

            /* Required Field Indicator */
            .required-indicator {
                color: #dc3545;
                margin-left: 0.25rem;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .form-container {
                    padding: 2rem 1.5rem;
                }

                .form-header h1 {
                    font-size: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container py-4">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn-back">
                        <span>←</span> Back to Dashboard
                    </a>

                    <div class="form-container">
                        <div class="form-header">
                            <h1>Create New Event</h1>
                            <p>Organize an exciting event for your club members</p>
                        </div>

                        <c:if test="${not empty success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <strong>Success!</strong> ${success}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <strong>Error!</strong> ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                        </c:if>

                        <c:choose>
                            <c:when test="${not empty myClubs}">
                                <form action="${pageContext.request.contextPath}/create-event" method="post">
                                    <div class="mb-4">
                                        <label for="clubId" class="form-label">
                                            Select Club <span class="required-indicator">*</span>
                                        </label>
                                        <select id="clubId" name="clubId" class="form-select" required>
                                            <option value="">Choose a club...</option>
                                            <c:forEach var="club" items="${myClubs}">
                                                <option value="${club.clubID}">${club.clubName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="mb-4">
                                        <label for="eventName" class="form-label">
                                            Event Name <span class="required-indicator">*</span>
                                        </label>
                                        <input type="text" 
                                               id="eventName" 
                                               name="eventName" 
                                               class="form-control"
                                               placeholder="e.g., Annual Hackathon 2025" 
                                               required 
                                               maxlength="100">
                                    </div>

                                    <div class="mb-4">
                                        <label for="description" class="form-label">
                                            Event Description <span class="required-indicator">*</span>
                                        </label>
                                        <textarea id="description" 
                                                  name="description" 
                                                  class="form-control"
                                                  placeholder="Describe what participants can expect from this event..." 
                                                  required 
                                                  maxlength="500"></textarea>
                                        <div class="form-text">Maximum 500 characters</div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-4">
                                            <label for="eventDate" class="form-label">
                                                Event Date <span class="required-indicator">*</span>
                                            </label>
                                            <input type="date" 
                                                   id="eventDate" 
                                                   name="eventDate" 
                                                   class="form-control"
                                                   required>
                                        </div>

                                        <div class="col-md-6 mb-4">
                                            <label for="eventTime" class="form-label">
                                                Event Time <span class="required-indicator">*</span>
                                            </label>
                                            <input type="time" 
                                                   id="eventTime" 
                                                   name="eventTime" 
                                                   class="form-control"
                                                   required>
                                        </div>
                                    </div>

                                    <button type="submit" class="btn btn-submit">
                                        Create Event
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <p>You need to be a club leader to create events.</p>
                                    <a href="${pageContext.request.contextPath}/create-club">
                                        Create Your Own Club <span>→</span>
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

        <!-- Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>