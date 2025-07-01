<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Database Connection
    String jdbcUrl = "jdbc:mysql://localhost:3306/snehadb";
    String dbUser = "root";
    String dbPassword = "";
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
        String sql = "SELECT profile, feedback, rating FROM review"; 
        stmt = conn.prepareStatement(sql);
        rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Review Carousel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .carousel-item {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 400px; /* Adjust height as needed */
        }
        .card {
            width: 50%; /* Half page width */
            padding: 20px;
            text-align: center;
        }
        .rating {
            color: gold;
        }
    </style>
</head>
<body>

<div id="reviewCarousel" class="carousel slide" data-bs-ride="carousel">
    <div class="carousel-inner">
        <%
            boolean first = true;
            while (rs.next()) {
                String profile = rs.getString("profile");
                String feedback = rs.getString("feedback");
                int rating = rs.getInt("rating");
        %>
        <div class="carousel-item <%= first ? "active" : "" %>">
            <div class="card mx-auto">
                <img src="<%= profile %>" class="rounded-circle mx-auto" width="80" height="80">
                <h5 class="mt-3">User Review</h5>
                <p><%= feedback %></p>
                <div class="rating">
                    <% for (int i = 0; i < rating; i++) { %>
                        ★
                    <% } %>
                </div>
            </div>
        </div>
        <%
                first = false;
            }
        %>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#reviewCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#reviewCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
