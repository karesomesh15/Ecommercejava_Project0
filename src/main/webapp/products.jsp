<%@page import="com.revature.dao.WishlistDao"%>
<%@page import="com.revature.model.User"%>
<%@page import="com.revature.dao.CategoryDao"%>
<%@page import="com.revature.model.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.revature.util.ConnectionProvider"%>
<%@page import="com.revature.dao.ProductDao"%>
<%
User u = (User) session.getAttribute("activeUser");
WishlistDao wishlistDao = new WishlistDao(ConnectionProvider.getConnection());

String searchKey = request.getParameter("search");
String catId = request.getParameter("category");
CategoryDao categoryDao = new CategoryDao(ConnectionProvider.getConnection());
String message = "";

ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
List<Product> prodList = null;
if (searchKey != null) {
    if (!searchKey.isEmpty()) {
        message = "Showing results for \"" + searchKey + "\"";
    } else {
        message = "No product found!";
    }
    prodList = productDao.getAllProductsBySearchKey(searchKey);
} else if (catId != null && !(catId.trim().equals("0"))) {
    prodList = productDao.getAllProductsByCategoryId(Integer.parseInt(catId.trim()));
    message = "Showing results for \"" + categoryDao.getCategoryName(Integer.parseInt(catId.trim())) + "\"";
} else {
    prodList = productDao.getAllProducts();
    message = "All Products";
}

if (prodList != null && prodList.size() == 0) {
    message = "No items are available for \""
        + (searchKey != null ? searchKey : categoryDao.getCategoryName(Integer.parseInt(catId.trim()))) + "\"";
    prodList = productDao.getAllProducts();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
    body {
        background-color: #f5f5f5;
    }
    .real-price {
        font-size: 20px;
        font-weight: bold;
        color: #4CAF50;
    }
    .product-price {
        font-size: 16px;
        text-decoration: line-through;
        color: #9E9E9E;
    }
    .product-discount {
        font-size: 14px;
        color: #FF5722;
    }
    .wishlist-icon {
        cursor: pointer;
        position: absolute;
        right: 10px;
        top: 10px;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        border: 1px solid #e0e0e0;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        background-color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .wishlist-icon i {
        font-size: 20px;
    }
    .card {
        border: none;
        border-radius: 12px;
        overflow: hidden;
        transition: transform 0.3s, box-shadow 0.3s;
        background-color: #fff;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        max-width: 280px; /* Minimized card width */
        margin: 0 auto; /* Center card horizontally */
    }
    .card:hover {
        transform: scale(1.05);
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }
    .card-img-top {
        border-bottom: 2px solid #e0e0e0;
        background-color: #f8f8f8;
    }
    .card-body {
        background-color: #fff;
        padding: 15px;
        text-align: center;
    }
    .card-title {
        font-size: 18px;
        font-weight: 500;
        color: #333;
    }
    .btn-primary {
        background-color: #FF5722;
        border: none;
        transition: background-color 0.3s;
    }
    .btn-primary:hover {
        background-color: #E64A19;
    }
    .container-fluid {
        padding-left: 30px;
        padding-right: 30px;
    }
    .row-cols-md-3 {
        display: flex;
        justify-content: center;
    }
</style>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- Show products -->
    <h4 class="text-center mt-2"><%= message %></h4>
    <div class="container-fluid my-3 px-5 ">
        <div class="row row-cols-1 row-cols-md-3 g-4 ">
            <% for (Product p : prodList) { %>
            <div class="col d-flex justify-content-center ">
                <div class="card h-100 position-relative " style="background-color:rgb(220, 220, 220)">
                    <div class="wishlist-icon">
                        <%
                        if (u != null) {
                            if (wishlistDao.getWishlist(u.getUserId(), p.getProductId())) {
                        %>
                        <button onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=remove', '_self')" class="btn btn-link" type="submit">
                            <i class="fa-sharp fa-solid fa-heart" style="color: #FF5722;"></i>
                        </button>
                        <% } else { %>
                        <button type="submit" onclick="window.open('WishlistServlet?uid=<%=u.getUserId()%>&pid=<%=p.getProductId()%>&op=add', '_self')" class="btn btn-link">
                            <i class="fa-sharp fa-solid fa-heart" style="color: #9E9E9E;"></i>
                        </button>
                        <% } } else { %>
                        <button onclick="window.open('login.jsp', '_self')" class="btn btn-link" type="submit">
                            <i class="fa-sharp fa-solid fa-heart" style="color: #9E9E9E;"></i>
                        </button>
                        <% } %>
                    </div>
                    <div class="container text-center">
                        <img src="Product_imgs/<%= p.getProductImages() %>" class="card-img-top m-2" style="max-width: 100%; max-height: 200px; width: auto;">
                    </div>
                    <div class="card-body " style="background-color:rgb(220, 220, 220)">
                        <h5 class="card-title"><%= p.getProductName() %></h5>
                        <div class="container text-center">
                            <span class="real-price">&#8377;<%= p.getProductPriceAfterDiscount() %></span>
                            &ensp;<span class="product-price">&#8377;<%= p.getProductPrice() %></span>
                            &ensp;<span class="product-discount"><%= p.getProductDiscount() %>&#37; off</span>
                        </div>
                        <div class="container text-center mb-2 mt-2">
                            <button type="button" onclick="window.open('viewProduct.jsp?pid=<%= p.getProductId() %>', '_self')" class="btn btn-primary text-white">View Details</button>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>
