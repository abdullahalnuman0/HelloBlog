<%@page import="dev.hello.blog.entities.Message"%>
<%@page import="dev.hello.blog.helper.Helper"%>
<%@page import="dev.hello.blog.helper.SecurityHelper"%>
<%@page import="dev.hello.blog.entities.Post"%>
<%@page import="dev.hello.blog.helper.ConnectionProvider"%>

<%@page import="dev.hello.blog.entities.Categorie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dev.hello.blog.dao.PostDao"%>

<%@page import="dev.hello.blog.dao.UserDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="dev.hello.blog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    int postUserId = Integer.parseInt(
            SecurityHelper.decodeData(request.getParameter("uid"))
    );

    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login_page.jsp");
        return;

    }

    if (postUserId != user.getId()) {
        user = new UserDao(ConnectionProvider.getConnection()).getUserByUserId(postUserId);
    }
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard | <%= user.getName()%></title>

        <!--framework css-->
        <%@include file="css/framework_css.jsp" %>
        <!--framework css-->

        <style>
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

            .circle-img {
                width: 150px; /* ইমেজের প্রস্থ */
                height: 150px; /* ইমেজের উচ্চতা */
                border-radius: 50%; /* বৃত্তাকার করার জন্য */
                object-fit: cover; /* ইমেজ ঠিকভাবে প্রদর্শন */
                border: 1px solid #000; /*বর্ডার দিতে*/
            }
        </style>

    </head>
    <body>


        <!--navbar-->
        <%@include file="login_navbar.jsp" %>
        <!--navbar-->


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


        <!--main-->
        <main style="width: 100%; position: fixed">
            <!-- Main Content -->
            <div class="container-fluid ">
                <div class="row">
                    <!-- Left Section -->
                    <div class="col-md-4 left-section bg-white">

                        <div class="text-center">
                            <img src="pics/<%=user.getProfile()%>" alt="Image loading..." class="circle-img">


                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col" colspan="2">
                                            <h4 class="my-1"><%=user.getName()%></h4>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="col"> ID: </th>
                                        <td><%= user.getId()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row"> Email: </th>
                                        <td><%= user.getEmail()%></td>

                                    </tr>

                                    <tr>
                                        <th scope="row"> Gender: </th>
                                        <td><%= user.getGender().toUpperCase()%></td>

                                    </tr>

                                    <tr>
                                        <th scope="row"> Reg. on: </th>
                                        <td><%= DateFormat.getDateTimeInstance().format(user.getDateTime())%></td>

                                    </tr>

                                    <tr>
                                        <th scope="row"> Status: </th>
                                        <td><%= user.getAbout()%></td>

                                    </tr>

                                </tbody>
                            </table>
                        </div>

                    </div>

                    <!-- Right Section -->
                    <div class="col-md-8 right-section bg-light pb-5">
                        <!--posts-->
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-3x fa-spin"></i>
                            <h3 class="mt-2">Loading...</h3>
                        </div>

                        <div class="container pb-5">
                            <div class="container-fluid" id="post-container">

                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </main>
        <!--main-->



        <!--start-profile-modal-->
        <%@include file="modal/dashboard_profile_modal.jsp" %>
        <!--end-profile-modal-->


        <!--add post modal-->
        <%@include file="modal/add_post_modal.jsp" %>
        <!--end add post modal-->


        <!--JavaScript Framework-->
        <%@include file="js/framework_js.jsp" %>
        <!--JavaScript Framework-->

        <!--like function-->
        <script src="js/likejs.js" type="text/javascript"></script>


        <!--add new post javascript-->
        <script src="js/new_add_post.js"></script>
        <!--add new post javascript-->

        <!--Profile modal Edit Button control-->
        <script src="js/profile_modal_edit_btn.js"></script>


        <!--post search-->
        <script src="js/search.js"></script>



        <!--dashboard functions-->
        <script src="js/dashboard_functions.js"></script>


        <!--//post load jQuery-->
        <script>
            $(document).ready(function () {

                desiganWork();

                getAllPostData(0, <%= user.getId()%>);


            });


        </script>        


    </body>
</html>

