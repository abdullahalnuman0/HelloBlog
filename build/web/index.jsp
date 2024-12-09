
<%@page import="dev.hello.blog.entities.Categorie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dev.hello.blog.dao.PostDao"%>
<%@page import="dev.hello.blog.entities.User"%>
<%@page import="dev.hello.blog.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    User user = (User) session.getAttribute("currentUser");

    if (user != null) {
        response.sendRedirect("home");
    }
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>

        <!--Bootstrap Css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <!--Icon-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!--Css-->
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>


        <style>
            .banner_background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 93%, 71% 100%, 28% 91%, 0 100%, 0 0);
            }
        </style>

    </head>
    <body>

        <!--navbar-start-->
        <%@include file="normal_navbar.jsp" %>
        <!--navbar-end-->

        <div class="container-fluid p-0 m-0">


            <div class="mb-4 p-5 text-white primary_background banner_background">

                <div class="container">
                    <h1>Welcome to HelloBlog</h1>
                    <p>Welcome to HelloBlog, the perfect platform for programmers and tech enthusiasts to share their knowledge, insights, and ideas! Whether you're a beginner exploring the basics or an expert diving into advanced concepts, HelloBlog offers a space to publish your articles, tutorials, and experiences. Engage with a community of like-minded individuals, exchange feedback, and grow together in the ever-evolving world of technology. Let your words inspire and empower others—start sharing on HelloBlog today!</p>

                    <a href="register_page" class="btn btn-outline-light btn-lg" ><span class="fa fa-external-link">&nbsp;&nbsp;</span>Start! it's Free</a>
                    <!--<button class="btn btn-outline-light btn-lg"><span class="fa fa fa-sign-in fa-spin">&nbsp;&nbsp;</span>Login</button>-->
                    <a href="login_page" class="btn btn-outline-light btn-lg"><span class="fa fa-user-circle-o fa-spin">&nbsp;&nbsp;</span>Login</a>
                </div>

            </div>

        </div>

        <!--//cards-->
        <div class="container">

            <div class="row mb-2">

                <%
                    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
                    ArrayList<Categorie> categories = postDao.getAllCategories();

                    for (Categorie categorie : categories) {
                %>

                <div class="col-md-4 mb-4">

                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%=categorie.getName()%></h5>
                            <p class="card-text"><%=categorie.getDescription()%></p>
                            <a href="home" class="btn primary_background text-white">Read more</a>
                        </div>
                    </div>

                </div>

                <% }
                %>


            </div>


        </div>


        <!--Bootstrap JavasCript-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!--jQuery-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

        <script src="js/myjs.js" type="text/javascript"></script>



    </body>
</html>
