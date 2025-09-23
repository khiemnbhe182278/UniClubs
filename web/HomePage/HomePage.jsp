<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Club - Home Page</title>
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

.banner {
  background: url('banner.jpg') no-repeat center center/cover;
  height: 350px;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  text-align: center;
}

.banner::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(180deg, rgba(0, 0, 0, 0.5), rgba(30, 58, 138, 0.3));
}

.banner span {
  position: relative;
  color: #fef3c7;
  font-size: 42px;
  font-weight: 700;
  text-shadow: 3px 3px 10px rgba(0, 0, 0, 0.6);
  padding: 0 20px;
  animation: fadeIn 1.5s ease-in-out;
}

@keyframes fadeIn {
  0% { opacity: 0; transform: translateY(20px); }
  100% { opacity: 1; transform: translateY(0); }
}

section {
  padding: 40px;
  margin: 20px auto;
  width: 90%;
  max-width: 1200px;
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

.news, .events {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 25px;
}

.card {
  border-radius: 12px;
  overflow: hidden;
  background: #ffffff;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
  transform: translateY(-8px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.card img {
  width: 100%;
  height: 180px;
  object-fit: cover;
}

.card .content {
  padding: 20px;
}

.card h3 {
  font-size: 20px;
  color: #2563eb;
  margin-bottom: 10px;
  font-weight: 600;
}

.card p {
  font-size: 15px;
  color: #475569;
  margin-bottom: 10px;
}

.card a {
  display: inline-block;
  font-size: 15px;
  color: #1e3a8a;
  font-weight: 600;
  text-decoration: none;
  transition: color 0.3s ease;
}

.card a:hover {
  color: #f43f5e;
}

.quick-access {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  text-align: center;
}

.quick-access div {
  padding: 25px;
  background: linear-gradient(135deg, #dbeafe, #fef3c7);
  border-radius: 12px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: transform 0.3s ease, background 0.3s ease;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
}

.quick-access div:hover {
  background: linear-gradient(135deg, #bfdbfe, #facc15);
  transform: translateY(-6px);
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

/* Responsive Design */
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

  .banner {
    height: 250px;
  }

  .banner span {
    font-size: 30px;
  }

  section {
    padding: 20px;
    width: 95%;
  }

  h2 {
    font-size: 24px;
  }

  .card img {
    height: 150px;
  }

  .quick-access div {
    padding: 20px;
    font-size: 14px;
  }
}

@media (max-width: 480px) {
  .banner span {
    font-size: 24px;
  }

  .card h3 {
    font-size: 18px;
  }

  .card p {
    font-size: 14px;
  }

  .quick-access {
    grid-template-columns: 1fr;
  }
}

  </style>
  
</head>
<body>
  <header>
    <h1>Student Club</h1>
    <nav>
      <a href="home">Home</a>
      <a href="news">News</a>
      <a href="users">Register Club</a>
      <a href="members">Members</a>
      <a href="about.jsp">About</a>
      <a href="contact.jsp">Contact</a>
      <a href="login.jsp">Login</a>
    </nav>
  </header>

<div class="banner">
    <img src="../image/tải xuống.jpg" alt="Club Banner" style="width:100%; height:350px; object-fit:cover; border-radius: 0;">
</div>

  <section>
    <h2>Latest News</h2>
    <div class="news">
      <c:forEach var="n" items="${newsList}">
        <div class="card">
          <img src="${n.image}" alt="${n.title}">
          <div class="content">
            <h3>${n.title}</h3>
            <p>Date: ${n.date}</p>
            <a href="#">Read More</a>
          </div>
        </div>
      </c:forEach>
    </div>
  </section>

  <section>
    <h2>Upcoming Events</h2>
    <div class="events">
      <c:forEach var="e" items="${eventList}">
        <div class="card">
          <div class="content">
            <h3>${e.title}</h3>
            <p>Date: ${e.date}</p>
            <p>Location: ${e.location}</p>
            <a href="#">Join Now</a>
          </div>
        </div>
      </c:forEach>
    </div>
  </section>

  <section>
    <h2>Quick Access</h2>
    <div class="quick-access">
      <div>📄 Register Now</div>
      <div>📰 View All News</div>
      <div>👥 Meet Our Members</div>
      <div>📧 Contact</div>
    </div>
  </section>

  <footer>
    © 2025 Student Club | Address: University ABC, Campus 1 | Phone: +84-xxx-xxx-xxx <br>
    Follow us:
    <a href="#">Facebook</a> |
    <a href="#">Instagram</a> |
    <a href="#">YouTube</a>
  </footer>
</body>
</html>
