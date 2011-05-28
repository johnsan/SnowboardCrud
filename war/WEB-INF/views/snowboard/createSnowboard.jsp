<%@ page import="java.util.List" %>
<%@ page import="javax.persistence.EntityManager" %>
<%@ page import="com.snowboardcrud.domain.Snowboard" %>
<%@ page import="com.snowboardcrud.repository.EMF" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
	<title>Create Snowboard</title>
	<link type="text/css" rel="stylesheet" href="/resources/stylesheets/main.css" />
	<script type="text/javascript" src="<c:url value="/resources/js/jquery-1.6.1.min.js" /> "></script>
</head>
<body>
<h3>Create</h3>
<form:form method="post" action="/snowboard/processCreateSnowboard">
<div class="container">
	<div class="form_row">
		<div class="left">
			<form:label path="brand">Brand</form:label>
		</div>
		<div class="right">
			<form:input path="brand" />
		</div>
	</div>
	<div class="form_row">
		<div class="left">
			<form:label path="model">Model</form:label>
		</div>
		<div class="right">
			<form:input path="model" />
		</div>
	</div>
	<div class="form_row">
		<div class="left">
			<input type="submit" value="Create"/>
		</div>
		<div class="right">
			<p></p>
		</div>
	</div>
</div>
</form:form>

<hr />
<%
	// ToDo move outside view.
	EntityManager em = EMF.get().createEntityManager();
	String query = "select from " + Snowboard.class.getName() + " order by brand, model asc range 0,30";
	List<Snowboard> snowboards = (List<Snowboard>) em.createQuery(query).getResultList();
	if (snowboards.isEmpty()) {
%>
<p>No snowboards currently exist.</p>
<%
	} else {
%>
<div class="container">
	<div class="top_row">
		<div class="left">
			<p>Brand</p>
		</div>
		<div class="middle">
			<p>Model</p>
		</div>
		<div class="middle">
			<p>Length</p>
		</div>
		<div class="middle">
			<p>Genre</p>
		</div>
		<div class="right">
			<p></p>
		</div>
	</div>
 <%
 	for (Snowboard s : snowboards) {
 		String key = KeyFactory.keyToString(s.getKey());
 %>
 	<div class="row">
		<div class="left" id="<%= key %>_Brand">
			<span><%= s.getBrand() %></span>
		</div>
		<div class="middle" id="<%= key %>_Model">
			<span><%= s.getModel() %></span>
		</div>
		<div class="middle" id="<%= key %>_Length">
			<span><%= s.getLength() %></span>
		</div>
		<div class="middle" id="<%= key %>_snowsportGenre">
			<span><%= s.getSnowsportGenre() %></span>
		</div>
		<div class="right">
			<span><a href="/snowboard/deleteSnowboard/<%= key %>">Delete</a></span>
		</div>
	</div>
<%
		}
%>
</div>
<%
	}
	//pm.close();
	em.close();
%>
      
      
<!-- AJAX TEST -->
<br /><br /><br />
<a class="ajax_test" href="">Test</a>
<script type="text/javascript">

	$(document).ready(function() {
		$(".ajax_test").click(function(e) {
			e.preventDefault();
	    	alert("msg");
	    });  
	});
	$(".left span,.middle span").hover(function(){
		$(this).addClass("highlight");
	},function(){
		$(this).removeClass("highlight");
	});
	$(".left span,.middle span").click(function(){
		var text = $(this).text();
		var length = text.length;
		$(this).text('');
		$('<input type="text" size="'+length+'" />').appendTo($(this)).val(text).select().blur(
	            function(){
	                var newText = $(this).val();
	                var currentId = $(this).parents('div:first').attr('id');
	                $.post("/snowboard/ajaxUpdate/"+currentId+"/"+newText);
	                $(this).parent().text(newText),find('input').remove();
	                // do on blur and 'return' key
	                // use bind and keypress
	                // remove on esc
	                // whilst saving, display saving div
	            });
	});
	
</script>
</body>
</html>
