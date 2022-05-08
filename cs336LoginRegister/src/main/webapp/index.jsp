<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<a href="index.jsp">Home</a>|
<a href="LoginPage.jsp">Login</a>|  
<a href="RegisterPage.jsp">Register</a>|
<%	
	if (session.getAttribute("user") != null){
		out.println("<a href=BuyPage.jsp>Buy an Item</a>|");
		out.println("<a href=AuctionPage.jsp>Auction an Item</a>|");
		if(String.valueOf(session.getAttribute("isAdmin")).equals("1")){
			out.println("<a href=AdminFeatures.jsp>Admins</a>|");
		}
		if(String.valueOf(session.getAttribute("isCustomerRep")).equals("1")){
			out.println("<a href=RepresentativeReply.jsp>RepHelp</a>|");
		}
		out.println("<a href=LogoutPage.jsp>Logout</a>");		
	}
%>
<h3>Computer Part Auction Website</h3>
