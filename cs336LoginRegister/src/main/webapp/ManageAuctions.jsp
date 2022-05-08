<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Manage Auctions</title>
</head>
<body>
<h2>Active Auctions</h2>

<table>
	<tr><th>Auction ID</th><th>Item Name</th><th>Start Date</th><th>End Date</th></tr>
<% 
	Auction a=new Auction();
	ResultSet rs=a.show();
	while(rs.next()){
%>
	<tr>
		<td><%=rs.getInt("auction_id")%></td>	
	    <td><%=rs.getString("item_name")%></td>		
	    <td><%=rs.getTimestamp("start_date")%></td>		
	    <td><%=rs.getTimestamp("end_date")%></td>
	    <td>
	    <form action='editAuction.jsp' method='POST'>
	    <input type='submit' value='Edit'>
	    <input type='hidden' name='aid' value=<%=rs.getInt("auction_id")%>>
	    </form>
	    </td>
	    <td>
	    <form method='POST'>
	    <input type='submit' value='Delete' onclick="if(confirm('Are you sure? This action cannot be undone.')){form.action='deleteAuction.jsp'}">
	    <input type='hidden' name='aid' value=<%=rs.getInt("auction_id")%>>
	    </form>
	    </td>
	</tr>

<%
}
%>
</table>

</body>
</html>
