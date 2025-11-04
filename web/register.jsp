<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register - UniClubs</title>

    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/css/admin.css"
    />

    <style>
      :root {
        --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        --bg-light: #f8f9fa;
        --text-primary: #1e293b;
        --text-secondary: #64748b;
        --border-color: #e2e8f0;
        --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.05);
        --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.08);
        --shadow-lg: 0 10px 30px rgba(102, 126, 234, 0.15);
      }

      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
          "Helvetica Neue", Arial, sans-serif;
        background: linear-gradient(135deg, #f5f7fa 0%, #f0f3f8 100%);
        min-height: 100vh;
        padding: 2rem 1rem;
      }

      .auth-container {
        max-width: 500px;
        margin: 0 auto;
        animation: fadeInUp 0.6s ease-out;
      }

      @keyframes fadeInUp {
        from {
          opacity: 0;
          transform: translateY(30px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .auth-card {
        background: white;
        border-radius: 24px;
        padding: 3rem 2.5rem;
        box-shadow: var(--shadow-lg);
        position: relative;
        overflow: hidden;
      }

      .auth-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 5px;
        background: var(--primary-gradient);
      }

      .logo-section {
        text-align: center;
        margin-bottom: 2.5rem;
      }

      .logo-icon {
        width: 64px;
        height: 64px;
        margin: 0 auto 1.25rem;
        background: var(--primary-gradient);
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2rem;
        font-weight: 700;
        color: white;
        box-shadow: var(--shadow-md);
      }

      .auth-title {
        font-size: 1.875rem;
        font-weight: 700;
        color: var(--text-primary);
        margin-bottom: 0.5rem;
        letter-spacing: -0.02em;
      }

      .auth-subtitle {
        color: var(--text-secondary);
        font-size: 0.95rem;
        line-height: 1.5;
      }

      .form-group {
        margin-bottom: 1.5rem;
      }

      .form-label {
        display: block;
        font-size: 0.875rem;
        font-weight: 600;
        color: var(--text-primary);
        margin-bottom: 0.5rem;
        letter-spacing: 0.01em;
      }

      .form-control {
        width: 100%;
        padding: 0.875rem 1rem;
        font-size: 0.9375rem;
        color: var(--text-primary);
        background: var(--bg-light);
        border: 2px solid transparent;
        border-radius: 12px;
        transition: all 0.2s ease;
        font-weight: 450;
      }

      .form-control:hover {
        background: #fff;
        border-color: #e2e8f0;
      }

      .form-control:focus {
        outline: none;
        background: #fff;
        border-color: #667eea;
        box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
      }

      .form-control::placeholder {
        color: #94a3b8;
      }

      .form-hint {
        font-size: 0.8125rem;
        color: var(--text-secondary);
        margin-top: 0.375rem;
        display: flex;
        align-items: center;
        gap: 0.25rem;
      }

      .form-hint::before {
        content: "ℹ";
        font-size: 0.75rem;
        opacity: 0.6;
      }

      .password-strength {
        margin-top: 0.625rem;
      }

      .strength-bar {
        height: 4px;
        background: #e2e8f0;
        border-radius: 2px;
        overflow: hidden;
        margin-bottom: 0.375rem;
      }

      .strength-fill {
        height: 100%;
        width: 0;
        transition: all 0.3s ease;
        border-radius: 2px;
      }

      .strength-weak {
        width: 33%;
        background: linear-gradient(90deg, #ef4444, #f87171);
      }
      .strength-medium {
        width: 66%;
        background: linear-gradient(90deg, #f59e0b, #fbbf24);
      }
      .strength-strong {
        width: 100%;
        background: linear-gradient(90deg, #10b981, #34d399);
      }

      .strength-text {
        font-size: 0.8125rem;
        font-weight: 500;
      }

      .btn-primary {
        width: 100%;
        padding: 0.875rem;
        background: var(--primary-gradient);
        border: none;
        border-radius: 12px;
        font-size: 0.9375rem;
        font-weight: 600;
        color: white;
        cursor: pointer;
        transition: all 0.2s ease;
        margin-top: 0.5rem;
        letter-spacing: 0.01em;
        position: relative;
        overflow: hidden;
      }

      .btn-primary::before {
        content: "";
        position: absolute;
        top: 50%;
        left: 50%;
        width: 0;
        height: 0;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.2);
        transform: translate(-50%, -50%);
        transition: width 0.6s, height 0.6s;
      }

      .btn-primary:hover::before {
        width: 300px;
        height: 300px;
      }

      .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(102, 126, 234, 0.35);
      }

      .btn-primary:active {
        transform: translateY(0);
      }

      .alert {
        padding: 1rem;
        border-radius: 12px;
        margin-bottom: 1.5rem;
        border: none;
        font-size: 0.875rem;
        font-weight: 500;
        animation: slideDown 0.3s ease;
      }

      @keyframes slideDown {
        from {
          opacity: 0;
          transform: translateY(-10px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      .alert-danger {
        background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
        color: #dc2626;
        border-left: 4px solid #dc2626;
      }

      .divider {
        display: flex;
        align-items: center;
        margin: 2rem 0 1.5rem;
        color: var(--text-secondary);
        font-size: 0.8125rem;
        font-weight: 500;
      }

      .divider::before,
      .divider::after {
        content: "";
        flex: 1;
        height: 1px;
        background: var(--border-color);
      }

      .divider span {
        padding: 0 1rem;
      }

      .auth-footer {
        text-align: center;
        font-size: 0.875rem;
        color: var(--text-secondary);
      }

      .auth-footer a {
        color: #667eea;
        text-decoration: none;
        font-weight: 600;
        transition: color 0.2s ease;
      }

      .auth-footer a:hover {
        color: #764ba2;
        text-decoration: underline;
      }

      .footer-links {
        margin-top: 0.75rem;
      }

      .footer-links a {
        display: inline-flex;
        align-items: center;
        gap: 0.25rem;
      }

      /* Input Icons */
      .input-wrapper {
        position: relative;
      }

      .input-icon {
        position: absolute;
        right: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-secondary);
        cursor: pointer;
        transition: color 0.2s ease;
        font-size: 1.25rem;
      }

      .input-icon:hover {
        color: var(--text-primary);
      }

      /* Responsive */
      @media (max-width: 576px) {
        body {
          padding: 1rem 0.5rem;
        }

        .auth-card {
          padding: 2rem 1.5rem;
          border-radius: 20px;
        }

        .auth-title {
          font-size: 1.5rem;
        }

        .logo-icon {
          width: 56px;
          height: 56px;
          font-size: 1.75rem;
        }
      }

      /* Smooth transitions */
      * {
        transition: background-color 0.2s ease, border-color 0.2s ease;
      }
    </style>
  </head>
  <body>
    <%@ include file="header.jsp" %>

    <div class="auth-container">
      <div class="auth-card">
        <div class="logo-section">
          <div class="logo-icon">UC</div>
          <h1 class="auth-title">Create Account</h1>
          <p class="auth-subtitle">
            Join UniClubs and connect with your community
          </p>
        </div>

        <!-- Error Alert -->
        <c:if test="${not empty error}">
          <div class="alert alert-danger" role="alert">${error}</div>
        </c:if>

        <!-- Register Form -->
        <form
          action="${pageContext.request.contextPath}/register"
          method="post"
          id="registerForm"
        >
          <div class="form-group">
            <label for="userName" class="form-label">Full Name</label>
            <input
              type="text"
              class="form-control"
              id="userName"
              name="userName"
              placeholder="Enter your full name"
              value="${userName}"
              required
            />
            <div class="form-hint">As shown in your student ID</div>
          </div>

          <div class="form-group">
            <label for="email" class="form-label">Student Email</label>
            <input
              type="email"
              class="form-control"
              id="email"
              name="email"
              placeholder="youremail@fpt.edu.vn"
              value="${email}"
              required
            />
            <div class="form-hint">Must be an FPT email address</div>
          </div>

          <div class="form-group">
            <label for="password" class="form-label">Password</label>
            <div class="input-wrapper">
              <input
                type="password"
                class="form-control"
                id="password"
                name="password"
                placeholder="Choose a secure password"
                required
              />
              <span class="input-icon" id="togglePassword">👁</span>
            </div>
            <div class="form-hint">
              At least 8 characters with numbers and symbols
            </div>
            <div class="password-strength">
              <div class="strength-bar">
                <div class="strength-fill" id="strengthFill"></div>
              </div>
              <div class="strength-text" id="strengthText"></div>
            </div>
          </div>

          <div class="form-group">
            <label for="confirmPassword" class="form-label"
              >Confirm Password</label
            >
            <div class="input-wrapper">
              <input
                type="password"
                class="form-control"
                id="confirmPassword"
                name="confirmPassword"
                placeholder="Re-enter your password"
                required
              />
              <span class="input-icon" id="toggleConfirmPassword">👁</span>
            </div>
            <div class="form-hint">Must match the password above</div>
          </div>

          <button type="submit" class="btn-primary">Create Account</button>
        </form>

        <div class="divider">
          <span>OR</span>
        </div>

        <div class="auth-footer">
          <p>
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Sign in here</a>
          </p>
          <div class="footer-links">
            <a href="${pageContext.request.contextPath}/home"
              >← Back to Homepage</a
            >
          </div>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
      // Password visibility toggle
      document
        .getElementById("togglePassword")
        .addEventListener("click", function () {
          const passwordInput = document.getElementById("password");
          const type = passwordInput.type === "password" ? "text" : "password";
          passwordInput.type = type;
          this.textContent = type === "password" ? "👁" : "🙈";
        });

      document
        .getElementById("toggleConfirmPassword")
        .addEventListener("click", function () {
          const passwordInput = document.getElementById("confirmPassword");
          const type = passwordInput.type === "password" ? "text" : "password";
          passwordInput.type = type;
          this.textContent = type === "password" ? "👁" : "🙈";
        });

      // Password strength checker
      document
        .getElementById("password")
        .addEventListener("input", function (e) {
          const password = e.target.value;
          const strengthFill = document.getElementById("strengthFill");
          const strengthText = document.getElementById("strengthText");

          if (password.length === 0) {
            strengthFill.className = "strength-fill";
            strengthText.textContent = "";
            return;
          }

          let strength = 0;
          if (password.length >= 6) strength++;
          if (password.length >= 10) strength++;
          if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
          if (/\d/.test(password)) strength++;
          if (/[^a-zA-Z\d]/.test(password)) strength++;

          strengthFill.className = "strength-fill";
          if (strength <= 2) {
            strengthFill.classList.add("strength-weak");
            strengthText.textContent = "🔴 Weak password";
            strengthText.style.color = "#ef4444";
          } else if (strength <= 3) {
            strengthFill.classList.add("strength-medium");
            strengthText.textContent = "🟡 Medium strength";
            strengthText.style.color = "#f59e0b";
          } else {
            strengthFill.classList.add("strength-strong");
            strengthText.textContent = "🟢 Strong password";
            strengthText.style.color = "#10b981";
          }
        });

      // Form validation
      document
        .getElementById("registerForm")
        .addEventListener("submit", function (e) {
          const password = document.getElementById("password").value;
          const confirmPassword =
            document.getElementById("confirmPassword").value;

          if (password !== confirmPassword) {
            e.preventDefault();
            alert("Passwords do not match!");
            document.getElementById("confirmPassword").focus();
            return false;
          }

          if (password.length < 8) {
            e.preventDefault();
            alert("Password must be at least 8 characters long!");
            document.getElementById("password").focus();
            return false;
          }
        });

      // Auto-focus first input
      window.addEventListener("load", function () {
        document.getElementById("userName").focus();
      });
    </script>
  </body>
</html>
