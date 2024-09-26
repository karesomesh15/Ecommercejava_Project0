<%@page import="com.revature.dao.WishlistDao"%>
<%@page import="com.revature.dao.ProductDao"%>
<%@page import="com.revature.model.Product"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
int productId = Integer.parseInt(request.getParameter("pid"));
ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
Product product = (Product) productDao.getProductsByProductId(productId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Product</title>
<%@include file="Components/common_css_js.jsp"%>
<style type="text/css">
    .product-view-container {
        max-width: 600px;
        margin: auto;
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        background-color: #f9f9f9;
    }
    
    .product-image {
        width: 100%;
        max-height: 500px;
        object-fit: cover;
        border-radius: 8px;
        margin-bottom: 20px;
    }
    
    .product-name {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 15px;
        text-align: center;
    }
    
    .product-price-container {
        text-align: center;
        margin-bottom: 15px;
    }
    
    .real-price {
        font-size: 28px;
        font-weight: 700;
        color: #e74c3c;
    }

    .product-price {
        font-size: 20px;
        text-decoration: line-through;
        color: #999;
    }

    .product-discount {
        font-size: 18px;
        color: #27ae60;
        font-weight: 600;
    }

    .product-status, .product-category {
        font-size: 18px;
        margin-bottom: 10px;
        text-align: center;
    }

    .product-description {
        margin-top: 15px;
        text-align: center;
        font-size: 16px;
        color: #555;
    }

    .action-buttons {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    .btn {
        width: 150px;
        margin: 0 10px;
    }
</style>
</head>
<body>

	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container mt-5">
		<%@include file="Components/alert_message.jsp"%>
		<div class="product-view-container">
			<img src="Product_imgs/<%=product.getProductImages()%>" class="product-image">
			
			<h4 class="product-name"><%=product.getProductName()%></h4>
			
			<div class="product-price-container">
				<span class="real-price">&#8377;<%=product.getProductPriceAfterDiscount()%></span>&ensp;
				<span class="product-price">&#8377;<%=product.getProductPrice()%></span>&ensp;
				<span class="product-discount"><%=product.getProductDiscount()%>&#37; off</span>
			</div>
			
			<div class="product-status">
				<b>Status:</b>
				<%
				if (product.getProductQunatity() > 0) {
					out.println("Available");
				} else {
					out.println("Currently Out of stock");
				}
				%>
			</div>
			
			<div class="product-category">
				<b>Category:</b> <%=catDao.getCategoryName(product.getCategoryId())%>
			</div>
			
			<div class="product-description">
				<b>Description:</b><br>
				<%=product.getProductDescription()%>
			</div>
			
			<form method="post">
				<div class="action-buttons">
					<%
					if (user == null) {
					%>
					<button type="button" onclick="window.open('login.jsp', '_self')" class="btn btn-primary text-white btn-lg">Add to Cart</button>
					<button type="button" onclick="window.open('login.jsp', '_self')" class="btn btn-info text-white btn-lg">Buy Now</button>
					<%
					} else {
					%>
					<button type="submit" formaction="./AddToCartServlet?uid=<%=user.getUserId()%>&pid=<%=product.getProductId()%>" class="btn btn-primary text-white btn-lg">Add to Cart</button>
					<a href="checkout.jsp" id="buy-btn" class="btn btn-info text-white btn-lg" role="button" aria-disabled="true">Buy Now</a>
					<%
					}
					%>
				</div>
			</form>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			if ($('#availability').text().trim() == "Currently Out of stock") {
				$('#availability').css('color', 'red');
				$('.btn').addClass('disabled');
			}
			$('#buy-btn').click(function(){
				<%
				session.setAttribute("pid", productId);
				session.setAttribute("from", "buy");
				%>	
				});
		});
	</script>
</body>
</html>
