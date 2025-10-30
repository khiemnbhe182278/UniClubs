<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About Us - UniClubs</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <!-- AOS Animation -->
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

        <style>
            body {
                background: #f8f9fa;
            }

            /* Hero Section */
            .about-hero {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 100px 0 60px;
                margin-bottom: 60px;
                position: relative;
                overflow: hidden;
            }

            .about-hero::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="rgba(255,255,255,0.1)" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,122.7C672,117,768,139,864,154.7C960,171,1056,181,1152,165.3C1248,149,1344,107,1392,85.3L1440,64L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>') no-repeat bottom;
                background-size: cover;
                opacity: 0.3;
            }

            .about-hero h1 {
                font-size: 3.5rem;
                font-weight: 800;
                margin-bottom: 20px;
                position: relative;
                z-index: 1;
            }

            .about-hero .lead {
                font-size: 1.3rem;
                opacity: 0.95;
                position: relative;
                z-index: 1;
                max-width: 700px;
                margin: 0 auto;
            }

            /* Mission Card */
            .mission-card {
                background: white;
                border-radius: 20px;
                padding: 50px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.1);
                margin-bottom: 40px;
                border: 2px solid transparent;
                transition: all 0.3s ease;
            }

            .mission-card:hover {
                border-color: #667eea;
                transform: translateY(-5px);
                box-shadow: 0 15px 50px rgba(102, 126, 234, 0.2);
            }

            .mission-icon {
                width: 80px;
                height: 80px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2.5rem;
                color: white;
                margin-bottom: 25px;
            }

            .mission-card h2 {
                font-size: 2rem;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 20px;
            }

            .mission-card p {
                color: #6c757d;
                line-height: 1.8;
                font-size: 1.1rem;
                margin-bottom: 0;
            }

            /* Features Grid */
            .feature-box {
                background: white;
                border-radius: 15px;
                padding: 40px 30px;
                text-align: center;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
                transition: all 0.3s ease;
                height: 100%;
                border: 2px solid transparent;
            }

            .feature-box:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(102, 126, 234, 0.2);
                border-color: #667eea;
            }

            .feature-icon {
                width: 70px;
                height: 70px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
                font-size: 1.8rem;
                color: white;
            }

            .feature-box h4 {
                font-size: 1.3rem;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 15px;
            }

            .feature-box p {
                color: #6c757d;
                line-height: 1.6;
                margin-bottom: 0;
            }

            /* Team Section */
            .team-section {
                background: white;
                padding: 80px 0;
                margin-top: 60px;
            }

            .section-title {
                font-size: 2.5rem;
                font-weight: 800;
                text-align: center;
                margin-bottom: 60px;
                color: #2d3748;
                position: relative;
                padding-bottom: 20px;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 4px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 2px;
            }

            .value-card {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 20px;
                padding: 40px 30px;
                text-align: center;
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
                transition: all 0.3s ease;
                height: 100%;
            }

            .value-card:hover {
                transform: translateY(-10px) scale(1.05);
                box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
            }

            .value-icon {
                font-size: 3rem;
                margin-bottom: 20px;
                filter: drop-shadow(0 5px 10px rgba(0,0,0,0.2));
            }

            .value-card h4 {
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 15px;
            }

            .value-card p {
                font-size: 1rem;
                opacity: 0.95;
                margin-bottom: 0;
            }

            /* Stats Section */
            .stats-highlight {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 20px;
                padding: 60px 40px;
                margin: 60px 0;
                box-shadow: 0 15px 50px rgba(102, 126, 234, 0.3);
            }

            .stat-item {
                text-align: center;
                padding: 20px;
            }

            .stat-number {
                font-size: 3rem;
                font-weight: 800;
                display: block;
                margin-bottom: 10px;
            }

            .stat-label {
                font-size: 1.1rem;
                opacity: 0.95;
            }

            /* CTA Section */
            .cta-box {
                background: white;
                border-radius: 20px;
                padding: 60px 40px;
                text-align: center;
                box-shadow: 0 10px 40px rgba(0,0,0,0.1);
                margin: 60px 0;
            }

            .cta-box h3 {
                font-size: 2rem;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 20px;
            }

            .cta-box p {
                color: #6c757d;
                font-size: 1.1rem;
                margin-bottom: 30px;
            }

            .btn-cta {
                padding: 15px 40px;
                font-size: 1.1rem;
                font-weight: 600;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 50px;
                text-decoration: none;
                display: inline-block;
                transition: all 0.3s ease;
            }

            .btn-cta:hover {
                transform: translateY(-3px) scale(1.05);
                box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
                color: white;
            }

            .btn-cta i {
                margin-right: 8px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .about-hero h1 {
                    font-size: 2.5rem;
                }

                .about-hero .lead {
                    font-size: 1.1rem;
                }

                .mission-card {
                    padding: 30px 20px;
                }

                .section-title {
                    font-size: 2rem;
                }

                .stat-number {
                    font-size: 2.5rem;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <!-- Hero Section -->
        <section class="about-hero">
            <div class="container text-center">
                <div data-aos="fade-up">
                    <h1><i class="bi bi-info-circle-fill"></i> About UniClubs</h1>
                    <p class="lead">Empowering students to connect, grow, and make lasting memories through campus clubs and organizations</p>
                </div>
            </div>
        </section>

        <!-- Mission Section -->
        <div class="container">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="mission-card" data-aos="fade-up">
                        <div class="mission-icon">
                            <i class="bi bi-bullseye"></i>
                        </div>
                        <h2>Our Mission</h2>
                        <p>UniClubs is a comprehensive university clubs management system designed to bridge the gap between students and campus organizations. We believe that student life extends beyond academics, and clubs play a crucial role in developing leadership skills, building networks, and creating unforgettable experiences.</p>
                        <p class="mt-3">Our platform simplifies club discovery, membership management, event coordination, and communication - making it easier than ever for students to get involved and for club leaders to manage their organizations effectively.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Features Section -->
        <div class="container mt-5">
            <h2 class="section-title" data-aos="fade-up">What We Offer</h2>
            <div class="row g-4">
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="bi bi-search-heart"></i>
                        </div>
                        <h4>Club Discovery</h4>
                        <p>Find clubs that match your interests with our advanced search and filtering system</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="bi bi-people"></i>
                        </div>
                        <h4>Member Management</h4>
                        <p>Efficient tools for tracking memberships, roles, and participation</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="bi bi-calendar-check"></i>
                        </div>
                        <h4>Event Management</h4>
                        <p>Plan, organize, and promote club events seamlessly</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="bi bi-graph-up-arrow"></i>
                        </div>
                        <h4>Analytics & Reports</h4>
                        <p>Track engagement and measure club performance with detailed insights</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Section -->
        <div class="container">
            <div class="stats-highlight" data-aos="zoom-in">
                <div class="row">
                    <div class="col-md-3 col-6">
                        <div class="stat-item">
                            <span class="stat-number">50+</span>
                            <span class="stat-label">Active Clubs</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="stat-item">
                            <span class="stat-number">2,500+</span>
                            <span class="stat-label">Student Members</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="stat-item">
                            <span class="stat-number">200+</span>
                            <span class="stat-label">Events Annually</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-6">
                        <div class="stat-item">
                            <span class="stat-number">95%</span>
                            <span class="stat-label">Satisfaction Rate</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Values Section -->
        <section class="team-section">
            <div class="container">
                <h2 class="section-title" data-aos="fade-up">Our Core Values</h2>
                <div class="row g-4">
                    <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="100">
                        <div class="value-card">
                            <div class="value-icon">🎯</div>
                            <h4>Student-Centered</h4>
                            <p>Every feature is designed with students' needs and experiences in mind</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="200">
                        <div class="value-card">
                            <div class="value-icon">🤝</div>
                            <h4>Community Building</h4>
                            <p>Fostering connections and collaboration among students and organizations</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="300">
                        <div class="value-card">
                            <div class="value-icon">💡</div>
                            <h4>Innovation</h4>
                            <p>Continuously improving our platform with cutting-edge features</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <div class="container">
            <div class="cta-box" data-aos="fade-up">
                <h3>Ready to Get Started?</h3>
                <p>Join thousands of students making the most of their university experience through UniClubs</p>
                <a href="${pageContext.request.contextPath}/clubs" class="btn-cta">
                    <i class="bi bi-rocket-takeoff"></i> Explore Clubs Now
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn-cta ms-3" style="background: white; color: #667eea; border: 2px solid #667eea;">
                    <i class="bi bi-house-fill"></i> Back to Home
                </a>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- AOS Animation -->
        <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
        <script>
            AOS.init({
                duration: 800,
                once: true,
                offset: 100
            });
        </script>
    </body>
</html>