

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Your Tour - Journey Genie</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <style>
      body {
            font-family: Arial, sans-serif;
            background: url('gallery/img1.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        body::before {
    content: "";
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: url('gallery/img2.jpg') no-repeat center center fixed;
    background-size: cover;
    filter: blur(2px); /* Adjust the blur intensity */
    z-index: -1;
}
        .booking-container {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 900px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin:15%;
            
        }
        h2 {
            text-align: center;
            color: black;
            width: 100%;
        }
        .form-group {
            
            margin: 5px;
        }
        label {
            font-weight: bold;
            display: block;
        }
        select, input {
            width: 90%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .full-width {
            flex: 1 1 50%;
        }
         html {
            scroll-behavior: smooth;
        }
        .navbar {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
        }

        .navbar-brand img {
            height: 60px; /* Adjust size as needed */
            width: 60px;
            border-radius: 50%; /* Makes the logo circular */
            object-fit: cover;
            margin-right: 10px;
        }
        button {
            width: 100%;
          background-color: rgba(0, 0, 0, 0.4);
            color: white;
            border: none;
            padding: 10px;
            margin-top: 15px;
            border-radius: 3px;
            
            font-size: 18px;
        }
        
        button:hover {
              background-color: rgba(0, 0, 0, 0.6);
        }
        @media (max-width: 800px) {
            .booking-container {
                flex-direction: column;
            }
            .form-group {
                width: 100%;
                margin:10px;
            }
        }
        
        form{
        display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between;
        }
    </style>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
    String pid = request.getParameter("pid");
%>  
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="gallery/logo.png" alt="Logo">
                <span style="font-size:30px;"><i style="color:#4d739d;">J</i>ourney<i style="color:#4d739d;">G</i>enie</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto d-flex flex-row">
                    <li class="nav-item mx-2"><a class="nav-link" href="http://localhost:8082/siddhi/front.html">Home</a></li>
                    <li class="nav-item mx-2"><a class="nav-link" href="http://localhost:8082/siddhi/package.jsp">Packages</a></li>
                    <li class="nav-item mx-2"><a class="nav-link" href="http://localhost:8082/siddhi/About_us.jsp">About Us</a></li>
                    <li class="nav-item mx-2"><a class="nav-link" href="contact.jsp">Contact Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="review.jsp">Review</a></li>
                </ul>
                <a style="padding-left:20px; padding-top:10px; height:50px; width:100px;" href="user_pack.jsp">
                    <i class="fa-solid fa-circle-user fa-2x" style="color:white; filter:opacity(0.7);"></i>
                </a>
                <a href="LogoutServlet" class="btn btn-danger ms-3">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>
    <div class="booking-container">
        <h2>Book Your Tour</h2>
        <form action="BookServlet" method="get">
            <input type="hidden" name="pid" value="<%= pid %>">
            <div class="form-group">
                <label for="departureDate">Departure Date:</label>
                <input type="date" id="departureDate" name="departureDate" required>
            </div>
            <div class="form-group">
                <label for="returnDate">Return Date:</label>
                <input type="date" id="returnDate" name="returnDate" required>
            </div>
            <div class="form-group">
                <label for="adults">Adults:</label>
                <input type="number" id="adults" name="adults" min="1" required>
            </div>
            <div class="form-group">
                <label for="children">Children:</label>
                <input type="number" id="children" name="children" min="0">
            </div>
           <!--   <button type="submit">Book Now</button>-->
<button type="submit">Proceed to Pay</button>           
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
