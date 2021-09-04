<!-- Developed By Gaurav Gandhi -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MVP Airline Reservation System</title>

</head>

<body>
	<%@ include file="Header.jsp"%>

<div class="container">
	<div class="jumbotron">
		
		<h2>Our Mission Statement</h2>
		
		<blockquote>
		<p>"To provide our owners and customers with customized and unique air transportation experiences trough and environment that fosters continuous improvement, 
                    teamwork and growth for our employees and profitability for the company"</p>
		</blockquote>
		
		<h3>Available Functionalities</h3>
		<ol>
		<li><a href="Theindex.jsp">Home</a></li>
				
				<li><a href="TheFlightDetails.jsp">Flight Details</a></li>
				
				<li><a href="TheAvailability.jsp">Availability</a></li>
				
				<li><a href="TheFareDetails.jsp">Fare Details</a></li>
				
				<li><a href="ThePassengerDetails.jsp">Passenger Details</a></li>
				
				<li><a href="TheLookup.jsp">Airport Lookup</a></li>
		</ol>
		
	</div>
	<div>
	
		
	</div>
</div>

	<%@ include file="TheFooter.jsp"%>
</body>
</html>