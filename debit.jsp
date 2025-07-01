 <%--    <%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
--%>
<!--  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Gateway</title>
    
  
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            font-style: italic;
        }

        body {
            margin: 10px;
            font-family: Arial, sans-serif;
        }

        .payment {
            background-color:rgba(185, 196, 185, 0.726);
            max-width: 360px;
            margin: 80px auto;
            height: auto;
            padding: 35px;
            padding-top: 70px;
            border-radius: 5px;
            position: relative;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .payment h2 {
            text-align: center;
            letter-spacing: 2px;
            margin-bottom: 40px;
            color: black;
        }

        .form .label {
            display: block;
            color: black;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .form .input-container {
            position: relative;
            width: 100%;
        }

        .form .icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: gray;
            font-size: 16px;
        }

        .form .input {
            padding: 12px 12px 12px 40px;
            width: 100%;
            border-radius: 5px;
            outline: none;
            font-size: 16px;
            border: 1px solid gray;
            color: black;
            background: white;
        }

        .form .input::placeholder {
            color: lightgray;
        }

        .card-grp {
            display: flex;
            gap: 10px;
        }

        .card-item {
            flex: 1;
        }

        .space {
            margin-bottom: 20px;
        }

        .button input {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            background-color: #ff5722;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        .button input:hover {
            background-color: #e64a19;
        }
    </style>
</head>
<body>
<form method="get" action="debitServlet">
    <div class="wrapper">
        <div class="payment">
            <h2>Payment Gateway</h2>
            <div class="form">

            
                <div class="card space icon-relative">
                    <label class="label">Card Holder:</label>
                    <div class="input-container">
                        <i class="fa-solid fa-user icon"></i>
                        <input type="text" name="card_holder" class="input" placeholder="John Doe">
                    </div>
                </div>

                <div class="card space icon-relative">
                    <label class="label">Card Number:</label>
                    <div class="input-container">
                        <i class="fa-solid fa-credit-card icon"></i>
                        <input type="text" name="card_number" class="input" placeholder="1234 5678 9101 1121">
                    </div>
                </div>

          
                <div class="card-grp space">
                    <div class="card-item">
                        <label class="label">Expire Date:</label>
                        <div class="input-container">
                            <i class="fa-solid fa-calendar icon"></i>
                            <input type="text" id="expire_date" name="expire_date" class="input" placeholder="MM/YY" maxlength="5">
                        </div>
                    </div>
                    
                    <div class="card-item">
                        <label class="label">CVC:</label>
                        <div class="input-container">
                            <i class="fa-solid fa-lock icon"></i>
                            <input type="text" name="CVC" class="input" placeholder="000" maxlength="3">
                        </div>
                    </div>
                </div> 

               
                <div class="button">
                    <input type="submit" value="Pay: <%=session.getAttribute("cost")%>">
                </div>

            </div>
        </div>
    </div>
    
    </form>
</body>
</html>

-->


<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Gateway</title>
    
    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            font-style: italic;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 150vh;
        }

        .payment {
            background-color: white;
            max-width: 400px;
            margin: auto;
            padding: 40px;
            border-radius: 8px;
            position: relative;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border: 2px solid #dc3545;
        }

        .payment h2 {
            text-align: center;
            letter-spacing: 2px;
            margin-bottom: 30px;
            color: black;
        }

        .form .label {
            display: block;
            color: black;
            margin-bottom: 6px;
            font-weight: bold;
        }

        .form .input-container {
            position: relative;
            width: 100%;
        }

        .form .icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #dc3545;
            font-size: 16px;
        }

        .form .input {
            padding: 12px 12px 12px 40px;
            width: 100%;
            border-radius: 5px;
            outline: none;
            font-size: 16px;
            border: 1px solid #dc3545;
            color: black;
            background: white;
        }

        .form .input::placeholder {
            color: gray;
        }

        .card-grp {
            display: flex;
            gap: 10px;
        }

        .card-item {
            flex: 1;
        }

        .space {
            margin-bottom: 20px;
        }

        .button input {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            background-color: #dc3545;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        .button input:hover {
            background-color: black;
        }
        .navbar {
            background: rgba(31, 45, 36, 0.9);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            height: 80px;
            padding: 5px 20px;
        }

        .navbar-brand {
            font-size: 24px;
            display: flex;
            align-items: center;
        }

        .navbar-brand img {
            height: 40px;
            width: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
        }

        .navbar-nav .nav-link {
            font-size: 14px;
            padding: 5px 10px;
        }
      
    </style>
</head>
<body>
 <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img src="gallery/logo.png" alt="Logo">
                <span><i style="color:#4d739d;">J</i>ourney<i style="color:#4d739d;">G</i>enie</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="http://localhost:8082/siddhi/front.html">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="http://localhost:8082/siddhi/package.jsp">Packages</a></li>
                    <li class="nav-item"><a class="nav-link" href="http://localhost:8082/siddhi/review.jsp">Review</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contactus">Contact Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="http://localhost:8082/siddhi/review.jsp">Review</a></li>
                </ul>
                <a style="padding-left:20px; padding-top:10px; height:50px; width:100px;" href="user_pack.jsp">
                    <i class="fa-solid fa-circle-user fa-2x" style="color:white; filter:opacity(0.7);"></i>
                   </a>
                <a href="LogoutServlet" class="btn btn-danger ms-3 btn-sm">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>
    </nav>
    <br>
<form method="get" action="debitServlet">
    <div class="payment">
        <h2>Payment Gateway</h2>
        <div class="form">

            <!-- Card Holder -->
            <div class="card space icon-relative">
                <label class="label">Card Holder:</label>
                <div class="input-container">
                    <i class="fa-solid fa-user icon"></i>
                    <input type="text" name="card_holder" class="input" placeholder="John Doe">
                </div>
            </div>

            <!-- Card Number -->
            <div class="card space icon-relative">
                <label class="label">Card Number:</label>
                <div class="input-container">
                    <i class="fa-solid fa-credit-card icon"></i>
                    <input type="text" name="card_number" class="input" placeholder="1234 5678 9101 1121">
                </div>
            </div>

            <!-- Expiry Date & CVC -->
            <div class="card-grp space">
                <div class="card-item">
                    <label class="label">Expire Date:</label>
                    <div class="input-container">
                        <i class="fa-solid fa-calendar icon"></i>
                        <input type="text" id="expire_date" name="expire_date" class="input" placeholder="MM/YY" maxlength="5">
                    </div>
                </div>
                
                <div class="card-item">
                    <label class="label">CVC:</label>
                    <div class="input-container">
                        <i class="fa-solid fa-lock icon"></i>
                        <input type="text" name="CVC" class="input" placeholder="000" maxlength="3">
                    </div>
                </div>
            </div> 

            <!-- Pay Button -->
            <div class="button">
                <input type="submit" value="Pay: <%=session.getAttribute("cost")%>">
            </div>
        </div>
    </div>
    
</form>
 
</body>
</html>
