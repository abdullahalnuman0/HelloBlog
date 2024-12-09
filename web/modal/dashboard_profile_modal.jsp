

<%@page import="dev.hello.blog.entities.User"%>
<%
    User currentUserModal = (User) session.getAttribute("currentUser");
%>

<!--start-profile-modal-->
<!-- Modal -->
<div class="modal fade" id="profile_modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header primary_background text-white">
                <h1 class="modal-title fs-5" id="exampleModalLabel">HelloBlog</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>


            <div class="modal-body">

                <div class="container text-center">

                    <img src="pics/<%= currentUserModal.getProfile()%>" alt="profile_img" class="img-fluid" style="border-radius: 50%; width: 150px; height: 150px"/>

                    <h1 class="modal-title fs-5 mt-2" id="exampleModalLabel"><%= currentUserModal.getName()%></h1>



                    <!--//Details------------>

                    <div id="profile-delails" >

                        <table class="table">

                            <tbody>
                                <tr>
                                    <th scope="col"> ID: </th>
                                    <td><%= currentUserModal.getId()%></td>

                                </tr>
                                <tr>
                                    <th scope="row"> Email: </th>
                                    <td><%= currentUserModal.getEmail()%></td>

                                </tr>

                                <tr>
                                    <th scope="row"> Gender: </th>
                                    <td><%= currentUserModal.getGender().toUpperCase()%></td>

                                </tr>

                                <tr>
                                    <th scope="row"> Status: </th>
                                    <td><%= currentUserModal.getAbout()%></td>

                                </tr>

                                <tr>
                                    <th scope="row"> Registered on: </th>
                                    <td><%= currentUserModal.getDateTime().toString()%></td>

                                </tr>

                            </tbody>
                        </table>
                    </div>

                    <!--profile edit-->
                    <div id="profile-edit" style="display: none">

                        <h3 class="mt-2">Please edit Carefully</h3>

                        <form action="EditServlet" method="POST" enctype="multipart/form-data">

                            <table class="table">

                                <tr>
                                    <th > ID: </th>
                                    <td><%= currentUserModal.getId()%></td>

                                </tr>
                                <tr>
                                    <th > Name: </th>
                                    <td> <input class="form-control" type="text" name="user_name" value="<%= currentUserModal.getName()%>"> </td>

                                </tr>
                                <tr>
                                    <th > Email: </th>
                                    <td> <input class="form-control" type="email" name="user_email" value="<%= currentUserModal.getEmail()%>"> </td>

                                </tr>
                                <tr>
                                    <th > Password: </th>
                                    <td> <input class="form-control" type="password" name="user_password" value="<%= currentUserModal.getPassword()%>"> </td>

                                </tr>

                                <tr>
                                    <th > Gender: </th>
                                    <td><%= currentUserModal.getGender().toUpperCase()%></td>

                                </tr>

                                <tr>
                                    <th > About: </th>
                                    <td> 
                                        <textarea class="form-control" name="user_about" rows="3"><%= currentUserModal.getAbout()%></textarea>
                                    </td>

                                </tr>

                                <tr>
                                    <th > New Profile: </th>
                                    <td> <input class="form-control" type="file" name="user_image" accept=".jpeg, .jpg, .png"> </td>

                                </tr>


                            </table>

                            <!--// Update btn === EditBtn simple-->
                            <div class="container">
                                <button type="submit" class="btn btn-outline-primary" >Save</button>
                            </div>

                        </form>

                    </div>            

                </div>

            </div>


            <div class="modal-footer">
                <button id="close-profile" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button id="edit-profile" type="button" class="btn btn-primary">Edit</button>
            </div>
        </div>
    </div>
</div>
<!--end-profile-modal-->



