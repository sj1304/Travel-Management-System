<%@ page import="java.sql.*" %>
<%
    String pid = request.getParameter("pid");
    if (pid == null || pid.isEmpty()) {
        out.println("<h3 class='text-danger'>Invalid Package ID</h3>");
        return;
    }
%>
<html>
<head>
    <title>Add Destination</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin-top: 15px;
            padding: 10px;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add Destination</h2>
        <form action="AddDestinationServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="pid" value="<%= pid %>">
            
            <label>Destination Name:</label>
            <input type="text" name="dname" required>
            
            <label>Highlight:</label>
            <input type="text" name="highlight" required>
            
            <label>Days:</label>
            <input type="text" name="days" required>
            
            <label>Day Plan:</label>
            <textarea name="day_plan" required></textarea>
            
             <label>Path:</label>
            <textarea name="path" required></textarea>
            <!-- <label>Destination Image:</label>
            <input type="file" name="destination_image" required> -->
            
            <label>Cost Distribution:</label>
            <input type="text" name="cost_distribution" required>
            
            <label>Hotel:</label>
            <input type="text" name="hotel" required>
            
            <input type="submit" value="Add Destination">
        </form>
    </div>
</body>
</html>
