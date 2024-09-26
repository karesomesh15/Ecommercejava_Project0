package com.revature.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.service.OrderService;
import com.serviceImpl.OrderServiceImpl;
import com.revature.dao.OrderedProductDao;
import com.revature.util.ConnectionProvider;
import com.revature.model.OrderedProduct;

public class DisplayOrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private OrderService orderedProductService;

    @Override
    public void init() throws ServletException {
        super.init();
        OrderedProductDao orderedProductDao = new OrderedProductDao(ConnectionProvider.getConnection());
        this.orderedProductService = new OrderServiceImpl(orderedProductDao);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch all ordered products
        List<OrderedProduct> orderedProducts = orderedProductService.getAllOrderedProducts();
        request.setAttribute("orderedProducts", orderedProducts);

        // Forward to JSP
        request.getRequestDispatcher("display_orders.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
