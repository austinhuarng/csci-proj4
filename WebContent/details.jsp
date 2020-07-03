<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://apis.google.com/js/platform.js"></script>
<script src="https://apis.google.com/js/api.js"></script>
<link rel="stylesheet" href="index.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
<title>Details</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>
<link rel="shortcut icon" href="#">
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
			function addMarker(latLng){
				var marker = new google.maps.Marker({
					position:latLng,
					map:map
				});
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
	<br>
		<div style="margin-left: 10vw"><font class="results-header">"<%= request.getParameter("resto") %>"</font></div>
	<br><br><hr style="margin-left:12vw; margin-right:12vw;border-top: 1px dashed; color: darkgrey"><br><br>
	<table style="margin-left:12vw; margin-right:12vw;width:78vw">
		<thead>
		</thead>
		<tbody>
			<tr>
				<td>
					<div class="square">
					<a href=<%=request.getParameter("pageurl")%>>
						<img class="restaurantpic" src="<%=request.getParameter("imgurl")%>"></a>
					</div>
				</td>
				<td><div class="deets">
				Address: <%=request.getParameter("address")%><br><br>
				Phone Number: <%=request.getParameter("phone")%><br><br>
				Cuisine: <%=request.getParameter("cuisine")%><br><br>
				Price: <%=request.getParameter("price")%><br><br>
				Rating: <span id="sters"></span></div></td>
			</tr>
		</tbody>
	</table>
	<script>
		document.getElementById("sters").innerHTML = getStars(<%=request.getParameter("rating")%>);
	
		function getStars(rating) {
		var lel = parseFloat(rating);
		  // Round to nearest half
		  lel = Math.round(rating * 2) / 2;
		  let output = [];
	
		  // Append all the filled whole stars
		  for (var i = lel; i >= 1; i--)
		    output.push('<i class="fa fa-star" aria-hidden="true" style="color: grey;"></i>&nbsp;');
	
		  // If there is a half a star, append it
		  if (i == .5) output.push('<i class="fa fa-star-half-o" aria-hidden="true" style="color: grey;"></i>&nbsp;');
	
		  // Fill the empty stars
		  for (let i = (5 - lel); i >= 1; i--)
		    output.push('<i class="fa fa-star-o" aria-hidden="true" style="color: grey;"></i>&nbsp;');
	
		  return output.join('');
	
		}
	</script>
	<br> <br>
	<button id="favbutton" type="submit" class="favbutton" onclick="changeatt()"><i class="fa fa-star"></i>&nbsp;&nbsp;Add to Favorites</button>
	<br style="margin-bottom: 2px; line-height:8px">
	<button id="resbutton" class="resbutton" onclick="return showBooking()"><i class="fa fa-calendar"></i>&nbsp;&nbsp;Add Reservation</button>
	<script>
	var clicked = "no";
	  function changeatt(){
          $.ajax({
     		 type: "post",
              url: "/austinhu_CSCI201L_Assignment4/addrez", 
              data: {
            	 "name" : "<%= session.getAttribute("username")%>",
             	 "resto" : "<%=request.getParameter("resto")%>",
             	 "imgurl" : "<%=request.getParameter("imgurl")%>",
             	 "pageurl": "<%=request.getParameter("pageurl")%>",
             	 "address": "<%=request.getParameter("address")%>",
             	 "rating" : "<%=request.getParameter("rating")%>",
             	 "cuisine": "<%=request.getParameter("cuisine")%>",
             	 "phone": "<%=request.getParameter("phone")%>",
             	 "price": "<%=request.getParameter("price")%>",
             	 "savetodb": clicked
              },
     		    success: function(){
                     console.log("done");
                 }
     		});
          	if(clicked == "no"){
	            document.getElementById("favbutton").innerHTML = "Remove from Favorites";
	            clicked = "yes";
          	}
          	else{
	            document.getElementById("favbutton").innerHTML = "Add to Favorites";
				clicked = "no";
          	}
	  }
	</script>
	<br>
	<br style="margin-bottom: 2px; line-height:8px">
	<div id="booking">
		     <div class = "insidebookingdiv">
			    <input required id="resdate" name="resdate" type="date"  placeholder="  Date"/>			
			    <input required id="restime" name="restime" size="30" type="time" />
			  </div>
			  <br>
			  <div>
			  	<textarea required id="notes" name="notes" placeholder="  Reservation Notes"></textarea>
			  </div>
			  <br>
			  <button id="submitres" class="resbutton"><i class="fa fa-calendar"></i>&nbsp;&nbsp;Submit Reservation</button>
	</div>
	<script>
		var goog = <%= session.getAttribute("isgoogle") %>;
		function showBooking(){
			if(goog == "no" || goog == null){
				alert("Please sign in using google to add a reservation");
			}else
			  document.getElementById("booking").style.display = "block";
		}
	</script>
	 <button id="authorize_button" style="display: none;">Authorize</button>
    <button id="signout_button" style="display: none;">Sign Out</button>

    <pre id="content" style="white-space: pre-wrap;"></pre>

    <script type="text/javascript">
      // Client ID and API key from the Developer Console
      var CLIENT_ID = 'ID';
      var API_KEY = 'KEY';

      // Array of API discovery doc URLs for APIs used by the quickstart
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];

      var SCOPES = "https://www.googleapis.com/auth/calendar";

      var authorizeButton = document.getElementById('submitres');
      var signoutButton = document.getElementById('signout_button');
      function handleClientLoad() {
        gapi.load('client:auth2', initClient);
      }

      function initClient() {
        gapi.client.init({
          apiKey: API_KEY,
          clientId: CLIENT_ID,
          discoveryDocs: DISCOVERY_DOCS,
          scope: SCOPES
        }).then(function () {
          // Listen for sign-in state changes.
          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

          // Handle the initial sign-in state.
          updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
          authorizeButton.onclick = handleAuthClick;
          signoutButton.onclick = handleSignoutClick;
        }, function(error) {
          appendPre(JSON.stringify(error, null, 2));
        });
      }


      function updateSigninStatus(isSignedIn) {
        if (isSignedIn) {
          //signoutButton.style.display = 'block';
          makeBooking();
        } else {
          authorizeButton.style.display = 'block';
          signoutButton.style.display = 'none';
        }
      }

      function handleAuthClick(event) {
        gapi.auth2.getAuthInstance().signIn();
      }


      function handleSignoutClick(event) {
        gapi.auth2.getAuthInstance().signOut();
      }


      function appendPre(message) {
        var pre = document.getElementById('content');
        var textContent = document.createTextNode(message + '\n');
        pre.appendChild(textContent);
      }

      /**
       * Print the summary and start datetime/date of the next ten events in
       * the authorized user's calendar. If no events are found an
       * appropriate message is printed.
       */
       function makeBooking(){
			var str1 = document.getElementById('resdate').value;
			var str2 = document.getElementById('restime').value;
			//var str3 = str1.concat('T', str2);
			//starttime.toISOString();
			//console.log(starttime);
			var firstpart = str2.substr(0, str2.indexOf(':'));
			var lel = parseInt(firstpart);
			lel = lel+1;
			var endtime = str1.concat('T', lel.toString(), ":00:00");
			var note = document.getElementById("notes").value;
			var date = document.getElementById("resdate").value;
			var start = str1.concat('T', str2, ":00");
			//var endtime = str1.concat('T', "23:59:59");
			var resource = {
			  "summary": "Reservation at " + "<%= request.getParameter("resto") %>",
			  "location": "<%=request.getParameter("address")%>",
			  "description": document.getElementById("notes").value,
			  "start": {
			    "dateTime": start,
			    "timeZone" : "America/Los_Angeles"
			  },
			  "end": {
			    "dateTime": endtime,
			    "timeZone" : "America/Los_Angeles"
			  }
			};
			var request = gapi.client.calendar.events.insert({
			  'calendarId': 'primary',
			  'resource': resource
			});
			request.execute(function(resource) {
			});
		}

    </script>

    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
	
	<script>
		<% if (user != null && user.trim().length()!=0) { %>
			document.getElementById("loggedinheader").style.display = "inline";
			document.getElementById("loggedinheader-logout").style.display = "inline";
			document.getElementById("loggedoutheader").style.display = "none";
		<% } %>
	</script>
</body>
</html>