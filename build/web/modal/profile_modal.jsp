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

                            <img src="pics/<%= user.getProfile()%>" alt="profile_img" class="img-fluid" style="border-radius: 50%; width: 150px; height: 150px"/>

                            <h1 class="modal-title fs-5 mt-2" id="exampleModalLabel"><%= user.getName()%></h1>



                            <!--//Details------------>

                            <div id="profile-delails" >

                                <table class="table">

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
                                            <th scope="row"> Status: </th>
                                            <td><%= user.getAbout()%></td>

                                        </tr>

                                        <tr>
                                            <th scope="row"> Registered on: </th>
                                            <td><%= user.getDateTime().toString()%></td>

                                        </tr>

                                    </tbody>
                                </table>
                            </div>

                     
                        </div>

                    </div>


                    <div class="modal-footer">
                        <button id="close-profile" type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!--end-profile-modal-->