<%@ page import="java.io.*,java.util.*,javax.servlet.*,javax.servlet.http.*,java.sql.*" %>

<%@ page contentType="text/html; charset=UTF-8" %>

<%
session.setAttribute("temp", "");

Connection con = null;
Statement st = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
    st = con.createStatement();

    // Fetch ENUM values for 'type' column
    rs = st.executeQuery("SELECT * FROM tour");

    // Capture selected value from the form submission
    String selectedTour = request.getParameter("tempValue");
    if (selectedTour != null) {
        session.setAttribute("temp", selectedTour);
        System.out.println("Selected Tour Type (JSP): " + selectedTour);
    }
%>

<%
HttpSession s = request.getSession(false); // Get existing session
String username = (s != null) ? (String) s.getAttribute("username") : null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Journey Genie</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            color: #EAEAEA;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background: rgba(31, 45, 36, 0.9);
        }

        .navbar-brand {
            font-size: 30px;
        }

        .navbar-brand img {
            height: 60px;
            width: 60px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
        }
        .search-bar {
            background: rgba(255, 255, 255, 0.2);
            padding: 10px;
            border-radius: 8px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
        }

        .search-bar select, .search-bar button {
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
        }

        .search-bar button {
            background: #A8C686;
            color: #2B3A2F;
            font-weight: bold;
        }

        .search-bar button:hover {
            background: #CDE4B0;
        }
        

        /* Background Slider */
        .slider {
            position: absolute;
            width: 100%;
            height: 100vh;
            overflow: hidden;
        }
        .slider img {
            position: absolute;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0;
            transition: opacity 1s ease-in-out;
        }
        .slider img.active {
            opacity: 1;
        }

        .hero {
            position: relative;
            background: rgba(0, 0, 0, 0.4);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 20px;
            min-height: 100vh;
            z-index: 1;
        }

        .hero h2 {
            font-size: 3em;
            margin-bottom: 20px;
            text-transform: uppercase;
        }

        .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 20px;
            width: 100%;
        }
    </style>
</head>
<body>

<!-- Background Image Slider -->
<div class="slider">
    <img src="gallery/img3.jpg" class="active" alt="Slide 1">
    <img src="gallery/img4.jpg" alt="Slide 2">
    <img src="gallery/img5.jpg" alt="Slide 3">
</div>

<form method="get" action="FindTour">

    <!-- Navbar -->
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
                    <li class="nav-item mx-2"><a class="nav-link" href="http://localhost:8082/siddhi/About_us.html">About Us</a></li>
                    <li class="nav-item mx-2"><a class="nav-link" href="#contactus">Contact Us</a></li>
                   <li class="nav-item"><a class="nav-link" href="http://localhost:8082/siddhi/review.jsp">Review</a></li>
               
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


    <!-- Hero Section -->
    <div class="hero">
        <h2>Welcome&nbsp;<%= username %></h2>
        <br>
        <div class="search-bar">
            <select id="tourCategory" name="tourType">
                <% while(rs.next()) { %>
                <option value="<%= rs.getString(2) %>"><%= rs.getString(2) %></option>
                <% } %>
            </select>

            <!-- Hidden field to store selected value -->
            <input type="hidden" id="hiddenTemp" name="tempValue">

            <button type="submit">Find Your Tours</button>
        </div>
    </div>


   <!-- About Us Section -->
    <div id="about"></div>

    <!-- Footer -->
    <footer id="contactus" class="footer">
        <p>&copy; 2025 JourneyGenie | All rights reserved</p>
        <b>Phone no</b><br>
        7385226044<br>
        9867896430<br>
        <b>Email</b><br>
        snehajadhav10573@gmail.com <br>
anushkashinde16661@gmail.com<br>           
    </footer>
</form>

<script>
    let images = document.querySelectorAll('.slider img');
    let index = 0;

    function changeSlide() {
        images[index].classList.remove('active');
        index = (index + 1) % images.length;
        images[index].classList.add('active');
    }
    setInterval(changeSlide, 5000); // Change slide every 5 seconds
</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>

</body>
</html>

<%
} catch(Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    try { if (st != null) st.close(); } catch (SQLException e) { e.printStackTrace(); }
    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
}
%>
