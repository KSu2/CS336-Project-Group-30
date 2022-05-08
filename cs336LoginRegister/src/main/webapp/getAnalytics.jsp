<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336LoginRegister.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>getAnalytics</title>
</head>
<body>
<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the LoginPage.jsp
		String query_type = request.getParameter("query_type");
		if(query_type.equals("TotalEarnings")){
			String query = "SELECT sum(price) from auction_history";
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
		      while(rs.next()){
		          String total = rs.getString(1);
		          out.println("Total Earnings of all sales: " + total);
		          out.println("<br>");
		      } 
		}
		
		else if(query_type.equals("EarningsPer")){
			String type = request.getParameter("selectPerType");
			String query = "SELECT "+type+", sum(price) from auction_history group by "+type;
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()){
				out.println("Earnings of " + type + " " + rs.getString(1) + ": " + rs.getString(2) + "\n");
				out.println("<br>");
			}
		}
		
		else{
			
			String type = request.getParameter("selectSellType");
			String query = "SELECT " +type+",MAX(y.num) FROM (SELECT "+type+",COUNT(*) AS num FROM auction_history group by " +type+") y"; //THIS QUERY WORKS IN MYSQL NOT SURE WHY IT DOESN't WORK HERE
			PreparedStatement ps = con.prepareStatement(query);	
			ResultSet rs = ps.executeQuery();
			while(rs.next()){			
				out.println("Best selling " + type + ": " + rs.getString(1));
				out.println("<br>");
			}
		}
        stmt.close();
        con.close();
	}catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
%>
</body>
</html>