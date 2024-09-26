<%@page import="com.revature.model.Message"%>
<%@page import="com.revature.dao.ProductDao"%>
<%@page import="com.revature.dao.CartDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_exception.jsp"%>
<%
User activeUser = (User) session.getAttribute("activeUser");
if (activeUser == null) {
	Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;  
}
String from = (String)session.getAttribute("from");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
    .card {
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    .card-header {
        background-color: rgb(191, 191, 191);
        color: white;
        padding: 1rem;
        border-bottom: 1px solid #ddd;
    }

    .price-details-table td {
        padding: 0.5rem;
    }

    .section {
        margin-bottom: 2rem;
    }

    .section h4 {
        margin-bottom: 1rem;
    }

    .btn-primary {
        background-color: #389aeb;
        border-color: #389aeb;
    }

    .btn-primary:hover {
        background-color: #317ab2;
        border-color: #317ab2;
    }
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container mt-5" style="font-size: 17px;">
		<div class="row">
			<!-- Price Details Section -->
			<div class="col-md-12 section">
				<div class="card" >
					<div class="card-header">
						<h4>Price Details</h4>
					</div>
					<div class="card-body" style="font-size: 17px;">
						<%
						if (from.trim().equals("cart")) {
							CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
							int totalProduct = cartDao.getCartCountByUserId(user.getUserId());
							float totalPrice = (float) session.getAttribute("totalPrice");
						%>
						<table class="table table-borderless price-details-table" >
							<tr >
								<td>Total Item</td>
								<td class="text-end"><%=totalProduct%></td>
							</tr>
							<tr>
								<td>Total Price</td>
								<td class="text-end">&#8377; <%=totalPrice%></td>
							</tr>
							<tr>
								<td>Delivery Charges</td>
								<td class="text-end">&#8377; 40</td>
							</tr>
							<tr>
								<td>Packaging Charges</td>
								<td class="text-end">&#8377; 29</td>
							</tr>
							<tr>
								<td><h5>Amount Payable :</h5></td>
								<td class="text-end"><h5>&#8377; <%=totalPrice + 69%></h5></td>
							</tr>
						</table>
						<%
						} else {
							ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
							int pid = (int) session.getAttribute("pid");
							float price = productDao.getProductPriceById(pid);
						%>
						<table class="table table-borderless price-details-table">
							<tr>
								<td>Total Item</td>
								<td class="text-end">1</td>
							</tr>
							<tr>
								<td>Total Price</td>
								<td class="text-end">&#8377; <%=price%></td>
							</tr>
							<tr>
								<td>Delivery Charges</td>
								<td class="text-end">&#8377; 40</td>
							</tr>
							<tr>
								<td>Packaging Charges</td>
								<td class="text-end">&#8377; 29</td>
							</tr>
							<tr>
								<td><h5>Amount Payable :</h5></td>
								<td class="text-end"><h5>&#8377; <%=price + 69%></h5></td>
							</tr>
						</table>
						<%
						}
						%>
					</div>
				</div>
			</div>
			
			<!-- Delivery Address Section -->
			<div class="col-md-12 section">
				<div class="card">
					<div class="card-header">
						<h4>Delivery Address</h4>
					</div>
					<div class="card-body">
						<h5><%=user.getUserName()%> &nbsp; <%=user.getUserPhone()%></h5>
						<%
						StringBuilder str = new StringBuilder();
						str.append(user.getUserAddress() + ", ");
						str.append(user.getUserCity() + ", ");
						str.append(user.getUserState() + ", ");
						str.append(user.getUserPincode());
						out.println(str);
						%>
						<br>
						<div class="text-end">
							<button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">
								Change Address
							</button>
						</div>
					</div>
				</div>
			</div>

			<!-- Payment Options Section -->
			<div class="col-md-12 section">
				<div class="card">
					<div class="card-header">
						<h4>Payment Options</h4>
					</div>
					<div class="card-body">
						<form action="OrderOperationServlet" method="post">
							<div class="form-check mt-2">
								<input class="form-check-input" type="radio" name="payementMode" value="Card Payment" required>
								<label class="form-check-label">Credit/Debit/ATM card</label>
								<div class="mb-3 mt-3">
									<input class="form-control" type="number" placeholder="Enter card number" name="cardno">
									<div class="row gx-5 mt-3">
										<div class="col">
											<input class="form-control" type="number" placeholder="Enter CVV" name="cvv">
										</div>
										<div class="col">
											<input class="form-control" type="text" placeholder="Valid through i.e '01/29'">
										</div>
									</div>
									<input class="form-control mt-3" type="text" placeholder="Enter card holder name" name="name">
								</div>
								<input class="form-check-input" type="radio" name="payementMode" value="Cash on Delivery">
								<label class="form-check-label">Cash on Delivery</label>
							</div>
							<div class="text-end mt-3">
								<button type="submit" class="btn btn-outline-primary">Place Order</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

    <!--Change Address Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Change Address</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="UpdateUserServlet" method="post">
                    <input type="hidden" name="operation" value="changeAddress">
                    <div class="modal-body mx-3">
                        <div class="mt-2">
                            <label class="form-label fw-bold">Address</label>
                            <textarea name="user_address" rows="3" placeholder="Enter Address (Area and Street)" class="form-control" required></textarea>
                        </div>
                        <div class="mt-2">
                            <label class="form-label fw-bold">City</label>
                            <input class="form-control" type="text" name="city" placeholder="City/District/Town" required>
                        </div>
                        <div class="mt-2">
                            <label class="form-label fw-bold">Pincode</label>
                            <input class="form-control" type="number" name="pincode" placeholder="Pincode" maxlength="6" required>
                        </div>
                        <div class="mt-2">
                            <label class="form-label fw-bold">State</label>
                            <select name="state" class="form-select">
                                <option selected>--Select State--</option>
                                <option value="Andaman &amp; Nicobar Islands">Andaman &amp; Nicobar Islands</option>
                                <option value="Andhra Pradesh">Andhra Pradesh</option>
                                <option value="Arunachal Pradesh">Arunachal Pradesh</option>
                                <option value="Assam">Assam</option>
                                <option value="Bihar">Bihar</option>
                                 <option value="Chandigarh">Chandigarh</option>
                                <option value="Chhattisgarh">Chhattisgarh</option>
                                <option value="Dadra and Nagar Haveli and Daman and Diu">Dadra and Nagar Haveli and Daman and Diu</option>
                                <option value="Delhi">Delhi</option>
                                <option value="Goa">Goa</option>
                                <option value="Gujarat">Gujarat</option>
                                <option value="Haryana">Haryana</option>
                                <option value="Himachal Pradesh">Himachal Pradesh</option>
                                <option value="Jharkhand">Jharkhand</option>
                                <option value="Karnataka">Karnataka</option>
                                <option value="Kerala">Kerala</option>
                                <option value="Ladakh">Ladakh</option>
                                <option value="Lakshadweep">Lakshadweep</option>
                                <option value="Ladakh">Ladakh</option>
                                <option value="Madhya Pradesh">Madhya Pradesh</option>
                                <option value="Maharashtra">Maharashtra</option>
                                <option value="Manipur">Manipur</option>
                                <option value="Meghalaya">Meghalaya</option>
                                <option value="Mizoram">Mizoram</option>
                                <option value="Nagaland">Nagaland</option>
                                <option value="Odisha">Odisha</option>
                                <option value="Puducherry">Puducherry</option>
                                <option value="Punjab">Punjab</option>
                                <option value="Rajasthan">Rajasthan</option>
                                <option value="Sikkim">Sikkim</option>
                                <option value="Tamil Nadu">Tamil Nadu</option>
                                <option value="Telangana">Telangana</option>
                                <option value="Tripura">Tripura</option>
                                <option value="Uttar Pradesh">Uttar Pradesh</option>
                                <option value="Uttarakhand">Uttarakhand</option>
                                <option value="West Bengal">West Bengal</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
   

    <!-- Scripts -->
   
</body>
</html>

