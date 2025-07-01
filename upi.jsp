<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UPI Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .container {
        background-color: white;
        max-width: 460px;
        height: auto;
        width: 100%;
        padding: 35px;
        border-radius: 5px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        text-align: center;
border:1px solid red;
    }

    h1 {
        margin: 0 0 20px 0;
    }

    input[type="radio"], input[type="text"], input[type="button"] {
        margin: 10px 0;
    }

    .hidden {
        display: none;
    }
</style>
</head>
<body>
<form method="get" action="upiServlet">
    <div class="container">
        <h1>Select an UPI App:</h1>
        
        <!-- Radio buttons -->
        <div id="upiSelection">
            <input type="radio" name="app" value="GPay"> GPay<br><br>
            <input type="radio" name="app" value="Paytm"> Paytm<br><br>
            <input type="radio" name="app" value="PhonePe"> PhonePe<br><br>
            <input type="button" style="background-color:#dc3545;"  value="Next" onclick="showPaymentForm()">
        </div>

        <!-- Payment validation form -->
        <div id="paymentForm" class="hidden">
            <h2>Enter Payment Details:</h2>
            <input type="text" name="upi_mob" id="paymentDetails" placeholder="Enter UPI ID or Mobile Number"><br><br>
            <input type="submit" style="background-color:#dc3545;"  value="Proceed Payment: <%=session.getAttribute("cost")%>" onclick="processPayment()">
            <input type="button" style="background-color:#dc3545;" value="Back" onclick="goBack()">
        </div>
    </div>

    <script>
        function showPaymentForm() {
            let paymentOptions = document.getElementsByName("app");
            let selectedValue = "";

            for (let i = 0; i < paymentOptions.length; i++) {
                if (paymentOptions[i].checked) {
                    selectedValue = paymentOptions[i].value;
                    break;
                }
            }

            if (selectedValue) {
                document.getElementById("upiSelection").classList.add("hidden");
                document.getElementById("paymentForm").classList.remove("hidden");
            } else {
                alert("Please select a UPI app before proceeding.");
            }
        }

        function processPayment() {
            let details = document.getElementById("paymentDetails").value;
            if (details.trim() === "") {
                alert("Please enter your UPI ID or Mobile Number.");
            } else {
          //  	window.location.href="upiServlet";
                //alert("Payment processed successfully!");
                // Add payment logic or redirection here if needed
            }
        }

        function goBack() {
            document.getElementById("upiSelection").classList.remove("hidden");
            document.getElementById("paymentForm").classList.add("hidden");
        }
    </script>
    </form>
</body>
</html>
