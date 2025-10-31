<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register Club - UniClubs</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --primary-color: #667eea;
                --secondary-color: #764ba2;
            }

            body {
                font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 20px;
                position: relative;
                overflow: hidden;
            }

            /* Animated Background */
            body::before {
                content: '';
                position: absolute;
                width: 500px;
                height: 500px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                top: -250px;
                right: -250px;
                animation: float 6s ease-in-out infinite;
            }

            body::after {
                content: '';
                position: absolute;
                width: 400px;
                height: 400px;
                background: rgba(255, 255, 255, 0.08);
                border-radius: 50%;
                bottom: -200px;
                left: -200px;
                animation: float 8s ease-in-out infinite reverse;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0) rotate(0deg);
                }
                50% {
                    transform: translateY(-30px) rotate(5deg);
                }
            }

            .register-club-container {
                position: relative;
                z-index: 1;
                width: 100%;
                max-width: 700px;
            }

            .register-card {
                background: white;
                border-radius: 24px;
                box-shadow: 0 20px 60px rgba(0,0,0,0.3);
                overflow: hidden;
                transition: transform 0.3s ease;
            }

            .register-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 25px 70px rgba(0,0,0,0.35);
            }

            /* Header Section */
            .card-header-custom {
                background: var(--primary-gradient);
                color: white;
                padding: 3rem 2.5rem;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .card-header-custom::before {
                content: '';
                position: absolute;
                width: 200px;
                height: 200px;
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50%;
                top: -100px;
                right: -100px;
            }

            .header-icon {
                width: 80px;
                height: 80px;
                background: rgba(255, 255, 255, 0.2);
                border-radius: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 1.5rem;
                font-size: 2.5rem;
                backdrop-filter: blur(10px);
                border: 2px solid rgba(255, 255, 255, 0.3);
                position: relative;
                z-index: 1;
            }

            .card-header-custom h1 {
                font-size: 2.5rem;
                font-weight: 800;
                margin-bottom: 0.5rem;
                letter-spacing: -1px;
                position: relative;
                z-index: 1;
            }

            .card-header-custom p {
                font-size: 1.1rem;
                opacity: 0.95;
                position: relative;
                z-index: 1;
            }

            /* Card Body */
            .card-body-custom {
                padding: 3rem 2.5rem;
            }

            .info-section {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                padding: 2rem;
                border-radius: 16px;
                margin-bottom: 2rem;
                border-left: 4px solid #667eea;
            }

            .info-section h3 {
                color: #1a1a2e;
                font-weight: 700;
                margin-bottom: 1rem;
                font-size: 1.5rem;
            }

            .info-section p {
                color: #6c757d;
                margin-bottom: 1rem;
                line-height: 1.8;
            }

            /* Steps */
            .steps-container {
                margin: 2rem 0;
            }

            .step-item {
                display: flex;
                align-items: start;
                gap: 1.25rem;
                padding: 1.25rem;
                background: white;
                border-radius: 16px;
                margin-bottom: 1rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }

            .step-item:hover {
                transform: translateX(5px);
                box-shadow: 0 4px 20px rgba(102, 126, 234, 0.15);
                border-color: #667eea;
            }

            .step-number {
                width: 50px;
                height: 50px;
                background: var(--primary-gradient);
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.5rem;
                font-weight: 800;
                flex-shrink: 0;
            }

            .step-content h5 {
                color: #1a1a2e;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .step-content p {
                color: #6c757d;
                margin: 0;
                font-size: 0.95rem;
            }

            /* Buttons */
            .btn-primary-custom {
                background: var(--primary-gradient);
                color: white;
                border: none;
                padding: 1rem 2.5rem;
                border-radius: 50px;
                font-size: 1.1rem;
                font-weight: 700;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .btn-primary-custom::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transition: left 0.5s ease;
            }

            .btn-primary-custom:hover::before {
                left: 100%;
            }

            .btn-primary-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
                color: white;
            }

            .btn-secondary-custom {
                background: white;
                color: #667eea;
                border: 2px solid #667eea;
                padding: 1rem 2.5rem;
                border-radius: 50px;
                font-size: 1.1rem;
                font-weight: 700;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s ease;
            }

            .btn-secondary-custom:hover {
                background: #667eea;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            }

            /* Divider */
            .divider {
                display: flex;
                align-items: center;
                text-align: center;
                color: #999;
                margin: 2rem 0;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                border-bottom: 2px solid #e9ecef;
            }

            .divider span {
                padding: 0 1.25rem;
                font-weight: 600;
                color: #6c757d;
                font-size: 0.9rem;
            }

            /* Navigation Links */
            .nav-breadcrumb {
                background: rgba(255, 255, 255, 0.95);
                padding: 1rem 1.5rem;
                border-radius: 12px;
                margin-bottom: 1rem;
                display: flex;
                gap: 0.75rem;
                align-items: center;
                font-size: 0.95rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }

            .nav-breadcrumb a {
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }

            .nav-breadcrumb a:hover {
                color: #764ba2;
            }

            .nav-breadcrumb span {
                color: #6c757d;
            }

            /* Action Buttons Container */
            .action-buttons {
                display: flex;
                gap: 1rem;
                justify-content: center;
                flex-wrap: wrap;
                margin-top: 2rem;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .card-header-custom {
                    padding: 2rem 1.5rem;
                }

                .card-header-custom h1 {
                    font-size: 2rem;
                }

                .card-body-custom {
                    padding: 2rem 1.5rem;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .btn-primary-custom,
                .btn-secondary-custom {
                    width: 100%;
                    text-align: center;
                }

                .step-item {
                    padding: 1rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="register-club-container">
            <!-- Navigation Breadcrumb -->
            <div class="nav-breadcrumb">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <span>•</span>
                <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                <span>•</span>
                <span>Register Club</span>
            </div>

            <!-- Main Card -->
            <div class="register-card">
                <!-- Header -->
                <div class="card-header-custom">
                    <div class="header-icon">🎯</div>
                    <h1>Register a Club</h1>
                    <p>Start building your community today</p>
                </div>

                <!-- Body -->
                <div class="card-body-custom">
                    <!-- Info Section -->
                    <div class="info-section">
                        <h3>Get Started</h3>
                        <p>To register a new club on UniClubs, you need to be logged in to your account. Once logged in, you'll be able to create and manage your club profile.</p>
                    </div>

                    <!-- Steps -->
                    <div class="steps-container">
                        <div class="step-item">
                            <div class="step-number">1</div>
                            <div class="step-content">
                                <h5>Login to Your Account</h5>
                                <p>Sign in with your university credentials to access club registration</p>
                            </div>
                        </div>

                        <div class="step-item">
                            <div class="step-number">2</div>
                            <div class="step-content">
                                <h5>Go to Dashboard</h5>
                                <p>Navigate to your personal dashboard to manage your activities</p>
                            </div>
                        </div>

                        <div class="step-item">
                            <div class="step-number">3</div>
                            <div class="step-content">
                                <h5>Create Your Club</h5>
                                <p>Fill in club details, upload logo, and set up your community</p>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/login" class="btn-primary-custom">
                            Login Now
                        </a>
                        <a href="${pageContext.request.contextPath}/create-club" class="btn-secondary-custom">
                            Create Club
                        </a>
                    </div>

                    <!-- Divider -->
                    <div class="divider">
                        <span>OR</span>
                    </div>

                    <!-- Back Link -->
                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/home" class="btn-secondary-custom">
                            ← Back to Home
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>