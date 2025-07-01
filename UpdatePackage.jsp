<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String packageId = request.getParameter("package_id");
    String packageName = request.getParameter("pack_name");
    String cost = request.getParameter("cost");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
    PreparedStatement ps = con.prepareStatement("SELECT cost_distribution FROM destination WHERE pid=?");
    ps.setInt(1, Integer.parseInt(packageId));
    ResultSet rs = ps.executeQuery();
    String costDistribution = "";
    if (rs.next()) {
        costDistribution = rs.getString("cost_distribution");
    }
    con.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Package</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2>Update Package Details</h2>
    <form action="UpdatePackageServlet" method="post">
        <input type="hidden" name="package_id" value="<%= packageId %>">
        <div class="form-group">
            <label>Package Name:</label>
            <input type="text" class="form-control" value="<%= packageName %>" readonly>
        </div>
        <div class="form-group">
            <label>Cost:</label>
            <input type="number" name="cost" class="form-control" value="<%= cost %>" required>
        </div>
        <div class="form-group">
            <label>Cost Distribution:</label>
            <textarea name="cost_distribution" class="form-control" required><%= costDistribution %></textarea>
        </div>
        <button type="submit" class="btn btn-success">Update Package</button>
    </form>
</body>
</html>
