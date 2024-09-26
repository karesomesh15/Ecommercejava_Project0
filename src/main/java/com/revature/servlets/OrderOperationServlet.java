package com.revature.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.revature.dao.CartDao;
import com.revature.dao.OrderDao;
import com.revature.dao.OrderedProductDao;
import com.revature.dao.ProductDao;
import com.revature.model.Cart;
import com.revature.model.Order;
import com.revature.model.OrderedProduct;
import com.revature.model.Product;
import com.revature.model.User;
import com.revature.util.ConnectionProvider;
import com.revature.util.MailMessenger;
import com.revature.util.OrderIdGenerator;

public class OrderOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		String from = (String) session.getAttribute("from");
		String paymentType = request.getParameter("payementMode");
		User user = (User) session.getAttribute("activeUser");
		String orderId = OrderIdGenerator.getOrderId();
		String status = "Order Placed";

		if (from.trim().equals("cart")) {
			try {

				Order order = new Order(orderId, status, paymentType, user.getUserId());
				OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
				int id = orderDao.insertOrder(order);

				CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
				List<Cart> listOfCart = cartDao.getCartListByUserId(user.getUserId());
				OrderedProductDao orderedProductDao = new OrderedProductDao(ConnectionProvider.getConnection());
				ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
				for (Cart item : listOfCart) {

					Product prod = productDao.getProductsByProductId(item.getProductId());
					String prodName = prod.getProductName();
					int prodQty = item.getQuantity();
					float price = prod.getProductPriceAfterDiscount();
					String image = prod.getProductImages();

					OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
					orderedProductDao.insertOrderedProduct(orderedProduct);
				}
				session.removeAttribute("from");
				session.removeAttribute("totalPrice");
				
				//removing all product from cart after successful order
				cartDao.removeAllProduct();

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (from.trim().equals("buy")) {

			try {

				int pid = (int) session.getAttribute("pid");
				Order order = new Order(orderId, status, paymentType, user.getUserId());
				OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
				int id = orderDao.insertOrder(order);
				OrderedProductDao orderedProductDao = new OrderedProductDao(ConnectionProvider.getConnection());
				ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());

				Product prod = productDao.getProductsByProductId(pid);
				String prodName = prod.getProductName();
				int prodQty = 1;
				float price = prod.getProductPriceAfterDiscount();
				String image = prod.getProductImages();

				OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
				orderedProductDao.insertOrderedProduct(orderedProduct);
				
				//updating(decreasing) quantity of product in database
				productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) - 1);
				
				session.removeAttribute("from");
				session.removeAttribute("pid");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	    session.setAttribute("order", "success");
	    MailMessenger.successfullyOrderPlaced(user.getUserName(), user.getUserEmail(), orderId, new Date().toString());
        response.sendRedirect("index.jsp");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

}
