<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact - UniClubs</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-top: 80px;
            color: #1a1a1a;
        }

        header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1.2rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        nav {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 2.5rem;
        }

        nav a {
            color: #333;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            position: relative;
        }

        nav a:hover {
            color: #667eea;
        }

        nav a::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transition: width 0.3s;
        }

        nav a:hover::after {
            width: 100%;
        }

        .container {
            max-width: 1000px;
            margin: 3rem auto;
            padding: 0 2rem;
        }

        .page-hero {
            text-align: center;
            margin-bottom: 4rem;
            color: white;
        }

        .page-hero h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        .page-hero p {
            font-size: 1.3rem;
            opacity: 0.95;
            font-weight: 300;
        }

        .contact-wrapper {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 3rem;
            background: white;
            border-radius: 25px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
        }

        .contact-info {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 3rem;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .contact-info h2 {
            font-size: 2rem;
            margin-bottom: 1.5rem;
            font-weight: 800;
        }

        .contact-info p {
            font-size: 1.1rem;
            line-height: 1.7;
            opacity: 0.95;
            margin-bottom: 2rem;
        }

        .info-item {
            margin-bottom: 1.5rem;
            padding-left: 2rem;
            position: relative;
        }

        .info-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 8px;
            height: 8px;
            background: white;
            border-radius: 50%;
        }

        .info-label {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            opacity: 0.8;
            margin-bottom: 0.3rem;
            font-weight: 600;
        }

        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
        }

        .contact-form {
            padding: 3rem;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #333;
            font-size: 0.95rem;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e8ecf1;
            border-radius: 12px;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s;
            background: #f8f9fa;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 150px;
        }

        .btn-submit {
            width: 100%;
            padding: 1.2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .back-link {
            text-align: center;
            margin-top: 2rem;
        }

        .back-link a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s;
            display: inline-block;
        }

        .back-link a:hover {
            transform: translateX(-5px);
            opacity: 0.8;
        }

        @media (max-width: 968px) {
            .contact-wrapper {
                grid-template-columns: 1fr;
            }

            .contact-info {
                padding: 2.5rem;
            }

            .contact-form {
                padding: 2.5rem;
            }
        }

        @media (max-width: 768px) {
            .page-hero h1 {
                font-size: 2.5rem;
            }

            .page-hero p {
                font-size: 1.1rem;
            }

            nav ul {
                gap: 1.5rem;
            }

            .contact-wrapper {
                border-radius: 20px;
            }
        }
    </style>
</head>
<body>
    <header>
        <nav>
            <div class="logo">UniClubs</div>
            <ul>
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About</a></li>
                <li><a href="${pageContext.request.contextPath}/feedback">Feedback</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <div class="page-hero">
            <h1>Get in Touch</h1>
            <p>We'd love to hear from you. Send us a message!</p>
        </div>

        <div class="contact-wrapper">
            <div class="contact-info">
                <h2>Contact Information</h2>
                <p>Fill out the form and our team will get back to you within 24 hours.</p>
                
                <div class="info-item">
                    <div class="info-label">Email</div>
                    <div class="info-value">contact@uniclubs.edu</div>
                </div>
                
                <div class="info-item">
                    <div class="info-label">Phone</div>
                    <div class="info-value">+1 (555) 123-4567</div>
                </div>
                
                <div class="info-item">
                    <div class="info-label">Office Hours</div>
                    <div class="info-value">Mon - Fri, 9:00 AM - 5:00 PM</div>
                </div>
            </div>

            <div class="contact-form">
                <form action="${pageContext.request.contextPath}/submit-contact" method="post">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" placeholder="Enter your name" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" placeholder="your.email@example.com" required>
                    </div>

                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" placeholder="Tell us what's on your mind..." required></textarea>
                    </div>

                    <button type="submit" class="btn-submit">Send Message</button>
                </form>
            </div>
        </div>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/home">← Back to Home</a>
        </div>
    </div>
</body>
</html>