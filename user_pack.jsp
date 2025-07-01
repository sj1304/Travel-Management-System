<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*"%>

<%


int uid=0;
Connection con = null;
Statement st = null;
ResultSet rs = null;
PreparedStatement ps;
try {
	
Object temp=session.getAttribute("userid");
if(temp!=null)
{
uid=Integer.parseInt(temp.toString());	
}


    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
    
String query="select * from package where pid in(select pid from booking where uid=? and status='paid')";
    // Fetch ENUM values for 'type' column
    ps = con.prepareStatement(query);
    ps.setInt(1,uid);
    rs = ps.executeQuery();

    
%>
<html>
<head>

<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booked Packages</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 200vh;
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
        h2 {
            color: #333;
            margin-bottom: 0px;
             margin-top: 200px;
        }
        .container {
            width: 80%;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
              
            
        }
        .container {
    flex: 1; /* Pushes the footer to the bottom */
  
}

.card img {filter:opacity(0.4); position: absolute;height: 80%; width: 86%; object-fit: cover; transition: transform 0.5s ease; }
        .card:hover img { transform: scale(1.1); }

        .card {
        
            background: #fff;
            width: 300px;
            height:200px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .card h3 {
         z-index:1;
            margin-bottom: 10px;
            color: black;
        }
        .card p {
         z-index:1;
            margin: 5px 0;
            color: black;
        }
        .cost {
        z-index:1;
            font-size: 18px;
            font-weight: bold;
            color: black;
        }
        .no-data {
            color: red;
            font-weight: bold;
            margin-top: 10px;
        }
         .footer {
             
    bottom: 0;
    left: 0;
    width: 100%;
    background-color: #333;
    color: white;
    text-align: center;
    padding: 10px 0;
   
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img src="gallery/logo.png" alt="Logo"> <!-- Replace "logo.png" with your actual logo -->
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
    <h2>Booked Packages</h2>
    <div class="container">
    
        <%

            while(rs.next()) {
    
        %>
                    <div class="card">
                    <img src="gallery/refund.jpg" alt="stamp Image">
                        <h3><%=rs.getString("pack_name") %></h3> <!-- Package Name -->
                        <p class="cost">Cost: ₹<%=rs.getDouble("cost") %></p> <!-- Package Cost -->
                        
                    </div>
        <%
            }
}catch(Exception e){}
            
     
        %>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>
