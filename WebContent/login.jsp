<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<meta name="google-signin-client_id" content="apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="login.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lobster">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css">
<title>Login</title>
</head>
<body>
	<%
		String signuperror = (String)request.getAttribute("signuperror");
		if(signuperror==null){
			signuperror="";
		}
		String signinerror = (String)request.getAttribute("signinerror");
		if(signinerror==null){
			signinerror="";
		}
	%>
	<div class="headerbar" id="header">
		<p class="alignleft" style="font-family: 'lobster', serif;">
			<a href="index.jsp" style="text-decoration:none">SalEats!</a>
		</p>
		<div class="alignright">
			<a href="index.jsp" style="color: black"> Home </a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="login.jsp" style="color: black">Login / Sign Up</a>
		</div>
	</div>
	<hr>
	<div class='some-page-wrapper'>
		<div class='row'>
			<div class='column'>
				<div class='blue-column'>
					<h1>Login</h1>
					<form name="signin" method="GET" action="loginservlet">
						<table class="input-element">
					        <tr>
					          <td>Username<br>
					          <input class="input-element" type="text" name="username" required/></td>   
					        </tr>
					        <td><br></td>
					        <tr>
					          <td>Password<br>
					          <input class="input-element" type="text" name="password" required/></td>
					        </tr>
					        <td><br></td>
					        <tr>
					        	<td>
					          		<button class="input-element-button" type="submit" name="signinbutton"value="signin">Sign in</button>
					          	</td>
					        </tr>
					        <tr>
					        	<td><hr width="30%"></td>
					        </tr>
					        <tr>
					        	<td>
					          		<div name="signinbutton"value="signin"class="g-signin2" data-onsuccess="onSignIn" data-theme="dark" data-width="890px" data-height="40px" data-longtitle="true"id="myP"></div>
					          	</td>
					        </tr>
					        <tr>
					        	<td>
					          		<font color="red" style="font-family:'fa 1', helvetica; font-size: 20px; margin-left: 10vw;"><strong><%= signinerror %></strong></font>
					          	</td>
					        </tr>
					    </table>
					</form>
					<br>
				</div>
			</div>
			<script>
				function onSignIn(googleUser) {
					var profile = googleUser.getBasicProfile();
					googleUser.disconnect();
			         console.log('ID: ' + profile.getId());
			         console.log('Name: ' + profile.getName());
			         console.log('Image URL: ' + profile.getImageUrl());
			         console.log('Email: ' + profile.getEmail());
			         console.log('id_token: ' + googleUser.getAuthResponse().id_token);

			         //did not post all above info to the server because that is not secure.
			         //just send the id_token

			         var redirectUrl = 'loginservlet';

			         //using jquery to post data dynamically
			         var form = $('<form action="' + redirectUrl + '" method="GET">' +
			                          '<input type="text" name="id_token" value="' +
			                           profile.getId() + '" />' +
			                           '<input type="text" name="username" value="' +
			                           profile.getName() + '" />' +
			                           '<input type="text" name="email" value="' +
			                           profile.getEmail() + '" />' +
			                                                                '</form>');
			   		 $('body').append(form);
			         form.submit();
			      }
			</script>
		   <script>
		      function myFunction() {
		      gapi.auth2.getAuthInstance().disconnect();
		      location.reload();
		   }
		   </script>
			<div class='column'>
				<div class='green-column'>
					<h1>Sign Up</h1>
					<form name="signup" method="GET" action="loginservlet">
						<table class="input-element">
					        <tr>
					          <td>Email<br>
					          <input required type="email" class="input-element" name="email"/></td>   
					        </tr>
					        <td><br></td>
					        <tr>
					          <td>Username<br>
					          <input class="input-element" type="text" name="username" required/></td>
					        </tr>
					        <td><br></td>
					        <tr>
					          <td>Password<br>
					          <input class="input-element" type="text" name="password" required/></td>
					        </tr>
					        <td><br></td>
					        <tr>
					          <td>Confirm Password<br>
					          <input class="input-element" type="text" name="confirmpassword" required></td>
					        </tr>
					        <td><br></td>
					        <tr>
					        	<td>
					         	<input required class="check" type="checkbox" name="terms">
					         	<label for="terms">I have read and agree to all terms and conditions of SalEats</label><br>
					         	</td>
					        </tr>
					        <tr>
					        	<td>
					          		<button class="input-element-button" type="submit" name="signinbutton"value="signup"> 
					          		Create Account</button>
					          	</td>
					        </tr>
					        <tr>
					        	<td>
					          		<font color="red" style="font-family:'fa 1', helvetica; font-size: 20px; margin-left: 10vw;"><strong><%= signuperror %></strong></font>
					          	</td>
					        </tr>
					    </table>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>