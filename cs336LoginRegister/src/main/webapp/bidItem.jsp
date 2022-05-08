<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336LoginRegister.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>bidItem</title>
</head>
<body>

<%
try {
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	//Get parameters from the HTML form at the buyItem.jsp
	String bid_price = request.getParameter("bid_price");
	String auto_bid_price = request.getParameter("auto_bid_price");
	String max_auto_bid = request.getParameter("max_auto_bid");
	String item_id = request.getParameter("bid");
	
	String query1 = "SELECT username from bid_history where item_id = ?";
	PreparedStatement ps1 = con.prepareStatement(query1);
	ps1.setString(1, item_id);
	ResultSet rs1 = ps1.executeQuery();
	//Check if user has already placed a bid by querying bid_history
	//if yes then check if users bid is over taken
	//else
	
	String query = "SELECT MAX(bid_price) from bid_history group by item_id having (item_id = ?)";	
	PreparedStatement ps = con.prepareStatement(query);
	ps.setString(1, item_id);
	ResultSet rs = ps.executeQuery();
	rs.next();
	out.print(rs);
	if(Double.parseDouble(bid_price) < Double.parseDouble(rs.getString("MAX(bid_price)"))){
		out.println("Bid too low");
		out.println("<br>");
		out.println("<a href = BuyPage.jsp>Try Again</a>");
	}
	/**
		if (rs1.next() == false) {
		out.print("You are the first to place a BID !");
		//first bid 
		String insertItemUpdate = "INSERT INTO bid_history(bid_id, username, bid_price, auto_bid_price, item_id, max_auto_bid)"
				+ "VALUES()";

	} else { 
		do { 
			out.print(rs.getString("username"));
		}while(rs1.next());
	}
	*/
			
	
	//after bid has been placed autoincrement bids
}
catch (Exception ex) {
	out.print(ex);
	out.print("Insert failed :()");
}

%>

</body>
</html>