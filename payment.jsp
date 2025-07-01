
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Selection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: white;
            font-family: 'Poppins', sans-serif;
            padding: 20px;
            flex-direction: column;
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
            height: 60px; /* Adjust size as needed */
            width: 60px;
            border-radius: 50%; /* Makes the logo circular */
            object-fit: cover;
            margin-right: 10px;
        }
        .navbar-nav .nav-link {
            font-size: 14px;
            padding: 5px 10px;
        }

        .container {
            background: white;
            max-width: 420px;
            width: 100%;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            text-align: center;
            border: 2px solid #dc3545;
            margin-top: 70px;
        }

        .payment-option {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            padding: 12px;
            border-radius: 8px;
            background-color: #f8d7da;
            margin: 10px 0;
            cursor: pointer;
            transition: background 0.3s ease;
            font-size: 16px;
            border: 1px solid #dc3545;
            color: black;
        }

        .payment-option:hover {
            background-color: #f5c6cb;
        }

        .payment-option input {
            margin-right: 10px;
        }

        .payment-option i {
            margin-right: 10px;
            font-size: 18px;
            color: #dc3545;
        }

        .btn-next {
            margin-top: 20px;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: 6px;
            background-color: #dc3545;
            color: white;
            cursor: pointer;
            transition: background 0.3s;
            width: 100%;
        }

        .btn-next:hover {
            background-color: #bb2d3b;
        }
    </style>
    <script>
        function redirectToPage() {
            let paymentOptions = document.getElementsByName("pay");
            let selectedValue = "";
            
            for (let i = 0; i < paymentOptions.length; i++) {
                if (paymentOptions[i].checked) {
                    selectedValue = paymentOptions[i].value;
                    break;
                }
            }

            if (selectedValue === "1") {
                window.location.href = "debit.jsp";
            } else if (selectedValue === "2") {
                window.location.href = "credit.jsp";
            } else if (selectedValue === "3") {
                window.location.href = "upi.jsp";
            } else {
                alert("Please select a payment mode before proceeding.");
            }
        }
    </script>
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
    <div class="container">
        <h1>Select Payment Mode</h1>
        <label class="payment-option">
            <input type="radio" name="pay" value="1"> <i class="fas fa-credit-card"></i> Debit Card
        </label>
        <label class="payment-option">
            <input type="radio" name="pay" value="2"> <i class="fas fa-credit-card"></i> Credit Card
        </label>
        <label class="payment-option">
            <input type="radio" name="pay" value="3"> <i class="fas fa-mobile-alt"></i> Other UPI Apps
        </label>
        <button class="btn-next" onclick="redirectToPage()">Next</button>
    </div>
</body>
</html>