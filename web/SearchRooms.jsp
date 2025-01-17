<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.ParseException"%>
<%@page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
        .featured-rooms {
            background-color: #fff;
            margin: 20px 0;
            border-radius: 7px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }
        .room {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            margin: 10px;
            text-align: center;
        }
        .room h3 {
            color: #333;
        }
        .room p {
            margin: 10px 0;
            color: #666;
        }
        .room img {
            max-width: 60%;
            height: auto;
            border-radius: 5px;
            cursor: pointer;
        }
        footer {
            background-color: #6699CC;
            color: #fff;
            text-align: center;
            position: relative;
            padding: 10px 0;
            width: 100%;
            bottom: 0;
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
<%
    String url = "jdbc:mysql://localhost:3306/hotel_db";
    String driver = "com.mysql.cj.jdbc.Driver";
    String user = "root";
    String password = "password";
        
    Connection con = null;
    PreparedStatement st = null;
    ResultSet rs = null;
        
    String checkin = request.getParameter("checkInDate");
    String checkout = request.getParameter("checkOutDate");  
        
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
    Date CheckinDate = null;
    Date CheckoutDate = null;
        
    List<Integer> availableRooms = new ArrayList<>();
    String[] imgSource = {"Room1.jfif", "Room2.jfif", "Room3.jfif", "Room4.jfif", "images 9.jfif"};
        
    try {
        CheckinDate = dateFormat.parse(checkin);
        CheckoutDate = dateFormat.parse(checkout);
            
        String query = "SELECT RoonNo FROM dakshayani WHERE (CheckInDate BETWEEN ? AND ?) OR (CheckOutDate BETWEEN ? AND ?) OR (? <= CheckInDate AND ? >= CheckOutDate)";
        Class.forName(driver);
        con = DriverManager.getConnection(url, user, password);
        st = con.prepareStatement(query);
        st.setDate(1, new java.sql.Date(CheckinDate.getTime()));
        st.setDate(2, new java.sql.Date(CheckoutDate.getTime()));
        st.setDate(3, new java.sql.Date(CheckinDate.getTime()));
        st.setDate(4, new java.sql.Date(CheckoutDate.getTime()));
        st.setDate(5, new java.sql.Date(CheckinDate.getTime()));
        st.setDate(6, new java.sql.Date(CheckoutDate.getTime()));
            
        rs = st.executeQuery();
            
        if (rs.next()) {
            // There are booked rooms for the specified dates
            do {
                int bookedRoomNo = rs.getInt("RoomNo");
                for (int i = 1; i <= imgSource.length; i++) {
                    if (i != bookedRoomNo && !availableRooms.contains(i)) {
                        availableRooms.add(i);
                    }
                }
            } while (rs.next());
        } else {
            // No booked rooms for the specified dates, show all rooms
            for (int i = 1; i <= imgSource.length; i++) {
                availableRooms.add(i);
            }
        }
            
    } catch (Exception e) {
        // Log the exception for debugging
        e.printStackTrace();
        // Redirect to an error page or display a user-friendly message
        response.sendRedirect("BookingFailed.jsp?error="+e);
    } finally {
        try {
            if (rs != null) rs.close();
            if (st != null) st.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
    <main>
        <section class="intro" align="center">
            <h2>Traditional & Luxury Experience</h2>
            <p>Book your stay at our exclusive hotel.</p>
        <% if (availableRooms.isEmpty()) { %>
                <div>
                    <strong><p style="color:red;">Sorry! Rooms Are Already Booked</p></strong>
                </div>
        <% } else { %>
                <strong><p>Available from <em style="color:blueviolet;"><%= checkin %> to <%= checkout %></em></p></strong>
        <% } %>
        </section>
        <section class="featured-rooms">
            <h2>High Featured Rooms</h2><br>
            <% for (int i : availableRooms) { %>
                <div class="room">
                    <form action="RoomBooking.jsp" method="post">
                        <input type="hidden" name="roomId" value="<%= i %>">
                        <button type="submit" style="border: none; background: none; cursor: pointer;">
                            <img src="<%= imgSource[i - 1] %>" alt="Room">
                        </button>
                        <input type="hidden" name="checkin" id="checkin" value="<%= checkin %>" required/>
                        <input type="hidden" name="checkout" id="checkout" value="<%= checkout %>" required/>
                        <h3>Room-<%= i %></h3>
                        <input type="hidden" name="cost" value="Rs.500 per night">
                        <p>Rs.500 per night</p>
                    </form>
                </div>
            <% } %>
            <center>
            <a href="index.html">Return to Home Page</a>
        </center>
        </section>
    </main>
    <footer>Copy@Rights are Reserved for Sairaj</footer>
</body>
</html>
