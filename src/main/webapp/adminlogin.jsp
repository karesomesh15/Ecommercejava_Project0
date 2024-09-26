<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Admin Login</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        label {
            font-weight: bold;
        }
        .card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .card-header {
            background-color: #007bff;
            color: white;
            border-radius: 10px 10px 0 0;
            padding-top: 20px;
        }
        .card-body {
            padding: 30px;
        }
        .btn-custom {
            background-color: green;
            color: white;
            width: 100%;
            font-size: 18px;
            padding: 10px;
            border-radius: 5px;
            border: none;
        }
        .btn-custom:hover {
            background-color: darkgreen;
        }
    </style>
</head>
<body>
    <!--navbar -->
    <%@include file="Components/navbar.jsp"%>

    <div class="container-fluid mt-5">
        <div class="row mt-5">
            <div class="col-md-4 offset-md-4">
                <div class="card">
                    <div class="card-header px-5 text-center" style="background-color:rgb(191, 191, 191)">
                        <h3>Admin Login</h3>
                        <%@include file="Components/alert_message.jsp"%>
                    </div>
                    <div class="card-body px-5">
                        <!--login-form-->
                        <form id="login-form" action="LoginServlet" method="post">
                            <input type="hidden" name="login" value="admin">
                            
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" placeholder="Email address" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" placeholder="Enter your password" class="form-control" required>
                            </div>

                            <div id="login-btn" class="container text-center mt-4">
                                <button type="submit" class="btn-custom">Login</button>
                            </div>
                        </form>
                    </div>  
                </div>
            </div>
        </div>
    </div>
</body>
</html>
