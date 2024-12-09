<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gegister Page | HelloBlog</title>

        <!--Bootstrap Css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <!--Icon-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!--Css-->
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>


        <style>
            .banner_background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 96%, 71% 100%, 26% 96%, 0 100%, 0 0);
            }
        </style>

    </head>
    <body>
        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>
        <!--navbar-->


        <main class="primary_background banner_background" style="padding-bottom: 90px">

            <div class="container">

                <div class="col-md-6 offset-md-3">

                    <div class="card">

                        <div class="card-header text-center primary_background text-white">

                            <span class="fa fa-3x fa-user-circle"></span>
                            <p>Register here</p>

                        </div>

                        <div class="card-body">

                            <form id="reg-form" action="RegisterServlet" method="POST">

                                <div class="mb-3">
                                    <label for="user_name" class="form-label">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter name">
                                </div>

                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                </div>


                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Password</label>
                                    <input name="user_password" type="password" class="form-control"  id="exampleInputPassword1" placeholder="Password">
                                </div>


                                <div class="mb-3">
                                    <label for="gender" >Select Gender</label>
                                    <br>
                                    <input type="radio"  id="gender" name="user_gender" value="male">Male
                                    <input type="radio"  id="gender" name="user_gender" value="female">Female
                                </div>


                                <div class="form-group mb-2">

                                    <textarea class="form-control" id="text_area" name="about" rows="5"  placeholder="Enter something about yourself"></textarea>

                                </div>



                                <div class="mb-3 form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree terms and conditions</label>
                                </div>

                                <div class="container text-center" id="loader" style="display: none">
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                    <h4>Please wait....</h4>
                                </div>

                                <button id="submit_btn" type="submit" class="btn btn-primary">Submit</button>

                            </form>

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

        <!--Sweet Alert-->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


        <script>
            $(document).ready(function () {
                console.log("loaded....");



                $("#reg-form").on('submit', function (event) {

                    event.preventDefault();


                    //---------------------------
                    $("#submit_btn").hide();
                    $("#loader").show();
                    //---------------------------

                    let form = new FormData(this);

                    //send register servlet
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);

                            //---------------------------
                            $("#submit_btn").show();
                            $("#loader").hide();
                            //---------------------------


                            if (data.trim() === 'done') {
                                swal("Registered successfully.. We are going to redirect to login page.")
                                        .then((value) => {
                                            window.location = "login_page.jsp";
                                        });
                            } else {
                                swal(data);
                            }



                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);

                            //---------------------------
                            $("#submit_btn").show();
                            $("#loader").hide();

                            swal("Something went wrong.. try again");
                            //---------------------------
                        },
                        processData: false,
                        contentType: false
                    });


                });

            });

        </script>

    </body>
</html>
