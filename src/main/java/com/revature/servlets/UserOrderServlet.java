package com.revature.servlets;

import com.revature.model.OrderedProduct;
import com.service.OrderService;
import com.serviceImpl.OrderServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.revature.dao.OrderedProductDao;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;




@WebServlet("/UserOrderServlet")
public class UserOrderServlet extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        // Initialize the OrderService with DAO
        Connection con = (Connection) getServletContext().getAttribute("DBConnection");
        orderService = new OrderServiceImpl(new OrderedProductDao(con));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve session
        HttpSession session = request.getSession(false); // Use false to avoid creating a new session
        if (session == null) {
            System.err.println("Session does not exist. Redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }
       
        // Retrieve user email from session
        String email = (String) session.getAttribute("userEmail");
        System.out.println("User email from session: " + email);

        if (email != null && !email.isEmpty()) {
            try {
                // Fetch orders for the user
                List<OrderedProduct> orders = orderService.getOrdersByEmail(email);
                if (orders.isEmpty()) {
                    System.out.println("No orders found for email: " + email);
                } else {
                    System.out.println("Orders found for email: " + email);
                }

                // Set orders in request and forward to order.jsp
                request.setAttribute("orderedProducts", orders);
                request.getRequestDispatcher("/order.jsp").forward(request, response);
            } catch (Exception e) {
                System.err.println("Error while fetching orders: " + e.getMessage());
                e.printStackTrace();  // Log the exception
                response.sendRedirect("error.jsp");  // Redirect to an error page
            }
        } else {
            System.err.println("User email is not available in session. Redirecting to login.");
            response.sendRedirect("login.jsp");  // Redirect to login if email is not present
        }
    }
}
