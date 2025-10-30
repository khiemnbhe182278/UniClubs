<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thank You - UniClubs</title>
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
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem;
                color: #1a1a1a;
            }

            .success-container {
                max-width: 600px;
                width: 100%;
                background: white;
                border-radius: 25px;
                padding: 4rem 3rem;
                text-align: center;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
                animation: slideUp 0.6s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .success-icon {
                width: 100px;
                height: 100px;
                margin: 0 auto 2rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                animation: scaleIn 0.5s ease-out 0.2s both;
            }

            @keyframes scaleIn {
                from {
                    transform: scale(0);
                }
                to {
                    transform: scale(1);
                }
            }

            .success-icon::before {
                content: '';
                position: absolute;
                width: 120px;
                height: 120px;
                border: 3px solid rgba(102, 126, 234, 0.3);
                border-radius: 50%;
                animation: pulse 2s ease-in-out infinite;
            }

            @keyframes pulse {
                0%, 100% {
                    transform: scale(1);
                    opacity: 1;
                }
                50% {
                    transform: scale(1.1);
                    opacity: 0.5;
                }
            }

            .checkmark {
                width: 50px;
                height: 50px;
                position: relative;
            }

            .checkmark::before,
            .checkmark::after {
                content: '';
                position: absolute;
                background: white;
                border-radius: 3px;
            }

            .checkmark::before {
                width: 6px;
                height: 25px;
                left: 22px;
                top: 8px;
                transform: rotate(45deg);
                animation: checkmarkLine1 0.3s ease-out 0.4s both;
            }

            .checkmark::after {
                width: 6px;
                height: 15px;
                left: 10px;
                top: 20px;
                transform: rotate(-45deg);
                animation: checkmarkLine2 0.3s ease-out 0.5s both;
            }

            @keyframes checkmarkLine1 {
                from {
                    height: 0;
                }
                to {
                    height: 25px;
                }
            }

            @keyframes checkmarkLine2 {
                from {
                    height: 0;
                }
                to {
                    height: 15px;
                }
            }

            h1 {
                font-size: 2.5rem;
                font-weight: 800;
                margin-bottom: 1rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                animation: fadeIn 0.6s ease-out 0.3s both;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .message {
                font-size: 1.2rem;
                color: #666;
                line-height: 1.7;
                margin-bottom: 2.5rem;
                animation: fadeIn 0.6s ease-out 0.4s both;
            }

            .details {
                background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
                padding: 1.5rem;
                border-radius: 15px;
                margin-bottom: 2.5rem;
                animation: fadeIn 0.6s ease-out 0.5s both;
            }

            .details p {
                color: #555;
                font-size: 0.95rem;
                line-height: 1.6;
            }

            .details strong {
                color: #333;
                font-weight: 600;
            }

            .btn-home {
                display: inline-block;
                padding: 1.2rem 3rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-decoration: none;
                border-radius: 50px;
                font-weight: 700;
                font-size: 1.1rem;
                transition: all 0.3s;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
                animation: fadeIn 0.6s ease-out 0.6s both;
            }

            .btn-home:hover {
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            }

            .btn-home:active {
                transform: translateY(-1px);
            }

            @media (max-width: 768px) {
                .success-container {
                    padding: 3rem 2rem;
                }

                h1 {
                    font-size: 2rem;
                }

                .message {
                    font-size: 1.1rem;
                }

                .success-icon {
                    width: 80px;
                    height: 80px;
                }

                .success-icon::before {
                    width: 100px;
                    height: 100px;
                }

                .checkmark {
                    width: 40px;
                    height: 40px;
                }

                .checkmark::before {
                    height: 20px;
                    left: 18px;
                    top: 6px;
                }

                .checkmark::after {
                    height: 12px;
                    left: 8px;
                    top: 16px;
                }
            }
        </style>
    </head>
    <body>
        <div class="success-container">
            <div class="success-icon">
                <div class="checkmark"></div>
            </div>

            <h1>Thank You!</h1>

            <p class="message">
                We've received your message and appreciate you taking the time to contact us.
            </p>

            <div class="details">
                <p>
                    <strong>What happens next?</strong><br>
                    Our team will review your message and get back to you within 24 hours via email.
                </p>
            </div>

            <a href="${pageContext.request.contextPath}/home" class="btn-home">Back to Home</a>
        </div>
    </body>
</html>