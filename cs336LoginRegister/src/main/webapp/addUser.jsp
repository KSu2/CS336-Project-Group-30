<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import = "cs336LoginRegister.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AddUser</title>
</head>
<body>
<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String pass = request.getParameter("pass");
		String user_type = request.getParameter("userType");

		String query = "SELECT * FROM user WHERE username = ?";
		PreparedStatement ps1 = con.prepareStatement(query);
		ps1.setString(1,username);
		ResultSet rs = ps1.executeQuery();
		if(rs.next()){
			if(user_type.equals("customer_rep")){
				//update isCustomerRep to true
			}
			else{
				out.println("<font color=red>");
	            out.println("username is already taken");
	            out.println("</font>");
	            out.println("<a 'href=RegisterPage.jsp'> <input type = 'submit' value = 'go back'/> </a>");
			
			}
        }
	
		else{
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO user(email, username, pass)"
							+ "VALUES (?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps2 = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps2.setString(1, email);
			ps2.setString(2, username);
			ps2.setString(3, pass);
			//Run the query against the DB
			ps2.executeUpdate();
            out.println("<font color=green>");
            out.println("Success");
            out.println("</font>");
            out.println("<a 'href=RegisterPage.jsp'> <input type = 'submit' value = 'go back'/> </a>");
			
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