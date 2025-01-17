<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify Booking</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100%;
            background-color: #f4f4f4;
        }
        header {
            background-color: white;
            color: #000080;
            padding: 3px 0;
            text-align: center;
        }
        header nav a {
            margin: 0 15px;
            color: #5588BB;
            text-decoration: none;
            font-size: 16px;
        }
        header nav a:hover {
            text-decoration: underline;
        }
        nav {
            display: inline-flex;
        }
        .NavBar {
            display: flex;
            justify-content: space-evenly;
            align-items: center;
            padding: 0 10px;
        }
        .NavBar img {
            height: 44px;
        }
        .container {
            max-width: 400px;
            margin: 50px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        input {
            margin: 10px 0;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background-color: #6699CC;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #5588BB;
        }
        .message {
            margin-top: 20px;
            text-align: center;
        }
        footer {
            background-color: #6699CC;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            position: relative; 
            width: 100%;
            bottom: 0;
        }
    </style>
</head>
<body>
    <header>
        <div class="NavBar">
                <img src="Dakshayani.jpg" alt="D-Logo"/>
                <h2>Dakshayini's</h2>
            <nav>
                <a href="index.html">Home</a>
                <a href="BookTheRoom.html">Book</a>
                <a href="verfiy.jsp">Verify</a>
                <a href="about.html">AboutUs</a>
            </nav>
        </div>
    </header>
    <div class="container">
        <h2>Verify Booking</h2>
        <form method="post" action="verifyBooking.jsp">
            <input type="email" name="email" placeholder="Enter Email ID" required>
            <input type="text" name="mobile" placeholder="Enter Mobile Number" required pattern="\d{10}" title="Please enter a valid 10-digit mobile number">
            <button type="submit">Verify</button>
        </form>
        <div class="message">
            <% 
                String email = request.getParameter("email");
                String mobile = request.getParameter("mobile");

                if (email != null && mobile != null) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "password");

                        String query = "SELECT name,checkin_date, checkout_date, cost FROM bookings WHERE email = ? AND mobile = ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setString(1, email);
                        pstmt.setString(2, mobile);

                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            String checkinDate = rs.getString("checkin_date");
                            String checkoutDate = rs.getString("checkout_date");
                            double cost = rs.getDouble("cost");
                            
                            out.println("<p style='color: green;'>Booking verified successfully!</p>");
                            out.println("<p>Email Id:"+email+"</p>");
                            out.println("<p></p>");
                            out.println("<p>Mobile Number:"+mobile+"</p>");
                            out.println("<p>Check-in Date: " + checkinDate + "</p>");
                            out.println("<p>Check-out Date: " + checkoutDate + "</p>");
                            out.println("<p>Total Cost: $" + cost + "</p>");
                        } else {
                            out.println("<p style='color: red;'>No booking found with the provided details.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p style='color: red;'>An error occurred while verifying the booking.</p>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </div>
    </div>
    <footer align="center">Copy@Rights are Reserved for Dakshayani hotels<br>Privacy Policy</footer>
</body>
</html>