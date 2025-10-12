<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Event</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            /* Keep the same CSS as createEvent.jsp */
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');
            
            :root {
                --primary-color: #4A90E2;
                --secondary-color: #50E3C2;
                --text-color: #333;
                --bg-color: #F8F9FA;
                --card-bg-color: #fff;
                --border-color: #E0E0E0;
                --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            body {
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 40px;
                background-color: var(--bg-color);
                color: var(--text-color);
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .form-container {
                width: 100%;
                max-width: 500px;
                background-color: var(--card-bg-color);
                padding: 30px;
                border-radius: 15px;
                box-shadow: var(--shadow);
                transition: transform 0.3s ease;
            }

            .form-container:hover {
                transform: translateY(-5px);
            }

            .form-header {
                text-align: center;
                margin-bottom: 25px;
                position: relative;
            }

            .form-header h2 {
                color: var(--primary-color);
                font-weight: 600;
                font-size: 1.8rem;
                margin: 0;
                position: relative;
                padding-bottom: 10px;
            }

            .form-header h2::after {
                content: '';
                display: block;
                width: 50px;
                height: 3px;
                background-color: var(--secondary-color);
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: 600;
                margin-bottom: 8px;
                font-size: 0.95rem;
            }

            .input-group {
                position: relative;
            }

            .input-group i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--primary-color);
            }

            input, textarea {
                width: 100%;
                padding: 12px 12px 12px 40px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 1rem;
                color: var(--text-color);
                transition: border-color 0.3s ease;
                box-sizing: border-box;
            }

            input:focus, textarea:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.2);
            }
            
            textarea {
                padding-left: 12px;
                min-height: 100px;
            }
            
            #description.textarea-with-icon {
                padding-left: 40px;
            }

            .error-message {
                color: #e74c3c;
                font-size: 0.85rem;
                margin-top: 5px;
                display: none;
            }

            .form-actions {
                margin-top: 30px;
            }

            button {
                width: 100%;
                padding: 14px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            button:hover {
                background-color: #3876C4;
                transform: translateY(-2px);
            }
            
            .message-box {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 8px;
                font-weight: 600;
                text-align: center;
                transition: opacity 0.5s ease;
            }
            
            .success-message {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            
            .error-message-box {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
        </style>
    </head>
    <body>
        <%
            // Lấy thông tin Event từ request scope
            model.Event event = (model.Event) request.getAttribute("event");
            if (event == null) {
                // Handle case where no event data is found, maybe redirect
                response.sendRedirect("listEvents?error=Event+not+found");
                return;
            }
        %>
        
        <div class="form-container">
            <div class="form-header">
                <h2>Update Event</h2>
            </div>
            
            <%-- Display messages --%>
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
            %>
            <% if (errorMessage != null) { %>
                <div class="message-box error-message-box">
                    <%= errorMessage %>
                </div>
            <% } %>
            
            <form id="eventForm" action="updateEvent" method="post">
                
                <input type="hidden" name="eventID" value="<%= event.getEventID() %>">

                <div class="form-group">
                    <label for="eventName">Event Name</label>
                    <div class="input-group">
                        <i class="fas fa-bullhorn"></i>
                        <input type="text" id="eventName" name="eventName" required value="<%= event.getEventName() %>">
                    </div>
                    <span class="error-message" id="eventNameError">Event Name cannot be empty.</span>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" rows="4" required><%= event.getDescription() %></textarea>
                    <span class="error-message" id="descriptionError">Description cannot be empty.</span>
                </div>

                <div class="form-group">
                    <label for="eventDate">Event Date</label>
                    <div class="input-group">
                        <i class="fas fa-calendar-alt"></i>
                        <input type="date" id="eventDate" name="eventDate" required value="<%= event.getEventDate().toString().substring(0, 10) %>">
                    </div>
                    <span class="error-message" id="eventDateError">Please select a valid date.</span>
                </div>

                <div class="form-actions">
                    <button type="submit">Update Event</button>
                </div>
            </form>
        </div>

        <script>
            // Keep the same JavaScript validation as createEvent.jsp
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.getElementById('eventForm');
                const eventNameInput = document.getElementById('eventName');
                const descriptionInput = document.getElementById('description');
                const eventDateInput = document.getElementById('eventDate');

                form.addEventListener('submit', function(event) {
                    let isValid = true;
                    
                    if (eventNameInput.value.trim() === '') {
                        document.getElementById('eventNameError').style.display = 'block';
                        isValid = false;
                    } else {
                        document.getElementById('eventNameError').style.display = 'none';
                    }

                    if (descriptionInput.value.trim() === '') {
                        document.getElementById('descriptionError').style.display = 'block';
                        isValid = false;
                    } else {
                        document.getElementById('descriptionError').style.display = 'none';
                    }
                    
                    const selectedDate = new Date(eventDateInput.value);
                    const today = new Date();
                    today.setHours(0, 0, 0, 0); 
                    
                    if (eventDateInput.value === '' || selectedDate < today) {
                        document.getElementById('eventDateError').style.display = 'block';
                        isValid = false;
                    } else {
                        document.getElementById('eventDateError').style.display = 'none';
                    }

                    if (!isValid) {
                        event.preventDefault(); 
                    }
                });
            });
        </script>
    </body>
</html>