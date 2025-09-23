<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.News" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<News> newsList = (List<News>) request.getAttribute("newsList");
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>News - Student Club</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap');

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f4f9;
            color: #1e293b;
            line-height: 1.7;
            font-size: 16px;
        }

        header {
            background: linear-gradient(90deg, #1e3a8a, #60a5fa);
            color: #ffffff;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        header h1 {
            font-size: 28px;
            font-weight: 700;
            letter-spacing: 1.2px;
        }

        nav a {
            color: #ffffff;
            text-decoration: none;
            margin: 0 15px;
            font-weight: 500;
            font-size: 16px;
            position: relative;
            transition: color 0.3s ease;
        }

        nav a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -4px;
            left: 0;
            background-color: #facc15;
            transition: width 0.3s ease;
        }

        nav a:hover::after {
            width: 100%;
        }

        nav a:hover {
            color: #facc15;
        }

        section {
            padding: 40px;
            margin: 20px auto;
            width: 90%;
            max-width: 800px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 28px;
            color: #1e3a8a;
            margin-bottom: 20px;
            border-left: 6px solid #60a5fa;
            padding-left: 12px;
            font-weight: 600;
        }

        .form-container {
            max-width: 700px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 16px;
            font-weight: 500;
            color: #1e3a8a;
            margin-bottom: 8px;
        }

        input[type="text"],
        input[type="date"],
        input[type="url"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            font-size: 15px;
            border: 2px solid #bfdbfe;
            border-radius: 8px;
            background: #f8fafc;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            font-family: 'Poppins', sans-serif;
        }

        input[type="text"]:focus,
        input[type="date"]:focus,
        input[type="url"]:focus,
        textarea:focus,
        select:focus {
            border-color: #60a5fa;
            box-shadow: 0 0 8px rgba(96, 165, 250, 0.3);
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 150px;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        button[type="submit"],
        .btn-cancel {
            padding: 12px 24px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            flex: 1;
        }

        button[type="submit"] {
            background: linear-gradient(90deg, #1e3a8a, #60a5fa);
            color: #ffffff;
        }

        button[type="submit"]:hover {
            background: linear-gradient(90deg, #2563eb, #93c5fd);
            transform: translateY(-2px);
        }

        .btn-cancel {
            background: #f8fafc;
            color: #64748b;
            border: 2px solid #bfdbfe;
        }

        .btn-cancel:hover {
            background: #f1f5f9;
            color: #475569;
        }

        .image-preview {
            margin-top: 10px;
            text-align: center;
        }

        .image-preview img {
            max-width: 200px;
            max-height: 150px;
            border-radius: 8px;
            border: 2px solid #bfdbfe;
        }

        .required {
            color: #dc2626;
        }

        footer {
            background: #1e3a8a;
            color: #ffffff;
            text-align: center;
            padding: 25px;
            font-size: 15px;
            margin-top: 30px;
        }

        footer a {
            color: #93c5fd;
            text-decoration: none;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        footer a:hover {
            color: #facc15;
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                padding: 15px 20px;
            }

            header h1 {
                font-size: 24px;
                margin-bottom: 10px;
            }

            nav a {
                margin: 0 8px;
                font-size: 14px;
            }

            section {
                padding: 20px;
                width: 95%;
            }

            h2 {
                font-size: 24px;
            }

            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    
    <header>
        <h1>Student Club</h1>
        <nav>
            <a href="<%= contextPath %>/index.jsp">Home</a>
            <a href="<%= contextPath %>/news">News</a>
            <a href="<%= contextPath %>/club-registration?action=new">Register Club</a>
            <a href="<%= contextPath %>/users">Members</a>
            <a href="<%= contextPath %>/about.jsp">About</a>
            <a href="<%= contextPath %>/contact.jsp">Contact</a>
            <a href="<%= contextPath %>/login.jsp">Login</a>
        </nav>
    </header>

    <section>
        <h2>Latest News</h2>
        
        <c:if test="${not empty param.success}">
            <div style="color: green; padding: 10px; background: #f0fff4; border-radius: 5px; margin-bottom: 20px;">
                <c:choose>
                    <c:when test="${param.success == 'created'}">✅ News created successfully!</c:when>
                    <c:when test="${param.success == 'updated'}">✅ News updated successfully!</c:when>
                    <c:when test="${param.success == 'deleted'}">✅ News deleted successfully!</c:when>
                </c:choose>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div style="color: red; padding: 10px; background: #fff5f5; border-radius: 5px; margin-bottom: 20px;">
                <c:choose>
                    <c:when test="${param.error == 'notfound'}">❌ News not found!</c:when>
                    <c:when test="${param.error == 'create'}">❌ Failed to create news!</c:when>
                    <c:when test="${param.error == 'update'}">❌ Failed to update news!</c:when>
                    <c:when test="${param.error == 'delete'}">❌ Failed to delete news!</c:when>
                    <c:when test="${param.error == 'unauthorized'}">❌ Please login first!</c:when>
                    <c:when test="${param.error == 'please_login'}">❌ Please login to add news!</c:when>
                    <c:otherwise>❌ An error occurred!</c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <c:if test="${empty newsList}">
            <article>
                <h3>No news available</h3>
                <p>Check back later for updates.</p>
            </article>
        </c:if>

        <c:forEach var="news" items="${newsList}">
            <article>
                <h3>${news.title}</h3>
                <p><strong>Date:</strong> ${news.publishDate}</p>
                <p><strong>Author:</strong> ${news.authorName}</p>
                <p>${news.content}</p>
                
                <c:if test="${not empty news.imageUrl}">
                    <img src="${news.imageUrl}" alt="News image" style="max-width: 100%; height: auto; margin-top: 10px;">
                </c:if>
                
                <div style="margin-top: 15px;">
                    <a href="<%= contextPath %>/news?action=edit&id=${news.id}" style="color: #2563eb; margin-right: 10px;">✏️ Edit</a>
                    <a href="<%= contextPath %>/news?action=delete&id=${news.id}" onclick="return confirm('Delete this news?')" style="color: #dc2626;">🗑️ Delete</a>
                </div>
            </article>
            <hr>
        </c:forEach>

        <!-- SỬA LINK NÚT ADD -->
        <div style="text-align: center; margin-top: 30px;">
            <a href="<%= contextPath %>/news?action=new" 
               style="background: #1e3a8a; color: white; padding: 12px 24px; text-decoration: none; border-radius: 8px; display: inline-block;">
                ➕ Add New News
            </a>
        </div>
    </section>

    <footer>
        © 2025 Student Club | Contact: info@studentclub.edu
    </footer>

    <script>
        console.log('Context Path: <%= contextPath %>');
    </script>
</body>
</html>