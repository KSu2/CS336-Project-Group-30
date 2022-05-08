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

<%!
public String insertBid(ApplicationDB db, Connection con, HttpSession session, HttpServletRequest request) {
	String response = "";
	try{
		
		// Set data based on end-user input data
		String username = (String)session.getAttribute("user");
		double bidPrice = Double.parseDouble(request.getParameter("bid_price"));
		double autoBidPrice = Double.parseDouble(request.getParameter("auto_bid_price"));
		int itemId = Integer.parseInt(request.getParameter("item_id"));
		double maxAutoBid = Double.parseDouble(request.getParameter("max_auto_bid"));
		
		// Update bid of the user has already created one for this item
		String bidCheckQuery = "SELECT * FROM bid_history "
			+ "WHERE username = ? AND item_id = ?";
		PreparedStatement preparedBidCheckQuery = con.prepareStatement(bidCheckQuery);
		preparedBidCheckQuery.setString(1, username);
		preparedBidCheckQuery.setInt(2, itemId);
		
		ResultSet bidCheckQueryResult = preparedBidCheckQuery.executeQuery();
		
		if(bidCheckQueryResult.next()) {
			String bidUpdate = "UPDATE bid_history "
				+ "SET bid_price = ?, auto_bid_price = ?, max_auto_bid = ? "
				+ "WHERE username = ? AND item_id = ?";

			PreparedStatement preparedBidUpdate = con.prepareStatement(bidUpdate);
			preparedBidUpdate.setDouble(1, bidPrice);
			preparedBidUpdate.setDouble(2, autoBidPrice);
			preparedBidUpdate.setDouble(3, maxAutoBid);
			preparedBidUpdate.setString(4, username);
			preparedBidUpdate.setInt(5, itemId);
			
			int result = preparedBidUpdate.executeUpdate();
			
			if(result == 1) {				
				response = "Updated prior bid on this item";
			} else {
				response = "Something may have gone wrong with the bid update";
			}
		} else {
		
			// Figure out what the new bid's id should be
			String getMaxBidIdQuery = "SELECT MAX(bid_id) bid_id FROM bid_history";
			PreparedStatement preparedGetMaxBidIdQuery = con.prepareStatement(getMaxBidIdQuery);
			
			ResultSet getMaxBidIdQueryResult = preparedGetMaxBidIdQuery.executeQuery();
			
			getMaxBidIdQueryResult.next();
			int bidId = Integer.parseInt(getMaxBidIdQueryResult.getString("bid_id")) + 1;
			
			// Create the insert statement
			String insertBidUpdate = "INSERT INTO bid_history(bid_id, username, bid_price, auto_bid_price, item_id, max_auto_bid)"
					+ "VALUES(?, ?, ?, ?, ?, ?)";
			PreparedStatement preparedUpdate = con.prepareStatement(insertBidUpdate);
			preparedUpdate.setInt(1, bidId);
			preparedUpdate.setString(2, username);
			preparedUpdate.setDouble(3, bidPrice);
			preparedUpdate.setDouble(4, autoBidPrice);
			preparedUpdate.setInt(5, itemId);
			preparedUpdate.setDouble(6, maxAutoBid);
			
			// Execute the update statement
			int updateResult = preparedUpdate.executeUpdate();
			
			if(updateResult == 1) {			
				response = "Successfully bid on item";
			} else {
				response = "Potentially failed to add item to auction list";
			}
			
			// Close connections
			preparedGetMaxBidIdQuery.close();
			preparedUpdate.close();
		}
		
		// Close connections
		preparedBidCheckQuery.close();
		
	} catch(Exception ex) {
		response = ex + " Insert failed :()";
	}
	
	return response;
}
%>

<%
try {
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	//Get parameters from the HTML form at the buyItem.jsp
	String itemId = request.getParameter("item_id");
	Double bidPrice = Double.parseDouble(request.getParameter("bid_price"));
	
	String query1 = "SELECT username from bid_history where item_id = ?";
	PreparedStatement ps1 = con.prepareStatement(query1);
	ps1.setString(1, itemId);
	ResultSet rs1 = ps1.executeQuery();
	
	//Check if user has already placed a bid by querying bid_history
	//if yes then check if users bid is over taken
	//else
	
	String query = "SELECT MAX(bid_price) from bid_history group by item_id having (item_id = ?)";	
	PreparedStatement ps = con.prepareStatement(query);
	ps.setString(1, itemId);
	ResultSet rs = ps.executeQuery();	
	
	if(!rs.next()) {
		// Insert bid if there are no other bids
		out.println(insertBid(db, con, session, request));
	} else {
		// Only add bid if it's price greater than the current max bid
		if(bidPrice > Double.parseDouble(rs.getString("MAX(bid_price)"))) {
			out.println(insertBid(db, con, session, request));
		} else {
			out.println("Bid was too low. Could not add it.");
		}
	}
	
	ps.close();
	stmt.close();
	con.close();
			
	
	//after bid has been placed autoincrement bids
}
catch (Exception ex) {
	out.print(ex + " ");
	out.print("Insert failed :()");
}

%>

</body>
</html>