
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.revature.model.Order"%>
<%@ page import="com.revature.model.OrderedProduct"%>
<%@ page import="java.util.List"%>
<%@ page errorPage="error_exception.jsp"%>
<%@ page import="com.revature.model.Message" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <!-- Include your common CSS and JS here -->
    <%@include file="Components/common_css_js.jsp"%>
</head>
<body>
    <!-- Include your navbar here -->
    <%@include file="Components/navbar.jsp"%>

    <div class="container mt-5">
        <h2>Ordered Products</h2>
        <table class="table table-bordered table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Image</th>
                    <th>Total Price</th>
                </tr>
            </thead>
<tbody>
                <%
                    List<OrderedProduct> orderedProducts = (List<OrderedProduct>) request.getAttribute("orderedProducts");
                    if (orderedProducts != null) {
                        for (OrderedProduct orderProd : orderedProducts) {
                %>
                    <tr>
                        <td><%= orderProd.getName() %></td>
                        <td><%= orderProd.getQuantity() %></td>
                        <td>&#8377;<%= orderProd.getPrice() %></td>
                        <td>
                            <img src="Product_imgs/<%= orderProd.getImage() %>" alt="<%= orderProd.getName() %>" style="width: 50px; height: 50px;">
                        </td>
                        <td>&#8377;<%= orderProd.getPrice() * orderProd.getQuantity() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5">No ordered products available</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
