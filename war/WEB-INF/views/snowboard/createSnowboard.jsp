<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="com.snowboardcrud.domain.Snowboard" %>
<%@ page import="com.snowboardcrud.repository.PMF" %>
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
<div id="container">
	<div id="form_row">
		<div id="left">
			<form:label path="brand">Brand</form:label>
		</div>
		<div id="right">
			<form:input path="brand" />
		</div>
	</div>
	<div id="form_row">
		<div id="left">
			<form:label path="model">Model</form:label>
		</div>
		<div id="right">
			<form:input path="model" />
		</div>
	</div>
	<div id="form_row">
		<div id="left">
			<input type="submit" value="Create"/>
		</div>
		<div id="right">
			<p></p>
		</div>
	</div>
</div>
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
<div id="container">
	<div id="top_row">
		<div id="left">
			<p>Brand</p>
		</div>
		<div id="middle">
			<p>Model</p>
		</div>
		<div id="middle">
			<p>Length</p>
		</div>
		<div id="middle">
			<p>Type</p>
		</div>
		<div id="right">
			<p></p>
		</div>
	</div>
 <%
		for (Snowboard s : snowboards) {
 %>
 	<div id="row">
		<div id="left">
			<span><%= s.getBrand() %></span>
		</div>
		<div id="middle">
			<span><%= s.getModel() %></span>
		</div>
		<div id="middle">
			<span>152</span>
		</div>
		<div id="middle">
			<span>Freestyle</span>
		</div>
		<div id="right">
			<span><a href="/snowboard/deleteSnowboard/<%= s.getId() %>">Delete</a></span>
		</div>
	</div>
<%
		}
%>
</div>
<%
	}
	pm.close();
%>
      
      
<!-- AJAX TEST -->
<br /><br /><br />
<a id="ajax_test" href="">Test</a>
<script type="text/javascript">

	$(document).ready(function() {
		$("#ajax_test").click(function(e) {
			e.preventDefault();
	    	alert("msg");
	    });  
	});
	$("#left span,#middle span").hover(function(){
		$(this).addClass("highlight");
	},function(){
		$(this).removeClass("highlight");
	});
	$("#left span,#middle span").click(function(){
		var text = $(this).text();
		var length = text.length;
		$(this).text('');
		$('<input type="text" size="'+length+'" />').appendTo($(this)).val(text).select().blur(
	            function(){
	                var newText = $(this).val();
	                $.post("/snowboard/ajaxUpdate/");
	                $(this).parent().text(newText),find('input').remove();
	                //$.post("/snowboard/ajaxUpdate/");
	                
	                // save new value by sending to a url
	                // handle url in controller
	                // whilst saving, display saving div
	            });
		//$('<textarea />').appendTo($(this)).val(text).select().blur(
	    //        function(){
	    //            var newText = $(this).val();
	    //            $(this).parent().text(newText),find('textarea').remove();
	    //        });
	});
	
</script>
</body>
</html>
