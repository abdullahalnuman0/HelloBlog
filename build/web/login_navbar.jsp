

<%@page import="dev.hello.blog.helper.Helper"%>
<%@page import="dev.hello.blog.helper.SecurityHelper"%>
<%@page import="dev.hello.blog.entities.User"%>
<%
    User currentUser = (User) session.getAttribute("currentUser");
%>

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

                    <a class="nav-link active" aria-current="page" href="dashboard?name=<%= currentUser.getName()%>&uid=<%=SecurityHelper.encodeData(currentUser.getId()) %>"><span class="fa fa-tachometer"></span> Dashboard</a>
                </li>



                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal"><span class="fa fa-plus"></span> Do Post</a>
                </li>


            </ul>

            <ul class="navbar-nav mr-right">
                <li class="nav-item">

                    <a class="nav-link" data-bs-toggle="modal" data-bs-target="#profile_modal" style="cursor: pointer"><span class="fa fa-user-circle"></span> <%= currentUser.getName()%></a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-times"></span> Logout</a>
                </li>
            </ul>

            <div class="d-flex">


                <!--                <form class="d-flex" role="search" >-->
                <input id="searchText" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-light" onclick="searchData()">Search</button>
                <!--</form>-->
            </div>

        </div>
    </div>
</nav>
<!--Navbar-->
