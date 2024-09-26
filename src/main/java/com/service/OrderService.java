package com.service;

import java.util.List;
import com.revature.model.OrderedProduct;

public interface OrderService {
    List<OrderedProduct> getAllOrderedProducts();
    List<OrderedProduct> getOrdersByEmail(String email);
}
