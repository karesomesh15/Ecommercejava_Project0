package com.revature.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.revature.model.OrderedProduct;

public class OrderedProductDao {
	private Connection con;

	public OrderedProductDao(Connection con) {
		super();
		this.con = con;
	}
	
	public void insertOrderedProduct(OrderedProduct ordProduct) {
		try {
			String query = "insert into ordered_product(name, quantity, price, image, orderid) values(?, ?, ?, ?, ?)";
			PreparedStatement psmt = this.con.prepareStatement(query);
			psmt.setString(1, ordProduct.getName());
			psmt.setInt(2, ordProduct.getQuantity());
			psmt.setFloat(3,ordProduct.getPrice());
			psmt.setString(4, ordProduct.getImage());
			psmt.setInt(5, ordProduct.getOrderId());

			psmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	 public List<OrderedProduct> getAllOrderedProduct() {
	        List<OrderedProduct> list = new ArrayList<>();
	        try {
	            String query = "select * from ordered_product";
	            PreparedStatement psmt = this.con.prepareStatement(query);
	            ResultSet rs = psmt.executeQuery();
	            while (rs.next()) {
	                OrderedProduct orderProd = new OrderedProduct();
	                orderProd.setName(rs.getString("name"));
	                orderProd.setQuantity(rs.getInt("quantity"));
	                orderProd.setPrice(rs.getFloat("price"));
	                orderProd.setImage(rs.getString("image"));
	                orderProd.setOrderId(rs.getInt("orderid"));  // Assuming `orderid` is in the table

	                list.add(orderProd);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list;
	    }
	 
	 public List<OrderedProduct> getOrderedProductsByEmail(String email) {
		    List<OrderedProduct> list = new ArrayList<>();
		    System.out.println("Fetching orders for email: " + email);  // Debugging statement
		    try {
		        String query = "SELECT * FROM ordered_product WHERE email = ?";
		        PreparedStatement psmt = this.con.prepareStatement(query);
		        psmt.setString(1, email);
		        ResultSet rs = psmt.executeQuery();

		        while (rs.next()) {
		            OrderedProduct orderProd = new OrderedProduct();
		            orderProd.setName(rs.getString("name"));
		            orderProd.setQuantity(rs.getInt("quantity"));
		            orderProd.setPrice(rs.getFloat("price"));
		            orderProd.setImage(rs.getString("image"));
		            orderProd.setOrderId(rs.getInt("orderid"));

		            list.add(orderProd);
		        }
		        
		        System.out.println("Total orders fetched: " + list.size());  // Debugging statement

		    } catch (Exception e) {
		        System.err.println("Error fetching orders: " + e.getMessage());
		        e.printStackTrace();
		    }
		    return list;
		}



}
