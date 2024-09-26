package com.serviceImpl;

import java.util.List;
import com.revature.dao.OrderedProductDao;
import com.revature.model.OrderedProduct;
import com.service.OrderService;

public class OrderServiceImpl implements OrderService {
    private OrderedProductDao orderedProductDao;

    public OrderServiceImpl(OrderedProductDao orderedProductDao) {
        this.orderedProductDao = orderedProductDao;
    }

    @Override
    public List<OrderedProduct> getAllOrderedProducts() {
        return orderedProductDao.getAllOrderedProduct();
    }
    @Override
    public List<OrderedProduct> getOrdersByEmail(String email) {
        return orderedProductDao.getOrderedProductsByEmail(email);
    }
}
