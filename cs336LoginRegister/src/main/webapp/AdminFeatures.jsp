<!DOCTYPE html>   
<%@ include file="index.jsp" %>     
<html>    
<head>    
    <title>AdminFeatures</title>       
</head>    
<body>    
	<h2>Create a customer representative account</h2>
    <form id="registerUser" method="get" action="addUser.jsp">    
        <label><b>User Name     
        </b>    
        </label>    
        <input type="text" name="username" id="Uname" placeholder="Username">    
        <br><br>    
        <label><b>Password     
        </b>    
        </label>    
        <input type="Password" name="pass" id="Pass" placeholder="Password">    
        <br><br>    
        <button type="submit" value="customer_rep" id = "log" name = userType>Submit</button>    
    </form>     
	
	<h2>Generate Earnings Report</h2>
	<form method="get" action="getAnalytics.jsp">  					
		<input type = "radio" name = "query_type" value = "TotalEarnings">Total Earnings
		<br>
		<input type = "radio" name = "query_type" value = "EarningsPer">Earnings per:
		<select id = "EarningPerType" name="selectPerType">
				<option value="item_id">Item</option>
				<option value="category">Item Type</option>
				<option value="username">End User</option>
		</select>
		<br>
		<input type = "radio" name = "query_type" value = "BestSelling">Best Selling:
		<select id = "BestSellingPerType" name="selectSellType" size=1>
				<option value="item_id">Item</option>
				<option value="username">End User</option>
		</select>
		<br>
		<input type="submit" value="Submit">
	</form>
</body>    
</html>  