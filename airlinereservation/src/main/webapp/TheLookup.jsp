<%@page import="java.sql.*"%>

<%
	Class.forName("com.mysql.jdbc.Driver");
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airport Lookup</title>
</head>
<body>
	<%@ include file="Header.jsp"%>
	<div class="container">
		<%!public class AirportLookup {
//		String url = "jdbc:mysql://sql6.freemysqlhosting.net/airlinedb?useSSL=false&serverTimezone=UTC";
//              String url = "sql6.freemysqlhosting.net";
//		String username = "root";
//		String password = "waruna@12345";
                String url = "jdbc:mysql://sql6.freemysqlhosting.net/sql6442423?useSSL=false&serverTimezone=UTC";
		String username = "sql6442423";
		String password = "L2ZUb1llsF";
		Connection conn = null;
		PreparedStatement selectFlights = null;
		ResultSet res = null;

		public AirportLookup(String search_term) {
			try {
				conn = DriverManager.getConnection(url, username, password);
				String query="select * from airport where airport_code='"+search_term+"' OR city LIKE '%"+search_term+"%' OR name like '%"+search_term+"%'OR state like '%"+search_term+"%'";
				selectFlights = conn.prepareStatement(query,  ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		public ResultSet getDetails() {
			try {
				res = selectFlights.executeQuery();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return res;
		}
	}%>
		<h4>Airport Lookup</h4><br>
		<form class="form-inline" method="get" action="TheLookup.jsp">
			<div class="form-group">
				<label for="textFlightNumber">Airport Code / City / Name / State: </label> <input
					type="text" class="form-control" id="textFlightNumber"
					name="textSearchTerm" list="flightlist"
					placeholder="Search Term" required maxlength="30"
					minlength="2" pattern="[A-z ]*"
					oninvalid="setCustomValidity('Enter character search term')"
					oninput="setCustomValidity('')">
			</div>
			<button type="submit" class="btn btn-primary" id="searchairport">Lookup
				Airport</button>
		</form>
		<br>
		<%
			if (request.getParameter("textSearchTerm") == null)
				return;
			AirportLookup a = new AirportLookup(
					request.getParameter("textSearchTerm"));
			ResultSet r = a.getDetails();
			if (r.first() == false) {
		%>
		<div class="alert alert-warning animated pulse" role="alert">
			Details are not available</div>
		<%
			return;
			} else {
				r.beforeFirst();
			}
		%>
		<div class="alert alert-info animated fadeIn" role="alert">
			Details for term <strong><%=request.getParameter("textSearchTerm")%></strong>
			are as below
		</div>
		<table class="table table-hover table-bordered animated fadeIn">
			<tr>
				<th>Airport Code</th>
				<th>City</th>
				<th>Name</th>
				<th>State</th>
			</tr>
			<%
				while (r.next()) {
			%>
			<tr>
				<td><%=r.getString("airport_code")%></td>
				<td><%=r.getString("city")%></td>
				<td><%=r.getString("name")%></td>
				<td><%=r.getString("state")%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
	
	</body>
</html>