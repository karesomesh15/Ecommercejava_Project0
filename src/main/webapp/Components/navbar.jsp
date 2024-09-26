<%@page import="com.revature.model.Admin"%>
<%@page import="com.revature.model.Cart"%>
<%@page import="com.revature.dao.CartDao"%>
<%@page import="com.revature.model.User"%>
<%@page import="java.util.List"%>
<%@page import="com.revature.model.Category"%>
<%@page import="com.revature.util.ConnectionProvider"%>
<%@page import="com.revature.dao.CategoryDao"%>
<%
User user = (User) session.getAttribute("activeUser");
Admin admin = (Admin) session.getAttribute("activeAdmin");

CategoryDao catDao = new CategoryDao(ConnectionProvider.getConnection());
List<Category> categoryList = catDao.getAllCategories();
%>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

<style>
.navbar {
	font-weight: 500;
	background-color:#f8f9fa;
}

.navbar-logo {
    height: 30px; /* Adjust the height as needed */
    margin-right: 10px; /* Space between the image and the home icon */
    margin-left: 10px; 
    width:100px;/* Space from the left side */
}

.nav-link {
	color: rgb(255 255 255/ 100%) !important;
}

.dropdown-menu {
	background-color: #ffffff !important;
	border-color: #949494;
}

.dropdown-menu li a:hover {
	background-color: #808080 !important;
	color: white;
}
.form-control:focus {
    box-shadow: none;
    outline: none;
}

.nav-link, .navbar-brand, .dropdown-menu a {
    color: #000000 !important; /* Black color for text */
}

.form-control {
    background-color: #ffffff !important; /* White background for input */
    color: #000000 !important; /* Black text color for input */
}

.btn-outline-light {
    color: #000000 !important; /* Black text color for button */
    border-color: #000000 !important; /* Black border color */
}

.btn-outline-light:hover {
    color: #000000 !important; 
    background-color: #e9ecef !important; /* Optional: Light gray background on hover */
}
</style>
<nav class="navbar navbar-expand-lg" data-bs-theme="dark">

	<!-- admin nav bar -->
	<%
	if (admin != null) {
	%>
	<div class="container">
		
		<a class="navbar-brand" href="admin.jsp"><i
			class="fa-sharp fa-solid fa-house" style="color: black; text-color:black;">
			</i>&ensp;<img src="Images/revshop.png" alt="Logo" class="navbar-logo"></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">

			<div class="container text-end">
				<ul class="navbar-nav justify-content-end">
					<li class="nav-item"><button type="button"
							class="btn nav-link" data-bs-toggle="modal"
							data-bs-target="#add-category">Add Category</button></li>
					<li class="nav-item"><button type="button"
							class="btn nav-link" data-bs-toggle="modal"
							data-bs-target="#add-product">Add Product</button></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="admin.jsp"><%=admin.getName()%></a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="LogoutServlet?user=admin"><i
							class="fa-solid fa-user-slash fa-sm" style="color: #fafafa;"></i>&nbsp;Logout</a></li>
				</ul>
			</div>
		</div>
	</div>
	<%
	} else {
	%>

	<!-- end -->

	<!-- for all -->
	<div class="container">
		
		<a class="navbar-brand" href="index.jsp"><i
			class="fa-sharp fa-solid fa-house" style="color: black;text-color:black;"></i>&ensp;
			<img src="Images/revshop.png" alt="Logo" class="navbar-logo"></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<!-- <li class="nav-item"><a class="nav-link" href="products.jsp"
					role="button" aria-expanded="false"> Products </a>
 -->				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" role="button"
					data-bs-toggle="dropdown" aria-expanded="false"> Category </a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="products.jsp?category=0">All
								Products</a></li>
						<%
						for (Category c : categoryList) {
						%>
						<li><a class="dropdown-item"
							href="products.jsp?category=<%=c.getCategoryId()%>"><%=c.getCategoryName()%></a></li>
						<%
						}
						%>
					</ul></li>
			</ul>
			<form class="d-flex pe-5" role="search" action="products.jsp"
				method="get">
				<input name="search" class="form-control me-2" size="50"
					type="search" placeholder="Search for products" aria-label="Search"
					style="background-color: white !important;">
				<button class="btn btn-outline-light" type="submit">Search</button>
			</form>

			<!-- when user is logged in -->
			<%
			if (user != null) {
				CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
				int cartCount = cartDao.getCartCountByUserId(user.getUserId());
			%>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active pe-3"><a
					class="nav-link position-relative" aria-current="page"
					href="cart.jsp"><i class="fa-solid fa-cart-shopping"
						style="color: black;"></i> &nbsp;Cart<span
						class="position-absolute top-1 start-0 translate-middle badge rounded-pill bg-danger"><%=cartCount%></span></a></li>
				<li class="nav-item active pe-3"><a class="nav-link"
					aria-current="page" href="profile.jsp"><%=user.getUserName()%></a></li>
				<li class="nav-item pe-3"><a class="nav-link"
					aria-current="page" href="LogoutServlet?user=user"><i
						class="fa-solid fa-user" style="color: #fafafa;"></i>&nbsp;Logout</a></li>
			</ul>
			<%
			} else {
			%>
			<ul class="navbar-nav ml-auto">
				<!-- <li class="nav-item active pe-2"><a class="nav-link"
					aria-current="page" href="register.jsp"> <i
						class="fa-solid fa-user-plus" style="color: #ffffff;"></i>&nbsp;Register
				</a></li> -->
				<li class="nav-item pe-2"><a class="nav-link"
					aria-current="page" href="login.jsp"><i
						class="fa-solid fa-user" style="color:black;"></i>&nbsp;Login</a></li>
				<li class="nav-item pe-2"><a class="nav-link"
					aria-current="page" href="adminlogin.jsp">&nbsp;Admin</a></li>
			</ul>

		</div>
	</div>
	<%
	}
	}
	%>
	<!-- end  -->
</nav>

