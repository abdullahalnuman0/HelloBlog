
<%@page import="dev.hello.blog.entities.Categorie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dev.hello.blog.helper.ConnectionProvider"%>
<%@page import="dev.hello.blog.dao.PostDao"%>
<%@page import="dev.hello.blog.entities.Message"%>
<%@page import="dev.hello.blog.entities.User"%>

<%@page errorPage="error_page.jsp" isErrorPage="false"  %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>

        <!--framework css-->
        <%@include file="css/framework_css.jsp" %>
        <!--framework css-->

        <style>
            .banner_background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 93%, 71% 100%, 28% 91%, 0 100%, 0 0);
            }

            body {
                /*margin-top: 56px;  Navbar height */
                margin-top: 65px; /* Navbar height */
            }
            .left-section {
                /*height: 100vh;*/
                overflow-y: scroll;
            }
            .right-section {
                height: 100vh;
                overflow-y: scroll;
            }
            .no-scroll {
                overflow: hidden;
            }
            
            

        </style>


    </head>
    <body>

   
        <!--Navbar-->
        <%@include file="login_navbar.jsp" %>
        <!--Navbar-->

        <%            Message msg = (Message) session.getAttribute("msg");

            if (msg != null) {
        %>
        <div class="alert <%= msg.getCssClass()%>" role="alert">
            <%= msg.getContent()%>
        </div>

        <%
                session.removeAttribute("msg");
            }
        %>


        <!--start main body of the page-->

        <main style="width: 100%; position: fixed">
            <!--<div class="container">-->

            <div class="row mt-2 ">

                <div class="col-md-4 left-section no-scroll px-5 bg-white" >
                    <!--categories-->

                    <div class="list-group">
                        <a href="#" onclick="getAllPosts(0, this)" class="c-link list-group-item list-group-item-action active" aria-current="true">
                            All Posts
                        </a>

                        <%
                            PostDao d = new PostDao(ConnectionProvider.getConnection());
                            ArrayList<Categorie> list1 = d.getAllCategories();
                            for (Categorie cc : list1) {
                        %>
                        <a href="#" onclick="getAllPosts(<%= cc.getCid()%>, this)" class="c-link list-group-item list-group-item-action"><%= cc.getName()%></a>

                        <%
                            }
                        %>


                    </div>

                </div>


                <div class="col-md-8 right-section bg-light pb-5" >
                    <!--posts-->
                    <div class="container text-center" id="loader">
                        <i class="fa fa-refresh fa-3x fa-spin"></i>
                        <h3 class="mt-2">Loading...</h3>
                    </div>

                    <!--<div class="container ">-->
                    <div class="container-fluid pb-5" id="post-container">

                    </div>

                </div>

            </div>

            <!--</div>-->
        </main>

        <!--end main body of the page-->


        <!--start-profile-modal-->
        <%@include file="modal/profile_modal.jsp" %>
        <!--end-profile-modal-->


        <!--add post modal-->
        <%@include file="modal/add_post_modal.jsp" %>
        <!--end add post modal-->




        <!--framework js-->
        <%@include file="js/framework_js.jsp" %>
        <!--framework js-->

        <!--<script src="js/myjs.js" type="text/javascript"></script>-->
        <script src="js/likejs.js" type="text/javascript"></script>



        <!--Profile modal Edit Button control-->
        <!--<script src="js/profile_modal_edit_btn.js"></script>-->

        <!--// now add post js-->
        <script src="js/new_add_post.js"></script>

        <!--post search-->
        <script src="js/search.js"></script>

        <!--profile functions-->
        <script src="js/profile_functions.js"></script>
        
        <script>
                            $(document).ready(function (e) {

                                let allPostRef = $('.c-link')[0];
                                getAllPosts(0, allPostRef);

                            });



        </script>

    </body>
</html>
