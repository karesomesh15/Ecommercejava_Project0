<%@page import="com.revature.model.Message"%>
<%@page import="com.revature.model.OrderedProduct"%>
<%@page import="com.revature.model.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.revature.dao.OrderedProductDao"%>
<%@page import="com.revature.dao.OrderDao"%>
<%@page import="com.revature.util.ConnectionProvider"%>
<%@page import="com.revature.model.User"%>
<%@page errorPage="error_exception.jsp"%>

<%
User u2 = (User) session.getAttribute("activeUser");
if (u2 == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;  
}
OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
OrderedProductDao ordProdDao = new OrderedProductDao(ConnectionProvider.getConnection());

List<Order> orderList = orderDao.getAllOrderByUserId(u2.getUserId());
%>
<div class="container-fluid px-3 py-3">
	<%
	if (orderList == null || orderList.size() == 0) {
	%>
	<div class="container mt-5 mb-5 text-center">
		<img src="Images/empty-cart.png" style="max-width: 200px;"
			class="img-fluid">
		<h4 class="mt-3">Zero Order found</h4>
		Looks like you haven't placed any order!
	</div>
	<%
	} else {
	%>
	<h4>My Order</h4>
	<hr>
	<div class="container">
		<table class="table table-striped">
		 <thead class="thead-dark">
			<tr class="text-center table-dark">
			 
			  <th>Product</th>
			  <th>Order ID</th>
			  <th>Name</th>
			  <th>Quantity</th>
			  <th>Total Price</th>
			  <th>Date and Time</th>
			  <th>Payment Type</th>
			  <th>Status</th>
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
                        <td colspan="5">No orders found.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
		</table>
	</div>
	<%
	}
	%>
</div>
