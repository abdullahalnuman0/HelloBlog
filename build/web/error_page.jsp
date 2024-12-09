<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page isErrorPage="true" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry! Something went wrong</title>

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
        
        
        <div class="container text-center">
            <img class="img-fluid" src="img/error_img.png" alt="Error"/>
            <h3 class="display-3">Sorry! Something went wrong...</h3>
            
            <p><%= exception %></p>
            
            <a href="index.jsp" class="btn primary_background btn-lg text-white mt-3">Go Home</a>
        </div>
        
        
    </body>
</html>
