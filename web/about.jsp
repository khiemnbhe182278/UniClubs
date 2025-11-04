<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>About Us - UniClubs</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- AOS Animation -->
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <!-- page-level inline styles removed in favour of shared minimal CSS (admin.css) -->
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <!-- Hero Section -->
        <section class="about-hero">
            <div class="container text-center">
                <div data-aos="fade-up">
                    <h1>About UniClubs</h1>
                    <p class="lead">Empowering students to connect, grow, and make lasting memories through campus clubs and organizations</p>
                </div>
            </div>
        </section>

        <!-- Mission Section -->
        <div class="container">
            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="card p-4 mb-4" data-aos="fade-up">
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
                    <div class="feature-card card">
                        <h4>Club Discovery</h4>
                        <p>Find clubs that match your interests with our advanced search and filtering system</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card card">
                        <h4>Member Management</h4>
                        <p>Efficient tools for tracking memberships, roles, and participation</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card card">
                        <h4>Event Management</h4>
                        <p>Plan, organize, and promote club events seamlessly</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card card">
                        <h4>Analytics & Reports</h4>
                        <p>Track engagement and measure club performance with detailed insights</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Section -->
        <div class="container">
            <div class="card p-3" data-aos="zoom-in">
                <div class="row">
                    <div class="col-md-3 col-6">
                        <div class="stat-card text-center p-3">
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
                        <div class="card p-3">
                            <h4>Student-Centered</h4>
                            <p>Every feature is designed with students' needs and experiences in mind</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="200">
                        <div class="card p-3">
                            <h4>Community Building</h4>
                            <p>Fostering connections and collaboration among students and organizations</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="300">
                        <div class="card p-3">
                            <h4>Innovation</h4>
                            <p>Continuously improving our platform with cutting-edge features</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <div class="container">
            <div class="card p-3 text-center" data-aos="fade-up">
                <h3>Ready to Get Started?</h3>
                <p>Join thousands of students making the most of their university experience through UniClubs</p>
                <a href="${pageContext.request.contextPath}/clubs" class="btn btn-primary">
                    Explore Clubs Now
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary ms-3">
                    Back to Home
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