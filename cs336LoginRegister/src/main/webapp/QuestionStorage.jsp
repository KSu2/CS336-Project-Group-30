<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./styleHome.css" /> 
<title>Question</title>
</head>
<body>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%
int AuctionID=Integer.parseInt(request.getParameter("AuctionID"));
String ID=session.getAttribute("username").toString();
String Question=request.getParameter("Questions");

Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/cs336project","root", "Asaadz123!");
Statement st=con.createStatement();
ResultSet rs=st.executeQuery("select count(*) from Questions");
String qid="-1";
if(rs.next()){
	 qid=rs.getString(1);
}
int n=Integer.parseInt(qid);
n++;
ResultSet rs2=st.executeQuery("select * from Auction where auction_id='"+AuctionID+"'");
if(!rs2.next()){
	 out.println("Please enter a valid Auction ID");
}
else{
	/* rs2=st.executeQuery("select * from question where AuctionID='"+AuctionID+"' and QuestionID='"+ID+"'");
	*/
		st.executeUpdate("insert into Questions values('"+n+"','"+AuctionID+"','"+ID+"','"+Question+"')");
		
	/* } */
	
}
%>
<form class="returnButton">
<a id="Return" href ="LogoutPage.jsp"> Return to home </a>
</form>
</body>
</html>
