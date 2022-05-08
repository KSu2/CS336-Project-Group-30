<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.sql.*, java.time.*"%>
<%@ page import="cs336LoginRegister.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try {
	// Do intial db connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	// FIgure out what the new item's id should be
	String getItemCountQuery = "SELECT MAX(item_id) max_id FROM items";
	PreparedStatement preparedQuery = con.prepareStatement(getItemCountQuery);
	
	ResultSet queryResult = preparedQuery.executeQuery();
	
	queryResult.next();
	int itemId = Integer.parseInt(queryResult.getString("max_id")) + 1;
	
	
	// Set data based on end-user input data
	String itemName = request.getParameter("item_name");
	String category = request.getParameter("category");
	String itemDesc = request.getParameter("item_desc");
	String user = (String)session.getAttribute("user");
	Date auctionClose = Date.valueOf(request.getParameter("auction_close"));
	double initialPrice = Double.parseDouble(request.getParameter("initial_price"));
	
	
	// Create the insert statement
	String insertItemUpdate = "INSERT INTO items(item_name, category, item_desc, user, item_id, auction_close, initial_price)"
			+ "VALUES(?, ?, ?, ?, ?, ?, ?)";
	PreparedStatement preparedUpdate = con.prepareStatement(insertItemUpdate);
	preparedUpdate.setString(1, itemName);
	preparedUpdate.setString(2, category);
	preparedUpdate.setString(3, itemDesc);
	preparedUpdate.setString(4, user);
	preparedUpdate.setInt(5, itemId);
	preparedUpdate.setDate(6, auctionClose);
	preparedUpdate.setDouble(7, initialPrice);
	
	
	// Execute the update statement
	int updateResult = preparedUpdate.executeUpdate();
	
	
	if(updateResult == 1) {	
		out.print("Successfully added '" + itemName + "' auction item list with id '" + itemId + "'");
	}
    stmt.close();
    con.close();
	
	
} catch(Exception ex) {
	out.println(ex + ".");
	out.println("Auction item update failed");
}
%>
</body>
</html>