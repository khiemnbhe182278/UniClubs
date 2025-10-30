<%-- Shared footer include --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .site-footer {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        margin-top: 5rem;
        padding: 2.5rem 0;
        border-top: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.1);
    }

    .footer-inner {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 1.5rem;
    }

    .footer-inner > div:first-child {
        font-weight: 600;
        color: #333;
        font-size: 1rem;
    }

    .footer-links {
        display: flex;
        gap: 0.5rem;
        align-items: center;
    }

    .footer-links a {
        color: #666;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s;
        padding: 0.5rem 1rem;
        border-radius: 8px;
        position: relative;
    }

    .footer-links a:hover {
        color: #667eea;
        background: rgba(102, 126, 234, 0.1);
    }

    .footer-separator {
        color: #ccc;
        font-weight: 300;
    }

    @media (max-width: 768px) {
        .footer-inner {
            flex-direction: column;
            text-align: center;
            gap: 1rem;
        }

        .footer-links {
            flex-wrap: wrap;
            justify-content: center;
        }
    }
</style>

<footer class="site-footer">
    <div class="footer-inner">
        <div>UniClubs</div>
        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/guidelines">Guidelines</a>
            <span class="footer-separator">?</span>
            <a href="${pageContext.request.contextPath}/resources">Resources</a>
            <span class="footer-separator">?</span>
            <a href="${pageContext.request.contextPath}/feedback">Feedback</a>
        </div>
    </div>
</footer>