package com.revature.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

import com.revature.dao.OrderDao;
import com.revature.model.Admin;
import com.revature.model.Message;
import com.revature.model.Order;
import com.revature.util.ConnectionProvider;

public class DisplayOrderController extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");

        // Check if the admin is logged in
        if (activeAdmin == null) {
            Message message = new Message("You are not logged in! Login first!!", "error", "alert-danger");
            session.setAttribute("message", message);
            response.sendRedirect("adminlogin.jsp");
            return;
        }

        // Fetch orders
        OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
        List<Order> orderList = orderDao.getAllOrder();

        // Set the order list in the request scope
        request.setAttribute("orderList", orderList);

        // Forward to the JSP page
        request.getRequestDispatcher("display_order.jsp").forward(request, response);
    }
}