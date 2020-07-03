<%@page import="java.net.URLEncoder"%>
<%@page import="HW4.SQLConnection"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ page import="java.util.Vector" %>
    <%@ page import ="HW4.Restaurant" %>
    <%@ page import ="HW4.SQLConnection" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
<title>Favorites</title>
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
	<div class="headerbar" id="header">
		<p class="alignleft" style="font-family: 'lobster', serif;">
			<a href="index.jsp" style="text-decoration: none">SalEats!</a>
		</p>
		<div class="alignright">
			<a href="index.jsp" style="color: black"> Home </a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href = "login.jsp" style="color: black; display:inline" id="loggedoutheader">Login / Sign Up</a>
			<a href = "favorite.jsp" style="color: black; display: none" id="loggedinheader">Favorites</a>&nbsp;&nbsp;
			<form action="logoutservlet" method="POST" name="logoutform">
				<button class="logoutbttn" style="color: black; display: none" id="loggedinheader-logout" type="submit">Log Out</button>
			</form>
		</div>
	</div>
	<hr><br>
	<form name="restaurantform" method="GET" action="landingservlet">
    <div class="flex-container">
	  	<div class="flex-left">
	  			<input class="input-element" type="text" placeholder="  Restaurant Name" name="restaurantname" />
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
	<script	
		src="https://maps.googleapis.com/maps/api/js?key=KEY"></script>
	<br>
	<div style="margin-left: 10vw"><font class="results-header"><%= session.getAttribute("username") %>'s Favorites</font></div>
	<div class="dropdown"style="width: 100%; margin-right:10vw">
			<select  style="float: right; margin-right: 10vw; background-color: #990000; color:white;border:none; height:35px;
					width:123px; text-align: center; font-size:95%; font-family:helvetica; border-radius:5px; text-indent:3px" id="sortby">
				<option value="fa 1" disabled selected hidden> &nbsp;&nbsp;Sort By:</option>
				<option style="font-family: helvetica;color:black; background-color:white" value="nameincr">A To Z</option>
				<option style="font-family: helvetica;color:black; background-color:white" value="namedecr">Z to A</option>
				<option style="font-family: helvetica;color:black; background-color:white" value="ratingincr">Highest Rating</option>
				<option style="font-family: helvetica;color:black; background-color:white" value="ratingdecr">Lowest Rating</option>
				<option style="font-family: helvetica;color:black; background-color:white" value="restoIDincr">Most Recent</option>
				<option style="font-family: helvetica;color:black; background-color:white" value="restoIDdecr">Least Recent</option>
			</select>
	</div>
	<br>

	<!-- ADD SORTING FUNCTIONALTY -->
	<% 
	String name = (String)session.getAttribute("username");
	SQLConnection.SQLConnection_init();
	request.setAttribute("reslist", SQLConnection.getList(name));
	%>
	<table style="margin-left:12vw; margin-right:12vw;width:78vw">
		<thead>
		</thead>
		<tbody>
			<%
				int i = 1;
				Vector<Restaurant>restaurantlist = (Vector<Restaurant>)request.getAttribute("reslist");
			%>

			<%
				for (Restaurant r : restaurantlist) {
			%>
			<tr>
				<td>
					<div class="square">
					<%String fullurl = "details.jsp?imgurl=" + URLEncoder.encode(r.getImgurl()) + "&resto=" + URLEncoder.encode(r.getName()) + "&address=" + URLEncoder.encode(r.getAddress()) + "&pageurl=" + 
					URLEncoder.encode(r.getPageurl()) + "&rating=" + URLEncoder.encode(r.getRating().toString()) + "&phone=" + URLEncoder.encode(r.getPhone().toString())
					+ "&cuisine=" + URLEncoder.encode(r.getCuisine().toString()) + "&price=" + URLEncoder.encode(r.getPrice().toString());%>
					<a href=<%=fullurl %>>
						<img class="restaurantpic" src="<%=r.getImgurl()%>"></a>
					</div>
				</td>
				<td><div class="deets">
				<%=r.getName()%><br><br>
				<%=r.getAddress()%><br><br>
				<%=r.getPageurl()%></div></td>
			</tr>
			<tr class="break"><td colspan="2"><hr style="border-top: 1px dashed; color: darkgrey"></td></tr>
			<%
				}
			%>
		</tbody>
	</table>
	
	<script>
		<% if (user != null) { %>
			document.getElementById("loggedinheader").style.display = "inline";
			document.getElementById("loggedinheader-logout").style.display = "inline";
			document.getElementById("loggedoutheader").style.display = "none";
		<% } %>
	</script>
</body>
</html>