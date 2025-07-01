<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Page</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f8f9fa;
        }
        .swiper-container {
            width: 80%;
            padding: 50px;
          position:relative;
        }
        .swiper-slide {
          
            justify-content: center;
            align-items: center;
            transition: transform 0.3s;
        }
        .swiper-slide-active {
            transform: scale(1.2);
        }
        .testimonial-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        .avatar img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
        }
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 30px;
        }

        /* Form Container */
        .form-container {
            background: white;
            text-align: center;
            width: 100%;
            height: 100%;
      
            
        }

        /* Profile Selection */
        .profile-selection {
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 20px;
            background: #94d5ed;
            border-radius: 10px;
            width: 97%;
            margin-bottom: 20px;
        }

        .profile-label {
            cursor: pointer;
            text-align: center;
        }

        .profile-img {
            width: 80px;
            height: 80px;
            padding: 10px;
            border-radius: 50%;
            background: white;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s, background 0.2s;
        }

        input[name="profile"]:checked + .profile-img {
            background: #e3f2fd;
            border: 2px solid #28a745;
            transform: scale(1.1);
        }

        /* New Container for Feedback and Rating */
        .feedback-rating-container { 
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 50%;
            margin: auto;
            border: 2px solid #94d5ed;
        }

        .suggestion-box {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }

        .feedback-emoji {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        textarea {
            width: 90%;
            height: 100px;
            padding: 10px;
            border-radius: 5px;
            resize: none;
            font-size: 14px;
            border: 3px solid #94d5ed;
        }

        /* Rating Section */
        .rating {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
            font-size: 18px;
        }

        .smiley {
            cursor: pointer;
            font-size: 30px;
            transition: transform 0.2s;
        }

        .smiley:hover {
            transform: scale(1.1);
        }

        input[type="radio"] {
            display: none;
        }

        label {
            display: flex;
            flex-direction: column;
            align-items: center;
            cursor: pointer;
        }

        .rating-text {
            margin-top: 5px;
            font-size: 12px;
            font-weight: bold;
        }

        input:checked + .smiley {
            filter: brightness(80%);
        }

        .submit-btn {
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #94d5ed;
            color: black;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
            border: none;
        }

        .submit-btn:hover {
            background-color: #94d5ed;
            transform: scale(1.05);
        }
       
  .display-review {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 50px;
padding-left:60px;
            margin-top: 20px;
        }
        .review-card {
            width: 30%;
            min-width: 250px;
        }
        .testimonial-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .avatar img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
        }
        .stars {
            color: gold;
            margin-bottom: 10px;
        }
        
</style>

    <script>
        function updateEmoji(value) {
            let emojiDisplay = document.getElementById("feedback-emoji");
            let emojiMap = {
                "1": "😭😭😭",
                "2": "😢😢",
                "3": "😐",
                "4": "😊😊",
                "5": "😁😁😁"
            };
            emojiDisplay.textContent = emojiMap[value] || "";
        }
    </script>
</head>
<body>

    <!-- Form Container -->
    <form action="reviewServlet" method="get" class="form-container">
        

        <!-- Profile Selection Inside Form -->
        <div class="profile-selection">
            <label class="profile-label">
                <input type="radio" name="profile" value="male" required>
                <img src="https://cdn-icons-png.flaticon.com/512/2922/2922510.png" class="profile-img" alt="Man Icon">
                <div>Male</div>
            </label>
            <label class="profile-label">
                <input type="radio" name="profile" value="female">
                <img src="https://cdn-icons-png.flaticon.com/512/2922/2922566.png" class="profile-img" alt="Woman Icon">
                <div>Female</div>
            </label>
        </div>

        <!-- New Feedback & Rating Container -->
        <div class="feedback-rating-container">
            <!-- Feedback Section -->
            <div class="suggestion-box">
        <h2>Give Us a Small Review Before Leaving...</h2>
                <div id="feedback-emoji" class="feedback-emoji"></div>
                <h3>Any Suggestions?</h3>
                <textarea name="feedback" placeholder="Write your feedback here..."></textarea>
            </div>

            <!-- Rating Section -->
            <div class="rating">
                <label>
                    <input type="radio" name="rating" value="1" onclick="updateEmoji(this.value)">
                    <span class="smiley">😡</span>
                    <span class="rating-text">Terrible</span>
                </label>
                <label>
                    <input type="radio" name="rating" value="2" onclick="updateEmoji(this.value)">
                    <span class="smiley">😞</span>
                    <span class="rating-text">Bad</span>
                </label>
                <label>
                    <input type="radio" name="rating" value="3" onclick="updateEmoji(this.value)">
                    <span class="smiley">😐</span>
                    <span class="rating-text">Okay</span>
                </label>
                <label>
                    <input type="radio" name="rating" value="4" onclick="updateEmoji(this.value)">
                    <span class="smiley">😊</span>
                    <span class="rating-text">Good</span>
                </label>
                <label>
                    <input type="radio" name="rating" value="5" onclick="updateEmoji(this.value)">
                    <span class="smiley">😁</span>
                    <span class="rating-text">Excellent</span>
                </label> 
                 </div>
          <!-- Submit Button -->
        <button type="submit" class="submit-btn">Submit</button>       
          
        </div>

        <h1 class="mb-4">To Watch Customers Reviews Please Scroll down :)</h1>
            <h2 class="mb-4 pb-2 mb-md-5 pb-md-0">See what our customers have to say about us.</h2>
    </form>
<div class="display-review">
            
            <% 
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/snehadb", "root", "");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT profile, feedback, rating FROM review");
                    
                    while (rs.next()) {
                        String profile = rs.getString("profile");
                        String feedback = rs.getString("feedback");
                        int rating = rs.getInt("rating");
                        String imageUrl = profile.equals("male") ? "https://cdn-icons-png.flaticon.com/512/2922/2922510.png" : "https://cdn-icons-png.flaticon.com/512/2922/2922566.png";
            %>
            <div class="review-card">
                <div class="card testimonial-card">
                    <div class="card-up" style="background-color: #7a81a8;"></div>
                    <div class="avatar mx-auto bg-white">
                        <img src="<%= imageUrl %>" class="rounded-circle img-fluid" style="width: 60px; height: 60px;" />
                    </div>
                    <div class="card-body">
                        <h4 class="mb-4"><%= profile %></h4>
                        <div class="stars">
                            <% for (int i = 1; i <= 5; i++) { %>
                                <% if (i <= rating) { %>
                                    <i class="fas fa-star"></i>
                                <% } else { %>
                                    <i class="far fa-star"></i>
                                <% } %>
                            <% } %>
                        </div>
                        <hr />
                        <p class="dark-grey-text mt-4">
                            <i class="fas fa-quote-left pe-2"></i><%= feedback %>
                        </p>
                    </div>
                </div>
            </div>
            <% 
                    }
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>

</body>
</html>
