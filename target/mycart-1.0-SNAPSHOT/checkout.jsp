<%-- 
    Document   : checkout
    Created on : Mar 1, 2025, 11:28:05 PM
    Author     : Dipak Kale
--%>

<!-- if login then only checkout -->
<%
    User user = (User) session.getAttribute("current-user");

    if (user == null) {
        session.setAttribute("message", "You are not logged in ! Login first to access checkout page");
        response.sendRedirect("login.jsp");
        return;
    }  
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>

        <%@include file="components/navbar.jsp" %>

        <div class="container">

            <div class="row mt-5">

                <div class="col-md-6">
                    <!-- Card for selected items -->
                    <div class="card">
                        <h4 class="my-3">Your Selected Items</h4>
                        <div class="cart-body">
                            <!-- Cart items will be displayed here -->
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <!-- Form for order details -->
                    <div class="card">
                        <h4 class="my-3">Your Details For Order</h4>
                        <form action="#!">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label>
                                <input value="<%= user.getUserEmail() %>" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>

                            <div class="form-group">
                                <label for="name">Your Name</label>
                                <input value="<%= user.getUserName() %>" type="text" class="form-control" id="name" aria-describedby="enter name">
                            </div>

                            <div class="form-group">
                                <label for="contact">Your Contact</label>
                                <input value="<%= user.getUserPhone() %>" type="text" class="form-control" id="contact" aria-describedby="enter contact no">
                            </div>

                            <div class="form-group">
                                <label for="exampleFormControlTextarea1">Your Shipping Address</label>
                                <textarea class="form-control" id="exampleFormControlTextarea1" placeholder="Enter your address" rows="3"><%= user.getUserAddress() %></textarea>
                            </div>
                            
                            <div class="container">
                                <button type="submit" class="btn btn-outline-success">Order Now</button>
                                <button type="button" class="btn btn-outline-primary">Continue Shopping</button>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>

        <%@include file="components/common_modals.jsp"  %>
    </body>
</html>
