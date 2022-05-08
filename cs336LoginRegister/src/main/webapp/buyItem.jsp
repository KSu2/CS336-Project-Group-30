<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336LoginRegister.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>buyItem</title>
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
	String item_type = request.getParameter("item_type");
	String max_price = request.getParameter("max_price");
	
	//before query check if all auction close_date's are set for a later time otherwise delete them
	//query all parts of the designated type that are < max_price and then return a new buyPage with links to these available items
	LocalDate ld = LocalDate.now();
	LocalDateTime startOfDay = ld.atStartOfDay();
	LocalDateTime startOfNextDay = ld.plusDays( 1 ).atStartOfDay();
	
	String query = "SELECT * FROM items WHERE  category = ? and initial_price < ? and auction_close > ?";
	PreparedStatement ps1 = con.prepareStatement(query);
	ps1.setString(1,item_type);
	ps1.setString(2,max_price);
	ps1.setObject(3,startOfDay);
	ResultSet rs = ps1.executeQuery();
	
	if (rs.next() == false) {
		out.print("No item found for given parameters");
	} else { 
		do { 
			out.print("Item name: " + rs.getString("item_name") + " ");
			out.print("Starting price: " + rs.getString("initial_price"));
			out.print("<form method = get action = bidItem.jsp>");
			out.print("<table>");
			out.print("<tr>");
			out.print("<td>Bid Price</td><td><input type=text name=bid_price></td>");
			out.print("<td>Auto Bid Price</td><td><input type=text name=auto_bid_price></td>");
			out.print("<td>Max Auto Bid Price</td><td><input type=text name=max_auto_bid></td>");
			out.print("</table>");
			out.print("<button type=submit name=item_id value=" + rs.getString("item_id") + ">Bid</button>");
			out.print("</form>");
			out.print("<br>");
		}
		while (rs.next());
		}

	
	
}
catch (Exception ex) {
	out.print(ex);
	out.print("Insert failed :()");
}

%>

</body>
</html>