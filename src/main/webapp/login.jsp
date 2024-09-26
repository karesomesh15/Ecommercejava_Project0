<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<%@include file="Components/common_css_js.jsp"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
label {
    font-weight: bold;
}

.card {
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.card-body {
    padding: 2rem;
}

.btn-login {
    background-color: #28a745; /* Green background */
    color: #fff; /* White text */
    width: 100%; /* Full-width */
    border: none; /* Remove border */
}

.btn-login:hover {
    background-color: #218838; /* Darker green on hover */
    color: #fff;
}

.text-center i {
    font-size: 4rem;
    color: #28a745; /* Green color */
}
</style>
</head>
<body>  

    <!--navbar -->
    <%@include file="Components/navbar.jsp"%>

    <div class="container-fluid">
        <div class="row mt-5">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-body px-5" >
						
                        <div class="container text-center" >
                            <i class="fas fa-user-circle"></i> <!-- Bootstrap icon -->
                        <h3 class="text-center">Sign-In</h3>
                        </div>
                        <%@include file="Components/alert_message.jsp" %>
                        
                        <!--login-form-->
                        <form id="login-form" action="LoginServlet" method="post">
                            <input type="hidden" name="login" value="user"> 
                            <div class="mb-3">
                                <label class="form-label">Email</label> 
                                <input type="email" name="user_email" placeholder="Email address"
                                    class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="user_password"
                                    placeholder="Enter your password" class="form-control" required>
                            </div>
                            <div id="login-btn" class="container text-center">
                                <button type="submit" class="btn btn-login">Login</button>
                            </div>
                        </form>
                        <div class="mt-3 text-center">
                      <!--   href="forgot_password.jsp" -->
                            <h6><a href="#" style="text-decoration: none">Forgot Password?</a></h6>
                            <h6>
                                Don't have an account? <a href="register.jsp"
                                    style="text-decoration: none">Sign Up</a>
                            </h6>
                        </div>
                    </div>  

                </div>
            </div>
        </div>
    </div>
</body>
</html>
