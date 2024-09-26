package com.revature.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.revature.dao.AdminDao;
import com.revature.dao.UserDao;
import com.revature.model.Admin;
import com.revature.model.Message;
import com.revature.model.User;
import com.revature.util.ConnectionProvider;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login = request.getParameter("login");

        if (login.trim().equals("user")) {
            try {
                String userEmail = request.getParameter("user_email");
                String userPassword = request.getParameter("user_password");

                // Getting user through entered email and password
                UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                User user = userDao.getUserByEmailPassword(userEmail, userPassword);

                HttpSession session = request.getSession();

                if (user != null) {
                    // Store the user object and user email in session
                    session.setAttribute("activeUser", user);
                    session.setAttribute("userEmail", userEmail);  // Set the user email in session
                    response.sendRedirect("index.jsp");
                } else {
                    Message message = new Message("Invalid details! Try again!!", "error", "alert-danger");
                    session.setAttribute("message", message);
                    response.sendRedirect("login.jsp");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (login.trim().equals("admin")) {
            try {
                String userName = request.getParameter("email");
                String password = request.getParameter("password");

                AdminDao adminDao = new AdminDao(ConnectionProvider.getConnection());
                Admin admin = adminDao.getAdminByEmailPassword(userName, password);

                HttpSession session = request.getSession();

                if (admin != null) {
                    session.setAttribute("activeAdmin", admin);
                    response.sendRedirect("admin.jsp");
                } else {
                    Message message = new Message("Invalid details! Try again!!", "error", "alert-danger");
                    session.setAttribute("message", message);
                    response.sendRedirect("adminlogin.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
