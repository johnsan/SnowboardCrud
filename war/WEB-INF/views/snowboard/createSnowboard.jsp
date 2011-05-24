<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.snowboardcrud.domain.Snowboard" %>
<%@ page import="com.snowboardcrud.repository.PMF" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
	<title>Create Snowboard</title>
</head>
<body>
<h2>Create</h2>
<form:form method="post" action="/snowboard/processCreateSnowboard">

	<table>
	<tr>
		<td><form:label path="brand">Brand</form:label></td>
		<td><form:input path="brand" /></td> 
	</tr>
	<tr>
		<td><form:label path="model">Model</form:label></td>
		<td><form:input path="model" /></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="Create Snowboard"/>
		</td>
	</tr>
</table>	
	
</form:form>
<%
	PersistenceManager pm = PMF.get().getPersistenceManager();
	String query = "select from " + Snowboard.class.getName() + " order by brand desc range 0,5";
	List<Snowboard> snowboards = (List<Snowboard>) pm.newQuery(query).execute();
	if (snowboards.isEmpty()) {
 %>
 <p>No snowboards currently exist.</p>
<%
    } else {
        for (Snowboard s : snowboards) {
%>
<p>Brand: <%= s.getBrand() %>  Model: <%= s.getModel() %></p>
<%
        }
    }
    pm.close();
%>
</body>
</html>
