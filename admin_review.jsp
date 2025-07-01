<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    // Ensure the admin is logged in
    Integer adminId = (Integer) session.getAttribute("admin_id");
    String role = (String) session.getAttribute("role");

    if (adminId == null || role == null || !role.equals("admin")) {
        response.sendRedirect("user_login.jsp"); // Redirect if not logged in
        return;
    }

    // Database Connection
    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
        String sql = "SELECT * FROM review";  // Fetch all reviews
        pst = con.prepareStatement(sql);
        rs = pst.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Reviews</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Manage Reviews</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Review ID</th>
                    <th>Profile</th>
                    <th>Rating</th>
                    <th>Feedback</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("rid") %></td>
                    <td><%= rs.getString("profile") %></td>
                    <td><%= rs.getInt("rating") %></td>
                    <td><%= rs.getString("feedback") %></td>
                    <td>
                        <form action="DeleteReviewServlet" method="post">
                            <input type="hidden" name="rid" value="<%= rs.getInt("rid") %>">
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this review?')">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <a href="Admin.html" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>
