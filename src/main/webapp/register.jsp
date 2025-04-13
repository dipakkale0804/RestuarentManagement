<%-- 
    Document   : register
    Created on : Feb 27, 2025, 10:20:53 AM
    Author     : Dipak Kale
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>
        
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        
        
        <div class="container-fluid">
            
            
        <div class="row mt-5">
            <div class="col-md-4 offset-md-4">
                
                
                
                
                <div class="card">
                    
                    <%@include file="components/message.jsp" %>

                    
                    <div class="card-body ">
                        
                        
                <h3 class="text-center my-3">Sign Up Here</h3>
                
                <form action="RegisterServlet" method="post">
                    
                    <div class="form-group">
                        <label for="name">User Name</label>
                        <input type="text" class="form-control" id="name" name="user_name" placeholder="Enter username">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">User Email</label>
                        <input type="email" class="form-control" id="email" name="user_email" placeholder="Enter email">
                    </div>
                    
                    <div class="form-group">
                        <label for="password">User Password</label>
                        <input type="password" class="form-control" id="password" name="user_password" placeholder="Enter password">
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">User Phone</label>
                        <input type="number" class="form-control" id="phone" name="user_phone" placeholder="Enter phone number">
                    </div>
                    
                    <div class="form-group">
                        <label for="address">User Address</label>
                        <textarea class="form-control" id="address" name="user_address" placeholder="Enter your address"></textarea>
                    </div>
                    
                    <div class="container text-center mt-3">
                        <button type="submit" class="btn btn-outline-success">Register</button>
                        <button type="reset" class="btn btn-outline-warning">Reset</button>
                    </div>
                    
                </form>
                        
                    </div>
                    
                </div>
                
            </div>
        </div>
            
        </div>
        
        
    </body>
</html>
