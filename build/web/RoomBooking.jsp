<%@page import="java.text.ParseException"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%  
    String RoomNo = request.getParameter("roomId");
    String Checkin = request.getParameter("checkin");
    String Checkout = request.getParameter("checkout");
    String Cost = request.getParameter("cost");

    Date checkinDate = null;
    Date checkoutDate = null;
    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
    try {
        if (Checkin != null && !Checkin.isEmpty()) {
            checkinDate = inputFormat.parse(Checkin);
        } else {
            throw new IllegalArgumentException("Checkin date is null or empty");
        }

        if (Checkout != null && !Checkout.isEmpty()) {
            checkoutDate = inputFormat.parse(Checkout);
        } else {
            throw new IllegalArgumentException("CheckOut date is null or empty");
        }
    } catch (ParseException e) {
        e.printStackTrace();
    } catch (IllegalArgumentException e) {
        e.printStackTrace();
    }


%>
<!DOCTYPE html>
<html>
<head>
    <title>Dakshayini Hotels</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            height: 100%;
        }
        .NavBar {
            display: flex;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 30px;
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
        main {
            text-align: center;
            margin: 20px auto;
            max-width: 400px;
            padding: 20px;
            background-color: #f0f0f0;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        dl {
            text-align: left;
            margin: 0 auto;
            display: inline-block;
        }
        button {
            padding: 7px 9px;
            font-size: 16px;
            background-color: #6699CC;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type=text],[type=email],[type=number]{
                                    width: 50%;
                                    padding: 3px 5px;
                                    margin: 8px 0;
                                    box-sizing: border-box;
                        }
    </style>
</head>
<body>
<header>
    <div class="NavBar">
        <img src="Dakshayani.jpg" width="70" height="65" alt="D-Logo"/><br>
        <h1>Dakshayini Hotels</h1>
    </div>
</header>
<main>
    <section>
        <form action="BookDB" method="post">
            <dl>
                <h2><label><strong>Registration Form:</strong></label></h2>
                <dt><strong>Guest Details</strong></dt>
                <dd style="padding:9px;">
                    <label>Customer Name:</label>
                    <input type="text" id="Cname" name="Cname" required/><br><br>
                    <label>Mobile No:</label>
                    <input type="number" id="PhNo" name="PhNo" required/><br><br>
                    <label>Email Id:</label>
                    <input type="email" id="CMail" name="CMail" required/><br><br>
                </dd>
                <dt><strong>Booking Details</strong></dt>
                <dd style="padding:9px;">
                    <label>Check In Date: <%= checkinDate != null ? new SimpleDateFormat("yyyy-MM-dd").format(checkinDate) : Checkin %></label>
                    <input type="hidden" id="CheckinDate" name="CheckinDate" value="<%= checkinDate != null ? new SimpleDateFormat("yyyy-MM-dd").format(checkinDate) : "" %>" readonly/><br><br>
                    <label>Check Out Date: <%= checkoutDate != null ? new SimpleDateFormat("yyyy-MM-dd").format(checkoutDate) :  Checkout %></label>
                    <input type="hidden" id="checkoutDate" name="checkoutDate" value="<%= checkoutDate != null ? new SimpleDateFormat("yyyy-MM-dd").format(checkoutDate) : "" %>" readonly/><br><br>
                    <label>Room No: <%= RoomNo %></label>
                    <input type="hidden" id="RNo" name="RNo" value="<%= RoomNo %>" required/>
                </dd>
                <dt><strong>Payment Information</strong></dt>
                <dd style="padding:9px;">
                    <label>Cost (INC all Taxes): <%= Cost %></label>
                    <input type="hidden" id="Cost" name="Cost" value="<%= Cost %>" readonly/><br><br>
                    <label>Payment Type:</label>
                    <select id="Ptype" name="PType" required>
                        <option value=""></option>
                        <option value="UPI">UPI</option>
                        <option value="Credit">Credit Card</option>
                        <option value="Debit">Debit Card</option>
                    </select><br><br>
                    <label>Pay:</label>
                    <input type="number" id="payment" name="payment" required/><br><br>
                </dd>
                <center><button type="submit">Book</button></center><br>
            </dl>
        </form>
        <a href="index.html">Back to Home</a>
    </section>
</main>
<footer>Copy@Rights are Reserved for Sairaj</footer>
</body>
</html>
