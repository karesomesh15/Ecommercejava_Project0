package com.revature.util;

import java.sql.Connection;
import java.sql.DriverManager;
import jakarta.servlet.http.HttpServlet;

public class ConnectionProvider extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private static Connection connection;

	public static Connection getConnection() {

		try {
			if (connection == null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/revshop", "root", "Kare@1234");
				System.out.println("Successfully Connected");			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}

}
