<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<%
    Connection con = null;
    PreparedStatement pstmt = null, pstmt1 = null;
    ResultSet rs = null, rs1 = null;
    String image1 = "default.jpg"; // Default image if no image is found
 
String gn=null,gm=null,gc=null,gd=null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
        String pack_id=request.getParameter("id");
        Integer packageId = Integer.parseInt(pack_id);
   System.out.println(" packageId found in session of desti."+ packageId);
   session.setAttribute("packageId",packageId);
   System.out.println("dest pid="+packageId);
   double cost=Double.parseDouble(request.getParameter("cost"));
  session.setAttribute("cost",cost);
  
        // ✅ Fetch image from package table
        String imageQuery = "SELECT images,guide_name,guide_contact,guide_email,guide_desc FROM package WHERE pid = ?";
        pstmt1 = con.prepareStatement(imageQuery);
        pstmt1.setInt(1, packageId);
        rs1 = pstmt1.executeQuery();
        if (rs1.next()) {
            image1 = rs1.getString("images"); // Fetching the first image
            gn=rs1.getString("guide_name");
            gc=rs1.getString("guide_contact");
            gm=rs1.getString("guide_email");
            gd=rs1.getString("guide_desc");
        }

        // ✅ Fetch destination details based on the selected package
        String query = "SELECT * FROM destination WHERE pid = ?";
        pstmt = con.prepareStatement(query);
        pstmt.setInt(1, packageId);
        rs = pstmt.executeQuery();

        boolean hasData = false;

        while (rs.next()) {
            hasData = true;
            String dname = rs.getString("dname");
            String highlight = rs.getString("highlight");
            String days = rs.getString("days");
            String dayPlan = rs.getString("day_plan");
            String path = rs.getString("path");
            String description = rs.getString("description");
            String costDistribution = rs.getString("cost_distribution");
            String hotel = rs.getString("hotel");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= dname %> - Details</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body { background-color: #f8f9fa; color: #333; }
        .destination-banner {
            background-image: url('gallery/<%= image1 %>'); 
            height: 300px; background-size: cover; 
            background-position: center; display: flex; 
            align-items: center; justify-content: center; 
            text-align: center; color: white; font-size: 2rem; 
            font-weight: bold;
        }
        .footer 
        {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 15px;
            width: 100%;
            
        }
                .breadcrumb-container 
                { padding: 10px; background: #e9ecef; border-radius: 5px; }
    </style>
</head>
<body>

<!-- Destination Banner -->
<div class="destination-banner">
    <%= dname %>
</div>
<!-- Breadcrumb -->
<div class="container breadcrumb-container mt-3">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="package.jsp">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page"><%= dname %></li>
        </ol>
    </nav>
</div>

<div class="container">
    <h2>Overview</h2>
    <p><%= description %></p>

    <h4>Path</h4>
    <p><%= path.replace("?", " - ") %></p>

    <h4>Highlights</h4>
    <p><%= highlight %></p>

    <h5>Duration: <%= days %> days</h5>

    <h4>Itinerary</h4>
    <div>
        <%
            if (dayPlan != null && !dayPlan.trim().isEmpty()) {
                String[] dayPlans = dayPlan.split("(?=Day \\d+:)");
                for (String plan : dayPlans) {
                    if (!plan.trim().isEmpty()) {
                        String[] parts = plan.split(":", 2);
                        String dayTitle = parts[0].trim();
                        String dayDetails = (parts.length > 1) ? parts[1].trim() : "";
        %>
            <div>
                <h5><%= dayTitle %></h5>
                <p> <%= dayDetails %></p>
            </div>
        <%
                    }
                }
            } else {
        %>
            <p>No itinerary available.</p>
        <%
            }
        %>
    </div>

    <h4>Cost Breakdown</h4>
    <div>
        <%
            if (costDistribution != null && !costDistribution.isEmpty()) {
                String[] costItems = costDistribution.split(",");
                for (String item : costItems) {
                    String[] parts = item.split(":");
                    if (parts.length == 2) {
        %>
                        <p><%= parts[0] %>: ₹<%= parts[1] %></p>
        <%
                    }
                }
            } else {
        %>
            <p>No cost details available.</p>
        <%
            }
        %>
    </div>
 <div>
             <h5>Guide Information</h5>
            <h6>Guide Name: <%= gn %></h6><br>
            <h6>About Guide<br> <%= gd %></h6><br>
            <h6>Guide Phone no: <%= gc %></h6><br>
            <h6>Guide Email: <%= gm %></h6><br>
            
            </div>
    <h4>Hotel Details</h4>
    <%
        if (hotel != null && !hotel.trim().isEmpty()) {
            String[] hotelDetails = hotel.split("\\|", 2);
            String hotelName = hotelDetails[0].trim();
            String hotelLink = (hotelDetails.length > 1) ? hotelDetails[1].trim() : "#";
            if (!hotelLink.startsWith("http")) {
                hotelLink = "#";
            }
    %>
        <p><strong><%= hotelName %></strong></p>
        <p>
            <a href="<%= hotelLink %>" target="_blank">
                🔗 Click Here to Visit Hotel Website
            </a>
        </p>
    <%
        } else {
    %>
        <p>No hotel details available.</p>
    <%
        }
    %>

<!-- <a href="Booking.jsp?pid=<%= packageId %>" class="btn btn-primary" style="margin-top:-10px;background-color: #dc3545; border: none;">Book Now</a>-->
 <a href="Booking.jsp" class="btn btn-primary" style="margin-top:-10px;background-color: #dc3545; border: none;">Book Now</a>

    
</div>
<br>

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
</body>
</html>

<%
        }

        if (!hasData) {
            out.println("<p style='color:red;'>⚠ No destinations found for this package.</p>");
        }

    } catch (Exception e) {
        out.println("<p style='color:red;'>⚠ Error occurred: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (rs1 != null) try { rs1.close(); } catch (SQLException e) {}
        if (pstmt1 != null) try { pstmt1.close(); } catch (SQLException e) {}
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
    } 
%>
