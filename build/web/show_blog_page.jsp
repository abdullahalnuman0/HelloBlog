
<%@page import="dev.hello.blog.helper.Helper"%>
<%@page import="dev.hello.blog.helper.SecurityHelper"%>
<%@page import="dev.hello.blog.entities.Comment"%>
<%@page import="dev.hello.blog.dao.CommentDao"%>
<%@page import="dev.hello.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="dev.hello.blog.dao.UserDao"%>
<%@page import="dev.hello.blog.entities.Post"%>
<%@page import="dev.hello.blog.helper.ConnectionProvider"%>
<%@page import="dev.hello.blog.dao.PostDao"%>
<%@page import="dev.hello.blog.entities.User"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" isErrorPage="false" %>


<%
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>


<%

    int postId = Integer.parseInt(
            SecurityHelper.decodeData(request.getParameter("post_id"))
    );

    PostDao postDao = new PostDao(ConnectionProvider.getConnection());

    Post post = postDao.getPostsByPostID(postId);

    //If user click comment btn then it's word
    int openCmn = Integer.parseInt(request.getParameter("cmn"));


%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= post.getpTitle()%> | HelloBlog</title>


        <!--framework css-->
        <%@include file="css/framework_css.jsp" %>
        <!--framework css-->


        <style>

            .post-title{
                font-weight: 100;
                font-size: 30px;
            }

            .post-content{
                font-weight: 100;
                font-size: 25px;
            }

            .post-date{
                font-style: italic;
                font-weight: bold;
            }

            .post-user-info{
                font-size: 20px;
                /*font-weight: 250;*/
            }

            .row-user{
                border: 1px solid #cccccc;
                padding-top: 15px
            }
            .post-code{
                border: 1px solid #cccccc;
                overflow-x: scroll;
            }

            body{
                margin-top: 65px;
                background: url(img/bg1.jpg);
                background-size: cover;
                background-attachment: fixed;
            }

            .my-card {
                height: 90vh;  /*Full height */
                width: 66.666%; /* 8/12 = 66.666% */
                position: fixed; /* Fixed position */
                top: 50%; /* Center vertically */
                left: 50%; /* Center horizontally */
                transform: translate(-50%, -50%); /* Adjust for exact center */
            }
            .my-card-body {
                overflow-y: auto; /* Enable vertical scrolling */
            }

            /*Comment box user profile*/
            #commentBox .circle-img {
                width: 40px; /* ইমেজের প্রস্থ */
                height: 40px; /* ইমেজের উচ্চতা */
                border-radius: 50%; /* বৃত্তাকার করার জন্য */
                object-fit: cover; /* ইমেজ ঠিকভাবে প্রদর্শন */
                border: 1px solid #000; /*বর্ডার দিতে*/
            }

            #commentBox .cmn-ur-name{
                font-size: 17px;
                font-weight: bold;
            }
            #commentBox .cmn-text{
                font-size: 17px;
                font-weight: 250;
            }

            .carousel-control-prev-icon,
            .carousel-control-next-icon {
                background-color: gray; /* Change icon color */
                border-radius: 50%; /* Optional */
            }

        </style>

    </head>
    <body>

        <!--Navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary_background fixed-top" > 
            <!--bg-body-tertiary-->
            <div class="container-fluid">
                <a class="navbar-brand" href="home"><span class="fa fa-asterisk"></span>Hello Blog</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <!--                        <li class="nav-item">
                                                    <a class="nav-link active" aria-current="page" href="profile.jsp"><span class="fa fa-coffee"></span>Learn Code With Abdullah</a>
                                                </li>-->
                        <li class="nav-item">

                            <a class="nav-link active" aria-current="page" href="dashboard?name=<%= user.getName()%>&uid=<%=SecurityHelper.encodeData(user.getId())%>"><span class="fa fa-tachometer"></span> Dashboard</a>
                        </li>


                    </ul>

                    <ul class="navbar-nav mr-right">
                        <li class="nav-item">

                            <a class="nav-link" data-bs-toggle="modal" data-bs-target="#profile_modal" style="cursor: pointer"><span class="fa fa-user-circle"></span> <%= user.getName()%></a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-times"></span> Logout</a>
                        </li>
                    </ul>

                </div>
            </div>
        </nav>
        <!--Navbar-->



        <!--main content of body-->
        <main style="width: 100%; position: fixed">

            <div class="container" id="postBox">

                <div class="row">

                    <div class="col-md-8 offset-md-2">

                        <div class="card" style="height: 90vh">

                            <div class="card-header primary_background text-white">

                                <h4 class="post-title"><%= post.getpTitle()%></h4>

                            </div>

                            <!--<div class="card-body my-card-body px-0" >-->
                            <div class="card-body my-card-body" >

                                <%

                                    String[] images = post.getpPics();
                                    if (images != null && images.length >= 1) {

                                %>


                                <div id="carouselExample" class="carousel slide">
                                    <div class="carousel-inner text-center">

                                        <!--<div class="carousel-item active bg-white">-->
                                        <div class="carousel-item active ">
                                            <img src="blog_pic/<%=images[0]%>" class="img-fluid" style=" height: 270px; margin: auto" alt="...">
                                        </div>
                                        <%                                            //--------------------
                                            for (String img : images) {

                                                if (img.equals(images[0])) {
                                                    continue;
                                                }

                                        %>
                                        <!--<div class="carousel-item bg-white">-->
                                        <div class="carousel-item">
                                            <img src="blog_pic/<%= img%>" class="img-fluid" style=" height: 270px; margin: auto" alt="...">
                                        </div>
                                        <%
                                            }
                                        %>



                                    </div>
                                    <button class="carousel-control-prev"  type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon"  aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>


                                <!--                                <div class="text-center">
                                                                    <img  class="img-fluid text-center" style=" height: 230px; margin: auto" src="blog_pic/<%=post.getpPic()%>" class="card-img-top" alt="<%=post.getpPic()%>">
                                                                </div>-->
                                <%
                                    }
                                %>


                                <div class="row my-3 row-user">

                                    <div class="col-md-8">

                                        <%
                                            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                                            User post_user = userDao.getUserByUserId(post.getUserId());
                                        %>

                                        <p class="post-user-info"> <a href="dashboard?name=<%= post_user.getName()%>&uid=<%=SecurityHelper.encodeData(post_user.getId())%>"><%= post_user.getName().trim()%></a> has posted</p>
                                    </div>


                                    <div class="col-md-4">
                                        <p class="post-date"><%= DateFormat.getDateTimeInstance().format(post.getpDate())%></p>
                                    </div>

                                </div>

                                <p class="post-content"><%= post.getpContent()%></p>

                                <%
                                    if (post.getpCode() != null && !post.getpCode().isEmpty()) {
                                %>
                                
                                <div class="post-code bg-light p-2">
                                    <pre><%= post.getpCode()%></pre>
                                </div>
                                
                                <%
                                    }
                                %>


                            </div>

                            <div class="card-footer primary_background text-center">

                                <%
                                    LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                                    CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());

                                    //                                Comment comment
                                %>


                                <button  onclick="doLike(<%=post.getPid()%>, <%= user.getId()%>, this)" class="btn btn-outline-light btn-sm">
                                    <i class="like-icon fa <%= likeDao.likeCss(post.getPid(), user.getId())%>"></i> 
                                    <span class="like-counter"><%= likeDao.countLikeOnPost(postId)%></span>
                                </button>
                                <button onclick="openCommentBox()" data-bs-toggle="modal" data-bs-target="#comment-modal"  class="btn btn-outline-light btn-sm">
                                    <i class="fa fa-commenting-o"></i> 
                                    <span><%=commentDao.countCommentOnPost(post.getPid())%></span>
                                </button>
                            </div>

                        </div>


                    </div>

                </div>

            </div>


            <div class="container" id="commentBox"  style="display: none">

                <div class="row">

                    <div class="col-md-8 offset-md-2">

                        <div class="card" style="height: 90vh">

                            <div class="card-header bg-white text-black">

                                <button  onclick="closeCommentBox()"
                                         style="
                                         background: white;
                                         border: none;
                                         position: absolute;
                                         top: 5px;
                                         right: 5px;"
                                         >
                                    <i class="fa fa-times fa-2x bg-white"></i></button>

                                <div>

                                    <div class="form-group mt-2">
                                        <textarea id="comText" class="form-control" rows="1" placeholder="Type here..."></textarea>
                                    </div>
                                    <button onclick="postComment()" class="btn btn-outline-primary mt-2">Post</button>
                                </div>

                            </div>

                            <div class="card-body my-card-body bg-light">

                                <div class="container text-center" id="loader">
                                    <i class="fa fa-refresh fa-3x fa-spin"></i>
                                    <h3 class="mt-2">Loading...</h3>
                                </div>

                                <div class="pb-5">
                                    <!--<div class="container-fluid" id="comment-container">-->
                                    <div  id="comment-container">

                                    </div>
                                </div>


                            </div>



                        </div>


                    </div>

                </div>

            </div>


        </main>
        <!--main content of body-->



        <!--start-profile-modal-->
        <%@include file="modal/profile_modal.jsp" %>
        <!--end-profile-modal-->


        <!--JavaScript Framework-->
        <%@include file="js/framework_js.jsp" %>
        <!--JavaScript Framework-->

        <!--Post like js-->
        <script src="js/likejs.js"></script>



        <script>
                                        $(document).ready(function () {

                                            //------------------------------
                                            $('#profile-delails').show();
                                            $('#profile-edit').hide();
                                            //------------------------------

                                            let  editStatus = false;
                                            $('#edit-profile').click(function () {

                                                if (!editStatus) {
                                                    //------------------------------
                                                    $('#profile-delails').hide();
                                                    $('#profile-edit').show();
                                                    editStatus = !editStatus;
                                                    //------------------------------

                                                    //------------------------------
                                                    $(this).text("Update");
                                                    //------------------------------

                                                } else {
                                                    //------------------------------
                                                    $('#profile-delails').show();
                                                    $('#profile-edit').hide();
                                                    editStatus = !editStatus;
                                                    //------------------------------

                                                    //------------------------------
                                                    $(this).text("Edit");
                                                    //------------------------------
                                                }


                                            });
                                        });
        </script>


        <script>

            $(document).ready(function () {
                const isComment = <%= openCmn%>

                if (isComment === 1) {
                    console.log("Alhamdulilah");
                    openCommentBox();
                } else {
                    console.log("Hi");
                }

            });


            function closeCommentBox() {
                $('#commentBox').hide();
                $('#postBox').show();
            }



            function openCommentBox() {
                // show comment box and gone post box
                $('#commentBox').show();
                $('#postBox').hide();
                // Loader show and comment div hide
                $('#loader').show();
                $('#comment-container').hide();
                $.ajax({
                    url: "load_comment.jsp",
                    data: {
                        postId: <%= post.getPid()%>
                    },
                    success: function (data, textStatus, jqXHR) {

                        $('#loader').hide();
                        $('#comment-container').show();
                        $('#comment-container').html(data);
                    }
                });
            }


            function postComment() {

                const text = $("#comText").val();
                const d = {
                    pid: <%= post.getPid()%>,
                    uid: <%=user.getId()%>,
                    comText: text
                };

                $.ajax({
                    url: "CommentServlet",
                    data: d,
                    success: function (data, textStatus, jqXHR) {

                        console.log(data);

                        if (data.trim() === 'true') {

                            swal("Successfully comment posted");
                            $("#comText").val('');

                            ///---------------------
                            $.ajax({
                                url: "load_comment.jsp",
                                data: {
                                    postId: <%= post.getPid()%>
                                },
                                success: function (data, textStatus, jqXHR) {

                                    $('#comment-container').html(data);
                                }
                            });
                            ///---------------------


                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        swal("Something went wrong, please try again...");
                    }
                });
            }



        </script>


    </body>
</html>
