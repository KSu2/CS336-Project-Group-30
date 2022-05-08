<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import = "cs336LoginRegister.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LoginAuth</title>
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
		String username = request.getParameter("username");
		String pass = request.getParameter("pass");

		String query = "SELECT * FROM user WHERE username = ?";
		PreparedStatement ps1 = con.prepareStatement(query);
		ps1.setString(1,username);
		ResultSet rs = ps1.executeQuery();

		if(rs.next() == false){
			out.println("<font color=red>");
            out.println("User does not exist");
            out.println("</font>");
            response.sendRedirect("LoginPage.jsp");
		} 
		else if(rs.getString("username").equals(username) && rs.getString("pass").equals(pass)){
			out.println("<font color=green>");
	        out.println("Login Successful");
	        out.println("<br><br>");
	        out.println("Welcome User: " + (String)session.getAttribute("user"));
	        out.println("</font>");
	        out.println("<br><br>");
	        out.println("<a href=LogoutPage.jsp>Logout</a>");
			String isAdmin = rs.getString("isAdmin");
        	session.setAttribute("isAdmin", isAdmin); // 1 for yes 0 for no 
	        session.setAttribute("user", username);
	        response.sendRedirect("index.jsp");
		}
		else{
			out.println("<font color=red>");
	        out.println("login unsucessful, please check username and password are correct");
	        out.println("</font>");
	        response.sendRedirect("LoginPage.jsp");
		}
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
        stmt.close();
        con.close();

	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
%>
</body>
</html>