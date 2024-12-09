

let catId;

function getAllPosts(categorieId, temp) {

    $('#loader').show();
    $('#post-container').hide();

    catId = categorieId;

    //remove cll all cat---
    $('.c-link').removeClass('active');
    $('.c-link').removeClass('primary_background');
    //Click cat ---
    $(temp).addClass('active');
    $(temp).addClass('primary_background');




    $.ajax({
        url: "load_posts.jsp",
        data: {
            cid: categorieId,
            isUser: -100,
            searchData: "f_a_l_s_e"
        },
        success: function (data, textStatus, jqXHR) {

            $('#loader').hide();
            $('#post-container').show();

            $('#post-container').html(data);

        }
    });
}



function deletePost(postId) {


    console.log("Alhamdulilah");
    console.log(postId);

    $('#loader').show();

    $.ajax({
        url: "PostDeleteServlet",
        data: {
            pId: postId
        },
        success: function (data, textStatus, jqXHR) {
            console.log(data);

            $('#loader').hide();

            if (data === 'success') {
                swal("Successfully!",
                        "Post Delete",
                        "success");

                //---------------------------------------------
                reloadPost();

            } else {

                swal("Post not deleted!",
                        "Please try again",
                        "error").then((value) => {

                });
            }

        },

        error: function (jqXHR, textStatus, errorThrown) {

            $('#loader').hide();


            swal("Post not deleted!",
                    "Please try again",
                    "error").then((value) => {

            });
        }
    });

}


function reloadPost() {

    console.log($('#UserId').val());

    $.ajax({
        url: "load_posts.jsp",
        data: {
            cid: catId,
            isUser: -100,
            searchData: "f_a_l_s_e"
        },
        success: function (data, textStatus, jqXHR) {

            $('#post-container').html(data);

        }
    });
}


function postLinkCopy(postId) {

    const link = "http://localhost:8080/HelloBlog/show_blog_page?post_id=" + postId + "&cmn=0";

    navigator.clipboard.writeText(link)
            .then(() => {

                swal("Post link copied!",
                        "Please share the post",
                        "success");

            })
            .catch(err => {

                swal("Link copied failed!",
                        err,
                        "error");

            });
}
