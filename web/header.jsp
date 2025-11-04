<%-- Shared header include: navigation bar --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

<style>
    .navbar-custom {
        background: #ffffff; /* nền sáng, tối giản */
        border-bottom: 1px solid #e6eef6;
        padding: 0.5rem 0;
    }

    .navbar-brand {
        font-size: 1.25rem;
        font-weight: 700;
        color: #1f2937 !important;
        letter-spacing: 0.5px;
    }

    .navbar-custom .nav-link {
        color: #334155 !important;
        font-weight: 500;
        padding: 0.4rem 0.6rem !important;
        transition: color 0.15s ease;
        margin: 0 0.2rem;
    }

    .navbar-custom .nav-link:hover {
        color: #2b6cb0 !important;
    }

    .btn-custom {
        background: transparent;
        color: #2b6cb0;
        border: 1px solid #e6eef6;
        padding: 0.35rem 0.85rem;
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.15s ease, transform 0.15s ease;
        margin-left: 0.5rem;
    }

    .btn-custom:hover {
        background: #f1f5f9;
        transform: translateY(-2px);
    }

    .user-greeting {
        color: #334155;
        font-weight: 500;
        padding: 0.4rem 0.75rem;
        background: #f1f5f9;
        border-radius: 8px;
        margin-right: 0.5rem;
    }

    .navbar-toggler { border-color: #e6eef6; }

    .navbar-toggler-icon { background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='%23334155' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e"); }

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
                UniClubs
            </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/clubs">
                        Clubs
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/events">
                        Events
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">
                        About
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">
                        Contact
                    </a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="user-greeting">
                            Hi, ${sessionScope.user.userName}
                        </span>

                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                            Dashboard
                        </a>

                        <a class="btn btn-custom btn-sm" href="${pageContext.request.contextPath}/profile">
                            Profile
                        </a>
                        <a class="btn btn-custom btn-sm" href="${pageContext.request.contextPath}/logout">
                            Logout
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-custom" href="${pageContext.request.contextPath}/login">
                            Login
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>