<%@page import="dev.hello.blog.helper.SecurityHelper"%>
<%@page import="dev.hello.blog.dao.CommentDao"%>
<%@page import="dev.hello.blog.entities.User"%>
<%@page import="dev.hello.blog.dao.LikeDao"%>
<%@page import="dev.hello.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="dev.hello.blog.helper.ConnectionProvider"%>
<%@page import="dev.hello.blog.dao.PostDao"%>

<%@page isErrorPage="false" errorPage="error_page.jsp" %>

<div class="row">

    <%

//        Thread.sleep(1500);
        PostDao postDao = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));
        int isUser = Integer.parseInt(request.getParameter("isUser"));
        String isSearch = request.getParameter("searchData").trim().toLowerCase();
//        String isSearch = "not";

        if (!isSearch.trim().equals("f_a_l_s_e")) {
            cid = (int) session.getAttribute("lastCatClick");
            isUser = (int) session.getAttribute("userDashboad");
        }

        List<Post> posts = ((isUser != -100) ? postDao.getAllPostsByUserId(isUser) : ((cid == 0) ? postDao.getAllPosts() : postDao.getPostsCatId(cid)));

        /*The data will be sorted based on what the user charges.F*/
        if (!isSearch.trim().equals("f_a_l_s_e")) {
            posts = posts.stream().filter((
                      
                post) -> {
                return post.getpTitle().toLowerCase().contains(isSearch)
                        || post.getpContent().toLowerCase().contains(isSearch)
                        || post.getpCode().toLowerCase().contains(isSearch);
            }).toList();
        }

        if (posts.isEmpty() || posts == null) {
            String text = (cid == 0) ? "No posts are available..." : "No posts in this category...";
            out.println("<h3 class='display-3 text-center'>" + text + "</h3>");
            return;
        }

        /*Save the value of the previous category for the charge to work properly.*/
        session.setAttribute("lastCatClick", cid);
        session.setAttribute("userDashboad", isUser);

        for (Post post : posts) {
    %>

    <div class="col-ms-8 col-md-4 mt-3">

        <div class="card">

            <div class="card-header p-0">
                <button  role="button" data-bs-toggle="dropdown" aria-expanded="false" 
                         style="
                         background: white;
                         border: none;
                         position: absolute;
                         top: 5px;
                         right: 5px;
                         background-color: gray;
                         border-radius: 50%;
                         width: 30px;
                         height: 30px"
                         >
                    <i class="fa fa-ellipsis-v text-white"></i></button>

                <ul class="dropdown-menu">
                    <%
                        User us = (User) session.getAttribute("currentUser");

                        if (post.getUserId() == us.getId()) {

                    %>
                    <li>
                        <button class="dropdown-item dropdown-focus disabled" >
                            <i class="fa fa-pencil"></i>
                            Edit(Coming soon)
                        </button>
                    </li>
                    <li>
                        <button class="dropdown-item dropdown-focus" onclick="deletePost(<%=post.getPid()%>)">
                            <i class="fa fa-trash"></i>
                            Delete
                        </button>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                        <%
                            }
                        %>

                    <li>
                        <button onclick="postLinkCopy('<%=SecurityHelper.encodeData(post.getPid())%>')" class="dropdown-item dropdown-focus" >
                            <i class="fa fa-link"></i>
                            Copy Link
                        </button>
                    </li>
                </ul>


                <%
                    String[] images = post.getpPics();
                    if (images != null && images.length >= 1) {

                %>
                <a href="show_blog_page.jsp?post_id=<%=SecurityHelper.encodeData(post.getPid())%>&cmn=0" >
                    <img  class="img-fluid" style=" width: 100%; height: 230px; margin: auto;  object-fit: cover;" 
                          src="blog_pic/<%=images[0]%>" 
                          onerror="this.onerror=null; this.src='blog_pic/default-image.avif';" class="card-img-top" alt="Image loading...">
                </a>
                <%

                } else {

                %>
                <a href="show_blog_page.jsp?post_id=<%=SecurityHelper.encodeData(post.getPid())%>&cmn=0" >
                    <img  class="img-fluid" style=" width: 100%; height: 230px; margin: auto;  object-fit: cover;" 
                          src="blog_pic/default-image.avif" class="card-img-top" alt="Image loading...">
                </a>

                <%                }
                %>

                <!--<img  class="img-fluid" style=" width: 100%; height: 230px; margin: auto;  object-fit: cover;" src="blog_pic/" class="card-img-top" alt="Image loading...">-->
            </div>


            <div class="card-body">

                <b><%= post.getpTitle()%></b>
                <!--<p><%= post.getpContent()%></p>-->
                <!--<pre><%= post.getpCode()%></pre>-->

            </div>

            <div class="card-footer primary_background text-center">

                <%
                    LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                    User currentUser = (User) session.getAttribute("currentUser");
                    CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());

                %>



                <a href="show_blog_page?post_id=<%=SecurityHelper.encodeData(post.getPid())%>&cmn=0" class="btn btn-outline-light btn-sm">Read more...</a>
                <button  onclick="doLike(<%=post.getPid()%>, <%= currentUser.getId()%>, this)" class="btn btn-outline-light btn-sm">
                    <i class="like-icon fa <%= likeDao.likeCss(post.getPid(), currentUser.getId())%>"></i> 
                    <span class="like-counter"><%= likeDao.countLikeOnPost(post.getPid())%></span>
                </button>
                <a href="show_blog_page?post_id=<%=SecurityHelper.encodeData(post.getPid())%>&cmn=1" class="btn btn-outline-light btn-sm">
                    <i class="fa fa-commenting-o"></i> 
                    <span><%=commentDao.countCommentOnPost(post.getPid())%></span>
                </a>
            </div>

        </div>

    </div>


    <%
        }

    %>

</div>