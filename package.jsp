<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<script>
    function searchPackages() {
        var query = document.getElementById("searchBox").value.trim().toLowerCase();

        $.ajax({
            url: "searchPackages.jsp",
            method: "GET",
            data: { search: query },
            success: function(response) {
                $("#packageResults").html(response); // Replace current results
            },
            error: function(xhr, status, error) {
                console.error("Error in AJAX request: ", error);
            }
        });
    }
</script>

<%! ResultSet rs; %>
<%
Statement st;
Connection con = null;
PreparedStatement pst = null;

try {
    // Retrieve userId from session
    Integer userId = (Integer) session.getAttribute("userid");
    if (userId == null) {
        out.println("<h3 style='color:red;'>Want To Explore Packages!Plaese Login Or Register!!.</h3>");
        return;
    }
    
    
  /*  String packid = request.getParameter("pid"); 
    session = request.getSession();
 
System.out.println("packageid in package file"+request.getParameter("pid"));
session.setAttribute("packid", packid);*/
  
// Retrieve package ID from session








    // Establish database connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");

    if (con != null) {
        System.out.println("✔ Database Connection Successful");
    }

    // Fetch packageId (pid) from the database for the logged-in user
     String pidQuery = "SELECT pid FROM package WHERE tid IN (SELECT tid FROM register WHERE uid=?) LIMIT 1";
    pst = con.prepareStatement(pidQuery);
    pst.setInt(1, userId);
    ResultSet pidResult = pst.executeQuery();

    String packageId = null;
    if (pidResult.next()) {
        packageId = pidResult.getString("pid");
        session.setAttribute("packageId", packageId); // ✅ Storing pid in session

        //System.out.println("✔ Stored packageId in session: " + packageId);
    }
    

    // Fetch package details using the stored pid
    String query = "SELECT * FROM package WHERE tid IN (SELECT tid FROM register WHERE uid=?)";
    pst = con.prepareStatement(query);
    pst.setInt(1, userId);

    rs = pst.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Packages</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
           /*background-image: url('gallery/river.jpg') no-repeat center;*/
            background-size: cover;
            color: white;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container { width: 100%; }
        .navbar { position: fixed; top: 0; width: 100%; z-index: 1000; }
        .navbar-brand img { height: 60px; width: 60px; border-radius: 50%; object-fit: cover; margin-right: 10px; }
        .content { margin-top: 80px; padding: 20px; flex: 1; }
        .footer { background-color: #343a40; color: white; text-align: center; padding: 15px; width: 100%; position: relative; bottom: 0; }
        .card { position: relative; height: 400px; margin: 10px; color: white; border: none; overflow: hidden; border-radius: 15px; }
        .card img { height: 100%; width: 100%; object-fit: cover; transition: transform 0.5s ease; }
        .card:hover img { transform: scale(1.1); }
        .card .card-img-overlay { background: rgba(0, 0, 0, 0.2); transition: background 0.5s ease; }
        .card:hover .card-img-overlay { background: rgba(0, 0, 0, 0.7); }
        .card-title { font-size: 1.5rem; font-weight: bold; }
        .card-text { font-size: 1rem; }
        .btn-primary { height:35px; background-color: black; border: none; }
        .btn-primary:hover { background-color:#dc3545; }
        /*.search-bar { margin-bottom: 5px; }*/
    </style>
</head>
<body>
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

    <!-- Content -->
    <div class="container content text-center">
        <h1>Current Packages</h1>

        <!-- Search Bar -->
        <div class="input-group mb-3">
            <input type="text" id="searchBox" class="form-control search-bar" placeholder="Search for destinations...">
            <button class="btn btn-primary" onclick="searchPackages()">Search</button>
        </div>

        <br>
        <div class="row mt-4" id="packageResults">
        <%
        boolean hasResults = false;
        while (rs.next()) {
            hasResults = true;
        %>
            <div class="col-md-4 package-card" data-name="<%= rs.getString(2).toLowerCase() %>">
                <div class="card">
                    <img src="gallery/<%= rs.getString("images") %>" alt="Package Image">
                    <div class="card-img-overlay d-flex flex-column justify-content-end">
                        <h5 class="card-title"><%= rs.getString(2) %></h5>
                        <i class="card-text"><b>Cost: <%= rs.getDouble(4) %></b></i>
                        <br>
                        <b class="card-text"><%= rs.getString("descrip") %></b>
                        <b style="font-size:25px;" class="card-text">No of Booking Left: <%= rs.getInt("no_left") %></b>                        
                        <a href="Destination.jsp?id=<%= rs.getInt(1) %>&cost=<%= rs.getDouble("cost") %>" class="btn btn-primary">See More</a>
                    </div>
                </div>
            </div>
        <% } 
        if (!hasResults) { %>
            <h3 style="color:red;">No packages found.</h3>
        <% } 
        con.close();
        } catch(Exception e) { e.printStackTrace(); } %>
        </div>
    </div>

    <script>
    function searchPackages() {
        var query = document.getElementById("searchBox").value.trim().toLowerCase();
        $(".package-card").each(function() {
            $(this).toggle($(this).data("name").includes(query));
        });
    }
    </script>

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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
    
</body>
</html>
