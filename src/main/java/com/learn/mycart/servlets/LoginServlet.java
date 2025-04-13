package com.learn.mycart.servlets;

import com.learn.mycart.dao.UserDao;
import com.learn.mycart.entities.User;
import com.learn.mycart.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Dipak Kale
 */
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            // Get user input
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validate input (optional)
            if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
                out.println("Email and Password cannot be empty.");
                return;
            }

            // Authenticate user
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            User user = userDao.getUserByEmailAndPassword(email, password);

            HttpSession httpSession = request.getSession();
            
            if(user==null){
                out.println("<h1>Invalid Details</h1>");
                httpSession.setAttribute("message","Invalid Details");
                response.sendRedirect("login.jsp");
                return;
                
                
                
            }
            else
            {
                out.println("<h1>Welcome "+user.getUserName()+"</h1>");
                
                //login
                httpSession.setAttribute("current-user",user);
                
                
                if(user.getUserType().equals("admin"))
                {
                      //admin.jsp
                    response.sendRedirect("admin.jsp");
                }else if(user.getUserType().equals("normal"))
                {
                    //normal.jsp
                    response.sendRedirect("normal.jsp");
                }else{
                    out.println("We have not identified user type");
                }
                
              
                
                
                
                
                
                
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
        return "Handles user login authentication.";
    }
}
