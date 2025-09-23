<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Club" %>
<%@ page import="dal.ClubSimpleDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register Club - Student Club</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
  <!-- Giữ nguyên CSS từ register.jsp -->
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
  max-width: 600px;
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
  text-align: center;
}

form {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

label {
  font-size: 16px;
  font-weight: 500;
  color: #1e3a8a;
}

input[type="text"],
input[type="email"],
input[type="tel"],
input[type="file"],
select,
textarea {
  width: 100%;
  padding: 12px;
  font-size: 15px;
  border: 2px solid #bfdbfe;
  border-radius: 8px;
  background: #f8fafc;
  transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

input[type="text"]:focus,
input[type="email"]:focus,
input[type="tel"]:focus,
input[type="file"]:focus,
select:focus,
textarea:focus {
  border-color: #60a5fa;
  box-shadow: 0 0 8px rgba(96, 165, 250, 0.3);
  outline: none;
}

select {
  appearance: none;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 24 24"><path fill="%231e3a8a" d="M7 10l5 5 5-5z"/></svg>');
  background-repeat: no-repeat;
  background-position: right 12px center;
  padding-right: 30px;
}

textarea {
  resize: vertical;
  min-height: 80px;
  font-family: 'Poppins', sans-serif;
}

button[type="submit"] {
  padding: 12px;
  font-size: 16px;
  font-weight: 600;
  color: #ffffff;
  background: linear-gradient(90deg, #1e3a8a, #60a5fa);
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background 0.3s ease, transform 0.3s ease;
}

button[type="submit"]:hover {
  background: linear-gradient(90deg, #2563eb, #93c5fd);
  transform: translateY(-2px);
}

button[type="submit"]:active {
  transform: translateY(0);
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

  section {
    padding: 20px;
    width: 95%;
  }

  h2 {
    font-size: 24px;
  }
}

@media (max-width: 480px) {
  h2 {
    font-size: 20px;
  }

  input[type="text"],
  input[type="email"],
  input[type="tel"],
  input[type="file"],
  select,
  textarea,
  button[type="submit"] {
    font-size: 14px;
    padding: 10px;
  }
}
  </style>
</head>
<body>
  <header>
    <h1>Student Club</h1>
    <nav>
      <a href="<%=request.getContextPath()%>/index.jsp">Home</a>
      <a href="<%=request.getContextPath()%>/news.jsp">News</a>
        <a href="users">Register Club</a>
      <a href="<%=request.getContextPath()%>/users">Members</a>
      <a href="<%=request.getContextPath()%>/about.jsp">About</a>
      <a href="<%=request.getContextPath()%>/contact.jsp">Contact</a>
      <a href="<%=request.getContextPath()%>/login.jsp">Login</a>
    </nav>
  </header>

  <section>
    <h2>Register for a Club</h2>
    
    <form method="post" action="<%=request.getContextPath()%>/club-registration">
      <input type="hidden" name="action" value="insert"/>



      <label for="clubID">Select Club:</label>
      <select name="clubID" id="clubID" required>
        <option value="">-- Choose a club to register --</option>
        <%
            ClubSimpleDAO dao = new ClubSimpleDAO();
            List<Club> clubs = dao.getAllClubs();
            
            if (clubs != null && !clubs.isEmpty()) {
                for (Club c : clubs) {
        %>
            <option value="<%= c.getClubID() %>">
                <%= c.getClubName() %>

            </option>
        <%
                }
            } else {
        %>
            <option value="">-- No clubs available --</option>
        <%
            }
        %>
      </select>

      <label for="notes">Additional Information (Optional):</label>
      <textarea name="notes" id="notes" rows="3" placeholder="Tell us why you want to join this club..."></textarea>

      <button type="submit">Submit Registration</button>
    </form>

    <!-- Debug info -->
    <div style="margin-top: 20px; padding: 10px; background: #f8f9fa; border-radius: 5px; font-size: 14px;">
      <strong>Debug Info:</strong><br>
      Number of clubs: <%= clubs != null ? clubs.size() : "null" %><br>
      <%
        if (clubs != null && !clubs.isEmpty()) {
          out.println("Clubs found: ");
          for (Club c : clubs) {
            out.println(c.getClubID() + " - " + c.getClubName() + "; ");
          }
        }
      %>
    </div>

    <%
      String error = request.getParameter("error");
      if (error != null) {
    %>
      <p style="color:red; margin-top:15px; text-align:center;">❌ Registration failed. Please check your information and try again.</p>
    <%
      }
      
      String success = request.getParameter("success");
      if ("insert".equals(success)) {
    %>
      <p style="color:green; margin-top:15px; text-align:center;">✅ Registration submitted successfully!</p>
    <%
      }
    %>
  </section>

  <footer>
    © 2025 Student Club | Contact: info@studentclub.edu
  </footer>
</body>
</html>