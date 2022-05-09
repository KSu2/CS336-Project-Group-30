<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<title>Customer Service</title>
</head>
</body>
	<div align="center">
	<h1>User Question Form</h1>
	<form action="<%= request.getContextPath() %>/question" method="post">
	<table style="with:80%">
	 <tr>
	  <td>User Name</td>
	  <td><input type="text" name="username" /></td>
	 </tr>
	 <tr>
	 <td>Question</td>
	 <td><input type="text" name="question" /></td>
	 </tr>
	</table>
	<input type="submit" value="Submit" />
   </form>
  </div>
 </body>
 </html>
	 
	 
