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
                                position: relative;
				width: 100%;
				bottom: 0;
			}
                        section{
				background-color: #fff;
				padding: 10px;
				margin: 10px 0;
				border-radius: 5px;  
			}
                        .error {
                                color: red;
                                font-weight: bold;
                                margin-top: 20px;
                        }
        </style>
    </head>
    <body>
        <header class="NavBar">
		    <image src="Dakshayani.jpg" width="70" height="65" alt="D-Logo"/><br>
		    <h1>Dakshayini Hotels</h1>
	</header>
        <main>
            <section><center>
                <h1>Booking Failed</h1>
                <p>We are sorry, but your booking could not be processed. <strong>Please try again later!!</strong></p>
                <div class="error">
<%
    String error = request.getParameter("error");
    if (error != null && !error.isEmpty()) {
        out.print("Error: " + error);
    } else {
        out.print("Unknown error occurred.");
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
