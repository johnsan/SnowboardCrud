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
<form:form method="post" action="/snowboard/createSnowboard">
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
		<div class="row">
			<div class="left_create">
				<span><form:input size="8" path="brand" /></span>
			</div>
			<div class="middle_create">
				<span><form:input size="8" path="model" /></span>
			</div>
			<div class="middle_create">
				<span><form:input size="8" path="length" /></span>
			</div>
			<div class="middle_create">
				<span><form:input size="8" path="genre" /></span>
			</div>
			<div class="right_create">
				<span><input type="submit" value="Create"/></span>
			</div>
		</div>
		
	<c:forEach items="${snowboardList}" var="snowboard">
	 	<div class="row">
			<div class="left" id="${snowboard.id}_Brand">
				<span>${snowboard.brand}</span>
			</div>
			<div class="middle" id="${snowboard.id}_Model">
				<span>${snowboard.model}</span>
			</div>
			<div class="middle" id="${snowboard.id}_Length">
				<span>${snowboard.length}</span>
			</div>
			<div class="middle" id="${snowboard.id}_snowsportGenre">
				<span>${snowboard.genre}</span>
			</div>
			<div class="right">
				<span><a href="/snowboard/deleteSnowboard/${snowboard.id}">Delete</a></span>
			</div>
		</div>
	</c:forEach>

	</div>  
</form:form>


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
	                var identifier = $(this).parents('div:first').attr('id');
	                identifier = identifier.split("_");
	                $.post("/snowboard/ajaxUpdate/"+identifier[0]+"/"+identifier[1]+"/"+newText);
	                $(this).parent().text(newText),find('input').remove();
	            });
	});
	
</script>
</body>
</html>
