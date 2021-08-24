
<%@page import="java.sql.* "%>

<%
	Class.forName("com.mysql.jdbc.Driver");
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight Details</title>
<style type="text/css">
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$("#airportlist").html("");

		$("#textDepAirportCode, #textArrivalAirportCode").keyup(function() {
			$("#airportlist").html("");
			var text = $(this).val();
			text = "airportcode=" + text;
			$.ajax({
				type : "GET",
				url : "GetAirportCodes",
				dataType : 'json',
				data : text,
				contentType : 'application/json',
				mimeType : 'application/json',

				success : function(data, textStatus, jqXHR) {
					$("#airportlist").html("");
					if (data.data.length > 0) {
						var records = data.data;

						for ( var x in records) {
							var rec = records[x];

							$("#airportlist").append("<option value='" + rec.airport_code +"'></option>");
						}
					}
				},

				error : function(jqXHR, textStatus, errorThrown) {
					console.log("Something really bad happened " + textStatus);
				}

			});
		});

	});
</script>



</head>
<body>
	<%@ include file="Header.jsp"%>
	<div class="container">
		<%!public class Flight {
		String url = "jdbc:mysql://localhost:3306/airlinedb?useSSL=false&serverTimezone=UTC";
		String username = "root";
		String password = "";
		boolean data_available_flag = false;
		Connection conn = null;
		PreparedStatement selectFlights = null;
		PreparedStatement selectFlights_2 = null;
		PreparedStatement selectFlights_3 = null;

		int maxstops;
		String dep, arr;
		ResultSet[] res = new ResultSet[3];

		public Flight(String d, String a, String m) {
			try {

				maxstops = Integer.parseInt(m);
				conn = DriverManager.getConnection(url, username, password);
				dep = d;
				arr = a;
				String query_1stop = "select flight_number,departure_time,arrival_time,travel_date,airline,weekdays,TIMEDIFF(arrival_time,departure_time) AS total_journey from flight_instance natural join flight"
						+ " where departure_airport_code='"
						+ d
						+ "' AND arrival_airport_code='"
						+ a
						+ "' order by departure_time";
				selectFlights = conn.prepareStatement(query_1stop);

				if (maxstops > 1) {
					String query_2stop = "select f1.flight_number as f1_number,f1.departure_time AS f1_departure,f1.arrival_time AS f1_arrival,TIMEDIFF(f1.arrival_time,f1.departure_time) AS f1_time,f1.arrival_airport_code As via,"
							+ " f2.departure_time as f2_departure,f2.arrival_time as f2_arrival, TIMEDIFF(f2.arrival_time,f2.departure_time) AS f2_time,"
							+ " f2.flight_number as f2_number,f1.weekdays AS f1_weekdays,f2.weekdays AS f2_weekdays,"
							+ " TIMEDIFF(f2.arrival_time,f1.departure_time) AS total_journey"
							+ " from (select * from flight_instance natural join flight) f1, (select * from flight_instance natural join flight) f2"
							+ " where f1.departure_airport_code='"
							+ d
							+ "' AND f2.arrival_airport_code='"
							+ a
							+ "'"
							+ " AND f1.arrival_airport_code=f2.departure_airport_code"
							+ " AND TIMEDIFF(f2.departure_time,f1.arrival_time)>'00:59:59'";
					System.out.println(query_2stop);
					selectFlights_2 = conn.prepareStatement(query_2stop);
				}
				if (maxstops > 2) {

					String query_3stop = "select f1.flight_number as f1_number,f1.departure_time AS f1_dep,f1.arrival_time AS f1_arrival,TIMEDIFF(f1.arrival_time,f1.departure_time) AS f1_time,"
							+ " f1.arrival_airport_code As via_1,"
							+ " f2.departure_time as f2_dep,f2.arrival_time as f2_arrival, TIMEDIFF(f2.arrival_time,f2.departure_time) AS f2_time,"
							+ " f2.flight_number as f2_number,"
							+ " f2.arrival_airport_code As via_2,"
							+ " f3.flight_number as f3_number,f3.departure_time AS f3_dep,f3.arrival_time AS f3_arrival,TIMEDIFF(f3.arrival_time,f3.departure_time) AS f3_time,"
							+ " TIMEDIFF(f3.arrival_time,f1.departure_time) AS total_journey,"
							+ " f1.weekdays as f1_days, f2.weekdays as f2_days, f3.weekdays as f3_days"
							+ " from (select * from flight_instance natural join flight) f1, (select * from flight_instance natural join flight) f2,(select * from flight_instance natural join flight) f3"
							+ " where f1.departure_airport_code='"
							+ d
							+ "' AND f3.arrival_airport_code='"
							+ a
							+ "'"
							+ " AND f1.arrival_airport_code=f2.departure_airport_code"
							+ " AND f2.arrival_airport_code=f3.departure_airport_code"
							+ " AND TIMEDIFF(f2.departure_time,f1.arrival_time)>'00:59:59'"
							+ " AND TIMEDIFF(f3.departure_time,f2.arrival_time)>'00:59:59'"
							+ " AND NOT f1.arrival_airport_code='"
							+ a
							+ "'"
							+ " AND NOT f2.arrival_airport_code='"
							+ a
							+"'"
							+ " AND NOT f2.departure_airport_code='"
							+ d
							+ "'"
							+ " AND NOT f3.departure_airport_code='" + d + "'";

					System.out.println(query_3stop);
					selectFlights_3 = conn.prepareStatement(query_3stop);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		public ResultSet[] getFlights() {
			try {
				res[0] = selectFlights.executeQuery();
				if (maxstops > 1) {
					res[1] = selectFlights_2.executeQuery();
				}
				if (maxstops > 2) {
					res[2] = selectFlights_3.executeQuery();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
			return res;
		}

		public String getWeekdays(String s) {
			String weekdays = s;
			StringBuilder days = new StringBuilder("");

			if (weekdays.contains("Mon"))
				days.append(" Monday");
			if (weekdays.contains("Tue"))
				days.append(" Tuesday");
			if (weekdays.contains("Wed"))
				days.append(" Wednesday");
			if (weekdays.contains("Thu"))
				days.append(" Thursday");
			if (weekdays.contains("Fri"))
				days.append(" Friday");
			if (weekdays.contains("Sat"))
				days.append(" Saturday");
			if (weekdays.contains("Sun"))
				days.append(" Sunday");
			if (days.length() == 57)
				days.replace(0, 57, "All Days");

			return days.toString();
		}

	}%>
		<h4>Flight Details</h4>
		<br>
		<form class="form-inline" method="get" action="TheFlightDetails.jsp">
			<div class="form-group">
				<label for="textDepAirportCode">Departure Airport Code:- </label> <input
					type="text" class="form-control" id="textDepAirportCode"
					name="textDepAirportCode" placeholder="Type Departure Airport Code"
					required maxlength="3" list="airportlist" minlength="3"
					pattern="[A-z][A-z][A-z]"
					oninvalid="setCustomValidity('Min/Max Length: 3 characters. Please enter only characters e.g DFW')"
					oninput="setCustomValidity('')"> <label
					for="textArrivalAirportCode">&nbsp &nbsp Arrival Airport
					Code:-</label> <input type="text" class="form-control"
					id="textArrivalAirportCode" name="textArrivalAirportCode"
					placeholder="Type Arrival Airport Code" required maxlength="3"
					list="airportlist" minlength="3" pattern="[A-z][A-z][A-z]"
					oninvalid="setCustomValidity('Min/Max Length: 3 characters. Please enter only characters e.g DFW')"
					oninput="setCustomValidity('')"> &nbsp&nbsp<label>Maximum
					Stops:</label> <label class=".radio-inline"> <input type="radio"
					name="maxstops" id="maxstops1" value="1" checked> nonstop
				</label> <label class=".radio-inline"> <input type="radio"
					name="maxstops" id="maxstops2" value="2"> 1
				</label> <label class=".radio-inline"> <input type="radio"
					name="maxstops" id="maxstops3" value="3"> 2
				</label> <label class=".radio-inline"> <input type="radio"
					name="maxstops" id="maxstops4" value="4"> 3
				</label> &nbsp&nbsp

			</div>
			<button type="submit" class="btn btn-primary" id="searchflights"
				data-toggle="tooltip" data-placement="bottom"
				title="Tooltip on bottom">Search Flight Details</button>
		</form>

		<datalist id="airportlist" name="flightlist"> </datalist>
		<br>
//Comment start
		


	</div>
</body>
</html>


