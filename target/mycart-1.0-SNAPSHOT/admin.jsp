<%-- 
    Document   : admin
    Created on : Feb 27, 2025, 7:08:25 PM
    Author     : Dipak Kale
--%>

<%@page import="com.learn.mycart.entities.User"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="java.util.List"%>

<%
    User user = (User) session.getAttribute("current-user");

    if (user == null) {
        session.setAttribute("message", "You are not logged in. Login first.");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not admin.");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>

        <%@include file="components/navbar.jsp" %>

        <div class="container admin">

            <div class="container-fluid">
                <%@include file="components/message.jsp" %>
            </div>

            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <div class="container">
                                <img style="max-width: 100px;" class="img-fluid" src="" alt="">
                            </div>
                            <h1>Users</h1>
                            <h1 class="text-uppercase text-muted">Users</h1>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <div class="container">
                                <img style="max-width: 100px;" class="img-fluid" src="" alt="">
                            </div>
                            <h1>Categories</h1>
                            <h1 class="text-uppercase text-muted">Categories</h1>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <div class="container">
                                <img style="max-width: 100px;" class="img-fluid" src="" alt="">
                            </div>
                            <h1>Products</h1>
                            <h1 class="text-uppercase text-muted">Products</h1>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Second row -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="card text-center" data-toggle="modal" data-target="#add-category-model">
                        <div class="card-body">
                            <div class="container">
                                <img style="max-width: 100px;" class="img-fluid" src="" alt="">
                            </div>
                            <h1>Category</h1>
                            <h1 class="text-uppercase text-muted">Add Category</h1>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card text-center" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body">
                            <div class="container">
                                <img style="max-width: 100px;" class="img-fluid" src="" alt="">
                            </div>
                            <h1>Products</h1>
                            <h1 class="text-uppercase text-muted">Add Product</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Category Modal -->
        <div class="modal fade" id="add-category-model" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLabel">Fill Category Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">
                            <input type="hidden" name="operation" value="addcategory">
                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required />
                            </div>    

                            <div class="form-group">    
                                <textarea class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>
                            </div>

                            <div class="container text-center">
                                <button class="btn btn-outline-success" type="submit">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Add Category Modal -->

        <!-- Add Product Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="operation" value="addproduct">

                            <!-- Product Title -->
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Enter product title" name="pName" required />
                            </div>

                            <!-- Product Description -->
                            <div class="form-group">
                                <textarea class="form-control" placeholder="Enter product description" name="pDesc" required></textarea>
                            </div>

                            <!-- Product Price -->  
                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter product price" name="pPrice" required />
                            </div>



                            <!-- Product Discount -->
                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter product discount" name="pDiscount" required />
                            </div>

                            <!-- Product Quantity -->
                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Enter product quantity" name="pQuantity" required />
                            </div>


                            <!-- Product Category -->
                            <%                                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                                List<Category> categoryList = cdao.getCategories();
                            %>

                            <div class="form-group">
                                <select name="catId" class="form-control">
                                    <%
                                        for (Category c : categoryList) {
                                    %>
                                    <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <!-- Product file -->

                            <div class="form-group">

                                <label for="pPic">Select picture for product</label>
                                <br>
                                <input type="file" id="pPic" name="pPic" required />

                            </div>


                            <div class="container text-center">
                                <button class="btn btn-outline-success">Add Product</button>
                            </div>

                            <div class="modal-footer">

                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>


                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Add Product Modal -->

    </body>
</html>
