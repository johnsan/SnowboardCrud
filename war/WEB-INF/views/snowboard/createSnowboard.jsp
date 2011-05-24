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
<h3>Create</h3>
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
<hr />
<%
	PersistenceManager pm = PMF.get().getPersistenceManager();
	String query = "select from " + Snowboard.class.getName() + " order by brand, model asc range 0,5";
	List<Snowboard> snowboards = (List<Snowboard>) pm.newQuery(query).execute();
	if (snowboards.isEmpty()) {
 %>
<p>No snowboards currently exist.</p>
<%	} else { %>
<table>
        <tr>
                <td><b>Brand</b></td>
                <td><b>Model</b></td>
                <td></td>
        </tr>
 <%
		for (Snowboard s : snowboards) {
 %>
        <tr>
                <td><%= s.getBrand() %></td>
                <td><%= s.getModel() %></td>
                <td><a href="/snowboard/deleteSnowboard/<%= s.getId() %>">Delete</a></td>
        </tr>
<%
		}
%>
</table>
<%
	}
	pm.close();
%>
</body>
</html>
