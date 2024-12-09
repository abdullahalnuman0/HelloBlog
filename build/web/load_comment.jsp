
<%@page import="dev.hello.blog.helper.Helper"%>
<%@page import="dev.hello.blog.helper.SecurityHelper"%>
<%@page import="dev.hello.blog.entities.User"%>
<%@page import="dev.hello.blog.dao.UserDao"%>
<%@page import="dev.hello.blog.entities.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dev.hello.blog.helper.ConnectionProvider"%>
<%@page import="dev.hello.blog.dao.CommentDao"%>
<%@page isErrorPage="false" errorPage="error_page.jsp" %>

<div class="row">

    <%
//        Thread.sleep(1500);
        // get the post id
        int postId = Integer.parseInt(request.getParameter("postId"));

        CommentDao commentDao = new CommentDao(ConnectionProvider.getConnection());

        // get all comment by post id
        ArrayList<Comment> comments = commentDao.getAllCommentByPostId(postId);

        if (comments == null || comments.isEmpty()) {
            out.println("<h3 class='display-3 text-center'>No comments are available in this post...</h3>");
            return;
        }

        UserDao userDao = new UserDao(ConnectionProvider.getConnection());

        for (Comment comment : comments) {
            User commentUser = userDao.getUserByUserId(comment.getUid());
    %>

    <div class="col-md-1">
        <img src="pics/<%=commentUser.getProfile()%>" alt="Image loading..." class="circle-img">
    </div>


    <div class="col-md-11" style="padding-left: 1px">
        <div class="card my-2 p-1">


            <span class="cmn-text"> 
                                
                <a class="cmn-ur-name" href="dashboard?name=<%= commentUser.getName()%>&uid=<%=SecurityHelper.encodeData(commentUser.getId()) %>"><%= commentUser.getName().trim()%></a> 
                <%=comment.getComText() %>
            </span>

        </div>
    </div>
    <%
        }
    %>

</div>
