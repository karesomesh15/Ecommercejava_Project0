<%@page import="com.revature.dao.ProductDao"%>
<%@page import="com.revature.model.Product"%>
<%@page import="com.revature.util.ConnectionProvider"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
List<Product> productList = productDao.getAllLatestProducts();
List<Product> topDeals = productDao.getDiscountedProducts();


%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<%@include file="Components/common_css_js.jsp"%>


<style type="text/css">

*{
 background: ;
}
.hero-image {
        position: relative;
        width: 100%;
        height: 50vh; /* Adjust height as needed */
        overflow: hidden;
    }

    .hero-image img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
   }

    .hero-section {
        text-align: center;
        padding: 3rem 1rem;
        background-color: #e9ecef;
    }

    .hero-section img {
        max-width: 100%;
        height: auto;
        border-radius: 0.5rem;
    }
.cus-card {
	border-radius: 50%;
	border-color: transparent;
	max-height: 200px;
	max-width: 200px;
	max-height: 200px;
}

.real-price {
	font-size: 20px !important;
	font-weight: 600;
}

.product-price {
	font-size: 17px !important;
	text-decoration: line-through;
}

.product-discount {
	font-size: 15px !important;
	color: #027a3e;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>
	
	<!-- Hero Video Section -->
    <div class="hero-image">
        <img src="Images/bg.jpg">
    </div>

    <!-- Hero Section -->
    <div class="hero-section">
       
        <h1 class="my-3">Welcome to RevShop!</h1>
        <p style="font-size:20px;">Your one-stop shop for all your needs. Discover amazing products and deals.</p>
    </div>
	<!-- end of carousel -->

	
	
	
	<!-- Categories and Products Section -->
<!-- Categories and Products Section -->
<div class="container-fluid py-3 px-3 d-flex justify-content-center" style="background: #e9ecef;">
    <div class="w-100" style="max-width: 1200px;">
        <h2 class="my-3 p-2 text-center w-100" style="background: #ffffff;">Shop by Category</h2>
        <% 
        // Get the connection and DAOs
        CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
       

        // Fetch all categories
       

        // Iterate over categories
        for (Category category : categoryList) {
            // Fetch products by category
            List<Product> categoryProducts = productDao.getAllProductsByCategoryId(category.getCategoryId());
            if (!categoryProducts.isEmpty()) {
        %>
        <div class="py-3">
            <h4 class="text-center"><%= category.getCategoryName() %></h4>
            <div class="row row-cols-1 row-cols-md-4 g-3 justify-content-center" >
                <% 
                // Iterate over products in the category
                for (Product product : categoryProducts) {
                %>
                <div class="col">
                    <a href="viewProduct.jsp?pid=<%= product.getProductId() %>" style="text-decoration: none;">
                        <div class="card h-100" style="background-color:rgb(220, 220, 220)"	>
                            <div class="container text-center">
                                <img src="Product_imgs/<%= product.getProductImages() %>" class="card-img-top m-2" style="max-width: 100%; max-height: 200px; width: auto;">
                            </div>
                            <div class="card-body">
                                <h5 class="card-title text-center"><%= product.getProductName() %></h5>
                                <div class="container text-center">
                                    <span class="real-price">&#8377;<%= product.getProductPriceAfterDiscount() %></span>
                                    &ensp;<span class="product-price">&#8377;<%= product.getProductPrice() %></span>&ensp;
                                    <span class="product-discount"><%= product.getProductDiscount() %>&#37; off</span>
                                </div>
                            </div>
                        </div>
                    </a>
                </div>
                <% 
                } 
                %>
            </div>
        </div>
        <% 
            } 
        } 
        %>
    </div>
</div>
<!-- End of Categories and Products Section -->

<!-- latest product listed -->
	<div class="container-fluid py-3 px-3" style="background: #e9ecef;">
    <!-- Centered Heading -->
    <div class="row justify-content-center mb-4">
        <div class="col-12 text-center">
            <h1 class="" style="font-weight: normal;">New Products</h1>
        </div>
    </div>

    <!-- New Products Section -->
    <div class="row row-cols-1 row-cols-md-4 g-3 justify-content-center">
        <% 
        // Loop through the product list and display the products
        for (int i = 0; i < Math.min(3, productList.size()); i++) {
        %>
        <div class="col" >
            <a href="viewProduct.jsp?pid=<%= productList.get(i).getProductId() %>" style="text-decoration: none;">
                <div class="card h-100" style="background-color:rgb(220, 220, 220)">
                    <div class="container text-center">
                        <img src="Product_imgs/<%= productList.get(i).getProductImages() %>" class="card-img-top m-2" style="max-width: 100%; max-height: 200px; width: auto;">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title text-center"><%= productList.get(i).getProductName() %></h5>
                        <div class="container text-center">
                            <span class="real-price">&#8377;<%= productList.get(i).getProductPriceAfterDiscount() %></span>
                            &ensp;<span class="product-price">&#8377;<%= productList.get(i).getProductPrice() %></span>&ensp;
                            <span class="product-discount"><%= productList.get(i).getProductDiscount() %>&#37; off</span>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <% 
        }
        %>
    </div>
</div>

	<!-- end of list -->

	<!-- product with heavy deals -->
	<div class="container-fluid py-3 px-3" style="background: #e9ecef;">
    <!-- Centered Heading -->
    <div class="row justify-content-center mb-4">
        <div class="col-12 text-center">
            <h3 class="" style="font-size:30px;">Best Deals</h3>
        </div>
    </div>

    <!-- Hot Deals Section -->
    <div class="row row-cols-1 row-cols-md-4 g-3 justify-content-center">
        <% 
        // Loop through the top deals and display the products
        for (int i = 0; i < Math.min(4, topDeals.size()); i++) {
        %>
        <div class="col">
            <a href="viewProduct.jsp?pid=<%= topDeals.get(i).getProductId() %>" style="text-decoration: none;">
                <div class="card h-100"style="background-color:rgb(220, 220, 220)">
                    <div class="container text-center">
                        <img src="Product_imgs/<%= topDeals.get(i).getProductImages() %>" class="card-img-top m-2" style="max-width: 100%; max-height: 200px; width: auto;">
                    </div>
                    <div class="card-body">
                        <h5 class="card-title text-center"><%= topDeals.get(i).getProductName() %></h5>
                        <div class="container text-center">
                            <span class="real-price">&#8377;<%= topDeals.get(i).getProductPriceAfterDiscount() %></span>
                            &ensp;<span class="product-price">&#8377;<%= topDeals.get(i).getProductPrice() %></span>&ensp;
                            <span class="product-discount"><%= topDeals.get(i).getProductDiscount() %>&#37; off</span>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <% 
        }
        %>
    </div>
</div>

	<!-- end -->
	

<!-- Customer Testimonials Section -->
<div class="container-fluid py-5 px-3" style="background:  #e9ecef;">
    <h3 class="text-center mb-5">What Our Customers Are Saying</h3>
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4" >
        <!-- Testimonial 1 -->
        <div class="col" >
            <div class="card shadow-sm" style="background-color:rgb(220, 220, 220)">
                <div class="card-body text-center">
                    <img src="Images/people1.jpeg" class="rounded-circle mb-3" style="width: 100px; height: 100px; object-fit: cover;" alt="Customer 1">
                    <h5 class="card-title">John Doe</h5>
                    <p class="card-text">"This is the best e-commerce site I've ever used. The products are top-notch and the customer service is excellent!"</p>
                </div>
            </div>
        </div>
        <!-- Testimonial 2 -->
        <div class="col">
            <div class="card shadow-sm" style="background-color:rgb(220, 220, 220)">
                <div class="card-body text-center">
                    <img src="Images/people2.jpeg" class="rounded-circle mb-3" style="width: 100px; height: 100px; object-fit: cover;" alt="Customer 2">
                    <h5 class="card-title">Jane Smith</h5>
                    <p class="card-text">"I love the variety of products and the ease of shopping. Highly recommend this site to everyone!"</p>
                </div>
            </div>
        </div>
        <!-- Testimonial 3 -->
        <div class="col">
            <div class="card shadow-sm" style="background-color:rgb(220, 220, 220)">
                <div class="card-body text-center">
                    <img src="Images/people3.jpeg" class="rounded-circle mb-3" style="width: 100px; height: 100px; object-fit: cover;" alt="Customer 3">
                    <h5 class="card-title">Alex Johnson</h5>
                    <p class="card-text">"Excellent service and fast delivery. The products exceeded my expectations. Will definitely shop here again!"</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End of Customer Testimonials Section -->

	
	 <%@include file="Components/footer.jsp"%>

	<!-- confirmation message for successful order -->
	<%
	String order = (String) session.getAttribute("order");
	if (order != null) {
	%>
	<script type="text/javascript">
		console.log("testing..4...");
		Swal.fire({
		  icon : 'success',
		  title: 'Order Placed, Thank you!',
		  text: 'Confirmation will be sent to <%=user.getUserEmail()%>',
		  width: 600,
		  padding: '3em',
		  showConfirmButton : false,
		  timer : 3500,
		  backdrop: `
		    rgba(0,0,123,0.4)
		  `
		});
	</script>
	<%
	}
	session.removeAttribute("order");
	%>
	<!-- end of message -->
	
</body>
</html>