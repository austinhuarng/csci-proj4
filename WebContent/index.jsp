<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
<title>SalEats</title>
</head>
<% 
		String user = null;
		HttpSession session2 = request.getSession();
		//if(session2.getAttribute("username") != null){
			
				user = (String)session2.getAttribute("username"); 
				System.out.println(user + "user");
		//}
	%>
<body>
	<%
		String error = (String)request.getAttribute("landingerror");
		if(error==null){
			error="";
		}
	%>
	<div class="headerbar" id="header" >
		<p class="alignleft" style="font-family:'lobster',serif;"><a href ="index.jsp" style="text-decoration: none" >SalEats!</a></p>
		<div class="alignright">
			<a href="index.jsp" style="color: black"> Home </a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href = "login.jsp" style="color: black; display:inline" id="loggedoutheader">Login / Sign Up</a>
			<a href = "favorite.jsp" style="color: black; display: none" id="loggedinheader">Favorites</a>&nbsp;&nbsp;
			<form action="logoutservlet" method="POST" name="logoutform">
				<button class="logoutbttn" style="color: black; display: none" id="loggedinheader-logout" type="submit">Log Out</button>
			</form>
		</div>
	</div>
	<hr>
	<br><br><br>
	<div align="center">
		<img class="salmon" src="images/HNCK5665.jpg" alt="salmon">
	</div>
	<br><br>
	<!-- start of input fields -->
	<form name="restaurantform" method="GET" action="landingservlet">
    <div class="flex-container">
	  	<div class="flex-left">
	  			<input class="input-element" type="text" placeholder="  Restaurant Name" name="restaurantname" required/>
				<input class="submit-icon" style="font-family: FontAwesome" value="&#xf002;" type="submit">
		</div>
			<div class="flex-right">
					<input type="radio" name="searchtype" value="best_match" />Best Match<br>
					<input type="radio" name="searchtype" value="rating" />Rating
	       	</div>
	       	<div class="flex-right">
		       		<input type="radio" name="searchtype" value="review_count" />Review Count<br>
		       		<input type="radio" name="searchtype" value="distance" />Distance
			</div>
	</div>
	<div class="flex-container">
		<div class="flex-bottom">
				<input class="input-coord" step="0.000000000000001"type="number" placeholder="  Latitude"
					id="latitude" name="latitude"/>
		</div>
		<div class="flex-bottom">
				<input class="input-coord" step="0.000000000000001"type="number" placeholder="  Longitude"
					id="longitude" name="longitude"/>
		</div>
		<div class="flex-bottom">
			<div class="googlebutton" onclick="on()"><i class="fa fa-map-marker" aria-hidden="true"></i>
			Google Maps (Drop a pin!)</div>
		</div>
	</div>
	</form>
	<div class="container-box" id="map" onclick="off()"></div>
	<div class="overlay" id="googleMap" onclick="on()" style="z-index:10;display:none;width:50%;height:50%;"></div>
	<script>
		function myMap() {
			var mapProp = {
				center : new google.maps.LatLng(34.021160, -118.278132),
				zoom : 6,
			};
			var map = new google.maps.Map(document.getElementById("googleMap"),
					mapProp);
			var marker;
			function addMarker(latLng){
				if(marker){
					marker.setPosition(latLng);
				}
				else{
					marker = new google.maps.Marker({
						position:latLng,
						map:map
					});
				}
			}
			map.addListener('click',
			function(event){
				addMarker(event.latLng);
				document.getElementById('latitude').value = event.latLng.lat();
				document.getElementById('longitude').value = event.latLng.lng();
			});
		}
		function on() {
			  document.getElementById("map").style.display = "block";
			  document.getElementById("googleMap").style.display = "block";
		}
		function off() {
			  document.getElementById("map").style.display = "none";
			  document.getElementById("googleMap").style.display = "none";
		}
	</script>
	<script	src="https://maps.googleapis.com/maps/api/js?key=KEY"></script>
	<font color="red" style="font-family:'fa 1', helvetica; font-size: 20px; margin-left: 10vw;"><strong><%= error %></strong></font>
	
	<script>
		<% if (user != null && user.trim().length()!=0) { %>
			document.getElementById("loggedinheader").style.display = "inline";
			document.getElementById("loggedinheader-logout").style.display = "inline";
			document.getElementById("loggedoutheader").style.display = "none";
		<% } %>
	</script>
</body>
</html>