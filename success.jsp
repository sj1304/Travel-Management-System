<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
        }
        .container {
            text-align: center;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
        }
        .tick-mark {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: #4CAF50;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto;
            animation: popIn 0.5s ease-out;
        }
        .tick-mark:after {
            content: "✔";
            font-size: 50px;
            color: white;
        }
        @keyframes popIn {
            0% { transform: scale(0); opacity: 0; }
            50% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); }
        }
        .message {
            margin-top: 20px;
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }
        .redirect {
            margin-top: 15px;
            font-size: 14px;
            color: #777;
        }
    </style>
    <script>
        setTimeout(function() {
            window.location.href = "user_pack.jsp"; // Redirect after 3 seconds
        }, 3000);
    </script>
</head>
<body>
    <div class="container">
        <div class="tick-mark"></div>
        <div class="message">Payment Successful!</div>
        <div class="redirect">Redirecting you in 3 seconds...</div>
    </div>
</body>
</html>
