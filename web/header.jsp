<%-- Shared header include: navigation bar --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<style>
    .navbar-custom {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 1rem 0;
    }

    .navbar-brand {
        font-size: 1.5rem;
        font-weight: bold;
        color: #fff !important;
        letter-spacing: 1px;
    }

    .navbar-custom .nav-link {
        color: rgba(255,255,255,0.9) !important;
        font-weight: 500;
        padding: 0.5rem 1rem !important;
        transition: all 0.3s ease;
        border-radius: 5px;
        margin: 0 0.2rem;
    }

    .navbar-custom .nav-link:hover {
        background: rgba(255,255,255,0.2);
        color: #fff !important;
        transform: translateY(-2px);
    }

    .btn-custom {
        background: #fff;
        color: #667eea;
        border: 2px solid #fff;
        padding: 0.5rem 1.5rem;
        border-radius: 25px;
        font-weight: 600;
        transition: all 0.3s ease;
        margin-left: 0.5rem;
    }

    .btn-custom:hover {
        background: transparent;
        color: #fff;
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(255,255,255,0.3);
    }

    .user-greeting {
        color: #fff;
        font-weight: 500;
        padding: 0.5rem 1rem;
        background: rgba(255,255,255,0.15);
        border-radius: 20px;
        margin-right: 0.5rem;
    }

    .navbar-toggler {
        border-color: rgba(255,255,255,0.5);
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(255, 255, 255, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    @media (max-width: 991px) {
        .navbar-custom .nav-link {
            margin: 0.2rem 0;
        }

        .user-greeting {
            margin: 0.5rem 0;
            display: inline-block;
        }

        .btn-custom {
            margin: 0.3rem 0;
            display: block;
            width: 100%;
        }
    }
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-mortarboard-fill"></i> UniClubs
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/clubs">
                        <i class="bi bi-people"></i> Clubs
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/events">
                        <i class="bi bi-calendar-event"></i> Events
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">
                        <i class="bi bi-info-circle"></i> About
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">
                        <i class="bi bi-envelope"></i> Contact
                    </a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="user-greeting">
                            <i class="bi bi-person-circle"></i> Hi, ${sessionScope.user.userName}
                        </span>

                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                            <i class="bi bi-envelope"></i> Dashboard
                        </a>

                        <a class="btn btn-custom btn-sm" href="${pageContext.request.contextPath}/profile">
                            <i class="bi bi-person"></i> Profile
                        </a>
                        <a class="btn btn-custom btn-sm" href="${pageContext.request.contextPath}/logout">
                            <i class="bi bi-box-arrow-right"></i> Logout
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-custom" href="${pageContext.request.contextPath}/login">
                            <i class="bi bi-box-arrow-in-right"></i> Login
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>