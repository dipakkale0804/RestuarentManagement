<%-- 
    Document   : index
    Created on : Feb 26, 2025, 5:20:04 PM
    Author     : Dipak Kale
--%>

<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyCart - Home</title>
        <%@include file="components/common_css_js.jsp" %>

        <style>
            body {
                background: url('img/resto.jpg') no-repeat center center fixed;
                background-size: cover;
                position: relative;
                margin: 0;
                padding: 0;
                height: 100vh; /* Ensures full-screen coverage */
            }

            body::before {
                content: "";
                position: fixed; /* Changed from absolute to fixed */
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(0, 0, 0, 0.5); /* Adjust opacity as needed */
                z-index: 0;
            }

            .container-fluid, .row {
                position: relative;
                z-index: 1; /* Ensures content is above the dark overlay */
            }

            .product-card {
                background: rgba(255, 255, 255, 0.9);
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .card-footer .discount-label {
                font-size: 14px;
                text-decoration: line-through;
            }
            .list-group-item.active {
                background-color: #ff5722;
                border-color: #ff5722;
            }
            .custom-bg {
                background-color: #ff5722;
                color: white;
            }
        </style>
    </head>
    <body>

        <%@include file="components/navbar.jsp" %>

        <div class="container-fluid">
            <div class="row mt-3 mx-2">
                <%                    String cat = request.getParameter("category");
                    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> list = (cat == null || cat.trim().equals("all")) ? dao.getAllProducts()
                            : dao.getAllProductsById(Integer.parseInt(cat.trim()));
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> clist = cdao.getCategories();
                %>

                <div class="col-md-2">
                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action <%= (cat == null || cat.equals("all")) ? "active" : ""%>">
                            All Products
                        </a>
                        <% for (Category c : clist) {%>
                        <a href="index.jsp?category=<%= c.getCategoryId()%>" 
                           class="list-group-item list-group-item-action <%= (cat != null && cat.equals(String.valueOf(c.getCategoryId()))) ? "active" : ""%>">
                            <%= c.getCategoryTitle()%>
                        </a>
                        <% } %>
                    </div>
                </div>

                <div class="col-md-10">
                    <div class="row mt-4">
                        <% for (Product p : list) {%>
                        <div class="col-md-4 mb-4">
                            <div class="card product-card">
                                <div class="container mt-2 text-center">
                                    <img src="img/products/<%= p.getpPhoto()%>" style="max-height: 250px; max-width: 100%;" class="card-img-top" alt="Product Image">
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title"><%= p.getpName()%></h5>
                                    <p class="card-text"><%= Helper.get10Words(p.getpDesc())%></p>
                                </div>
                                <div class="card-footer d-flex justify-content-between">
                                    <button class="btn custom-bg" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>', <%= p.getPriceAfterApplyingDiscount()%>)">Add to cart</button>
                                    <button class="btn btn-outline-success">
                                        &#8377;<%= p.getPriceAfterApplyingDiscount()%>/- 
                                        <span class="text-secondary discount-label">&#8377;<%= p.getpPrice()%>, <%= p.getpDiscount()%>% off</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <% } %>
                        <% if (list.size() == 0) { %>
                        <div class="col-md-12 text-center">
                            <p class="alert alert-info">Items not available in this category.</p>
                        </div>
                        <% }%>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="components/common_modals.jsp" %>
    </body>
</html>
