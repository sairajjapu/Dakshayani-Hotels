<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dakshayini.Hotels</title>
        <style>
                         body {
                            font-family: Arial, sans-serif;
                            height: 100%;
			}
			.NavBar {
				display:flex;
				box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			}
			h1 {
					font-size:30px;
			}
                        footer {
				background-color: #6699CC;
				color: #fff;
				text-align: center;
				padding: 10px 0;
                                position: absolute;
				width: 100%;
				bottom: 0;
			}
                        section{
				background-color: #fff;
				padding: 10px;
				margin: 10px 0;
				border-radius: 5px;  
			}
                         .message {
                               color: green;
                                font-weight: bold;
                                margin-top: 20px;
                        }
        </style>
    </head>
    <body>
        <header class="NavBar">
		<image src="Dakshayani.jpg" width="70" height="65" alt="D-Logo"/><br>
		<h1>akshayini Hotels</h1>
	</header>
        <main>
            <section><center>
                <h1>Booking Confirmed</h1>
                <p>Your booking has been confirmed.<strong> Thank you for choosing our hotel!</strong></p>
                <div class="message">
<%
    String cname = request.getParameter("Cname");
    String roomNo = request.getParameter("RNo");
    if (cname != null && !cname.isEmpty() && roomNo != null && !roomNo.isEmpty()) {
        out.print("Thank you, " + cname + "! Your room number is " + roomNo + ".");
      } else {
        out.print("Thank you for your booking!");
      }
%>
                </div>
                <a href="index.html">Return to Home Page</a>
                </center>
            </section>
        </main>
        <footer>Copy@Rights are Reserved for Sairaj</footer>
    </body>
</html>
