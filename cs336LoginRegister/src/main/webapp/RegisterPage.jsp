<!DOCTYPE html>  
<%@ include file="index.jsp" %>  
<hr/>  
<html>    
<head>    
    <title>Register Form</title>    
    <link rel="stylesheet" type="text/css" href="LoginRegisterFormStyle.css">    
</head>    
<body>    
    <h2>Register Form</h2><br>    
    <div class="login">    
    <form id="login" method="get" action="addUser.jsp">    
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
        <button type="submit" value = "user" id = "log" name = userType>Submit</button> 
    </form>     
</div>    
</body>    
</html>  