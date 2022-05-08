<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Representative Reply</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/kognise/water.css@latest/dist/light.min.css">
	<style>
	body {
	margin: 0 !important;
	}
	</style>
</head>
<body>
    
    <h3>Respond to Customers</h3>
    <form action="AuctionPage.jsp" method="post">
        <h5>Question ID:</h5>
        <input name="qid" type="text">
        <h5>Response:</h5>
        <input name="reply" type="text"/>
        <br><br>
        <button>Send</button>
    </form>
    <form action="customerRepHome.jsp">
    	<button>Back to Home</button>
    </form>
    <br>
    <h3>Unanswered Questions:</h3>
    <%
    try {
	    ApplicationDB db = new ApplicationDB();
	    Connection con = db.getConnection();
	    Statement st = con.createStatement();
	    
	    //String uName = (String)session.getAttribute("user");
	    ResultSet rs = st.executeQuery("SELECT * from Questions where customerRep IS NULL and reply IS NULL");
	    if(!rs.next())
	    {
	    	out.print("<p>There are no unanswered questions.</p>");
	    }
	    else
	    {
	    	while(rs.next())
		    {
		    	int qid = rs.getInt("questionid");
		    	String u = rs.getString("username");
		    	String t = rs.getString("topic");
		    	String m = rs.getString("question");
		    	String displayQuestion = "Question ID: " + qid + "<br>Customer Username: " + u + "<br>Question: " + q;
		    	
		    	out.print("<p>" + displayQuestion + "</p>");
		    }
	    }
    
	    st.close();
	    rs.close();
    	db.closeConnection(con);
    %>
   </body>
</html>
