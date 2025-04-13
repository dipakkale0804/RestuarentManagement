package com.learn.mycart.servlets;

import com.learn.mycart.helper.FactoryProvider;
import com.learn.mycart.entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Dipak Kale
 */

public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            try {
                // Fetching form data
                String userName = request.getParameter("user_name");
                String userEmail = request.getParameter("user_email");
                String userPassword = request.getParameter("user_password");
                String userPhone = request.getParameter("user_phone");
                String userAddress = request.getParameter("user_address");

                // Validating user input
                if (userName == null || userName.isEmpty()) {
                    out.println("Name is blank");
                    return;
                }

                // Creating user object
                User user = new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress, "normal");

                // Hibernate session
                Session hibernateSession = FactoryProvider.getFactory().openSession();
                
                if (hibernateSession == null) {
                    throw new ServletException("Hibernate session factory is not initialized properly.");
                }

                Transaction tx = hibernateSession.beginTransaction();
                int userId = (int) hibernateSession.save(user);
                tx.commit();
                hibernateSession.close();

                // Storing message in session
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Registration Successful...! User ID: " + userId);

                // Redirecting to register page
                response.sendRedirect("register.jsp");
                return;

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Something went wrong! Please try again.");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles user registration";
    }
}
