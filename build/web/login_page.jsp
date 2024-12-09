<%-- 
    Document   : login_page
    Created on : Nov 29, 2024, 3:28:01 PM
    Author     : abdullah
--%>



<%@page import="dev.hello.blog.entities.User"%>
<%@page import="dev.hello.blog.entities.Message"%>
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
        <title>Login Page | HelloBlog</title>

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

        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>
        <!--navbar-->


        <main class="d-flex align-items-center primary_background banner_background" style="height: 70vh">

            <div class="container">

                <div class="row">

                    <div class="col-md-6 offset-md-3">

                        <div class="card">

                            <div class="card-header primary_background text-white text-center">
                                <span class="fa fa-user-circle-o fa-3x"></span>
                                <h3>Login here</h3>
                            </div>

                            <%
                                Message msg = (Message) session.getAttribute("msg");

                                if (msg != null) {
                            %>
                            <div class="alert <%= msg.getCssClass()%>" role="alert">
                                <%= msg.getContent()%>
                            </div>

                            <%
                                    session.removeAttribute("msg");
                                }
                            %>



                            <div class="card-body">

                                <form action="LoginServlet" method="POST">

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label">Email address</label>
                                        <input name="user_email" required type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                        <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                    </div>


                                    <div class="mb-3">
                                        <label for="exampleInputPassword1" class="form-label">Password</label>
                                        <input name="user_password" required type="password" class="form-control" id="exampleInputPassword1">
                                    </div>


                                    <div class="container text-center">
                                        <button type="submit" class="btn btn-primary">Submit</button>
                                    </div>

                                </form>

                            </div>

                            <!--<div class="card-footer"></div>-->

                        </div>

                    </div>

                </div>

            </div>

        </main>




        <!--Bootstrap JavasCript-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!--jQuery-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

        <script src="js/myjs.js" type="text/javascript"></script>



    </body>
</html>
