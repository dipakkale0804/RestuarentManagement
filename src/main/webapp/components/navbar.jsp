<%@page import="com.learn.mycart.entities.User"%>

<%
    User user1 = (User) session.getAttribute("current-user");
%>

<nav class="navbar navbar-expand-lg custom-bg">
    <div class="container">

        <div class="container-fluid">
            <!-- Restaurant Logo -->
            <a class="navbar-brand" href="index.jsp">
                <img src="img/resto2.png" alt="Restaurant Logo" width="50" height="50">
            </a>

            <!-- Mobile Menu Button -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon text-white"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <!-- Left Side Navigation -->
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link text-white" aria-current="page" href="index.jsp">Home</a>
                    </li>

                    <!-- Categories Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown"
                            aria-expanded="false">
                            Categories
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Starters</a></li>
                            <li><a class="dropdown-item" href="#">Main Course</a></li>
                            <li><a class="dropdown-item" href="#">Desserts</a></li>
                        </ul>
                    </li>
                </ul>

                <!-- Right Side (Cart & User) -->
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#" data-toggle="modal" data-target="#cart">
                            <i class="fa fa-cart-plus" style="font-size: 30px;"></i>
                            <span class="cart-items">(0)</span>
                        </a>
                    </li>

                    <% if (user1 == null) { %>
                    <!-- If User is Not Logged In -->
                    <li class="nav-item">
                        <a class="nav-link text-white" href="login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="register.jsp">Register</a>
                    </li>
                    <% } else { %>
                    <!-- If User is Logged In -->
                    <li class="nav-item">
                        <a class="nav-link text-white" href="#!"><%= user1.getUserName() %></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-white" href="LogoutServlet">Logout</a>
                    </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </div>
</nav>

<!-- Custom Styles -->
<style>
    .custom-bg {
        background: #222; /* Dark background */
    }

    .navbar-nav .nav-link {
        transition: color 0.3s ease-in-out;
    }

    .navbar-nav .nav-link:hover {
        color: #ffcc00 !important; /* Hover Color */
        text-decoration: underline;
    }

    .navbar-brand img {
        border-radius: 50%;
        object-fit: cover;
    }

    .dropdown-menu {
        border-radius: 8px;
    }
</style>
