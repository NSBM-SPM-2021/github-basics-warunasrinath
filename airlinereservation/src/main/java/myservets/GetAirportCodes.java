package myservets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.sql.ResultSetMetaData;

/**
 * Servlet implementation class CustomerFlightDetails
 */
@WebServlet("/GetAirportCodes")
public class GetAirportCodes extends HttpServlet {
	private static final long serialVersionUID = 2L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetAirportCodes() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
     * @param req		String query="Select distinct airport_code, city from airport where airport_code like '%"+request.getParameter("airportcode")+"%'";
uest
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
        @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
                
//		String url = "jdbc:mysql://localhost:3305/airlinedb?useSSL=false&serverTimezone=UTC";
//		String username = "root";
//		String password = "waruna@12345";
                String url = "jdbc:mysql://sql6.freemysqlhosting.net/sql6442423?useSSL=false&serverTimezone=UTC";
		String username = "sql6442423";
		String password = "L2ZUb1llsF";
//                String url = "sql6.freemysqlhosting.net";
//		String username = "sql6442423";
//		String password = "L2ZUb1llsF";
            String query = null;
		log(query);
		Connection conn = null;
		//out.println(query);
		PreparedStatement stmt=null;
		ResultSet res = null;

		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, username, password);
			
			stmt=conn.prepareStatement(query);
		
			res=stmt.executeQuery();
			
		} catch (SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		JsonObject jsonResponse = new JsonObject();
		jsonResponse=ResultSet2JSONObject(res);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(new Gson().toJson(jsonResponse));
	}
	
	 public static final JsonObject ResultSet2JSONObject(ResultSet rs) {
         JsonObject element = null;
         JsonArray joa = new JsonArray();
         JsonObject jo = new JsonObject();
         int totalLength = 0;
         ResultSetMetaData rsmd = null;
         String columnName = null;
         String columnValue = null;
         try {
                 rsmd = (ResultSetMetaData) rs.getMetaData();
                 while (rs.next()) {
                         element = new JsonObject();
                         for (int i = 0; i < rsmd.getColumnCount(); i++) {
                                 columnName = rsmd.getColumnName(i+1);
                                 columnValue = rs.getString(columnName);
                                 element.addProperty(columnName, columnValue);
                         }
                         joa.add(element);
                         totalLength ++;
                 }
                 jo.addProperty("result", "success");
                 jo.addProperty("rows", totalLength);
                 jo.add("data", joa);
         } catch (SQLException e) {
                 jo.addProperty("result", "failure");
                 jo.addProperty("error", e.getMessage());
         }
         return jo;
 }
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
