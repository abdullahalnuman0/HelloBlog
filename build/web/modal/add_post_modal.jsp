<!--add post modal-->
<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Provide the post details</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>


            <div class="modal-body">

                <form id="add-post-form" action="AddPostServlet" method="POST" enctype="multipart/form-data">

                    <div class="form-group">
                        <select class="form-control" name="cid" required>
                            <option selected disabled>---Select Category---</option>
                            <%
                                PostDao postDao = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Categorie> list = postDao.getAllCategories();

                                for (Categorie cate : list) {
                            %>
                            <option value="<%= cate.getCid()%>"><%= cate.getName()%></option>
                            <%
                                }
                            %>


                        </select>
                    </div>

                    <div class="form-group mt-3">
                        <input name="pTitle" type="text" placeholder="Enter post title" class="form-control"/>
                    </div>

                    <div class="form-group mt-2">
                        <textarea name="pContent" class="form-control" rows="7" placeholder="Enter your content"></textarea>
                    </div>


                    <div class="form-group mt-2">
                        <textarea name="pCode" class="form-control" rows="7" placeholder="Enter your program(if any)"></textarea>
                    </div>

                    <div class="form-group mt-2">

                        <label>Select your pic</label>
                        <input class="form-control" type="file" name="pPic" multiple accept=".jpeg, .jpg, .png">


                    </div>

                    <div class="container text-center mt-3">
                        <button type="submit" class="btn btn-outline-primary">Post</button>
                    </div>
                </form>

            </div>


            <!--                    <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary">Save changes</button>
                                </div>-->

        </div>
    </div>
</div>
<!--end add post modal-->