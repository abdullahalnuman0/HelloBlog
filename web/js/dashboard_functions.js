

function desiganWork() {

//                $('.left-section').on('scroll', function () {
//                    $('.right-section').addClass('no-scroll');
//                });
//                $('.right-section').on('scroll', function () {
//                    $('.left-section').addClass('no-scroll');
//                });


//                --------------------------------------------------
    $(".left-section").hover(
            function () {
                // Mouse enter
                $('.left-section').removeClass('no-scroll');
                $('.right-section').addClass('no-scroll');

            },
            function () {

//                            $('.left-section').addClass('no-scroll');
//                            $('.right-section').removeClass('no-scroll');

            }
    );

    $(".right-section").hover(
            function () {
                // Mouse enter
                $('.left-section').addClass('no-scroll');
                $('.right-section').removeClass('no-scroll');
            },
            function () {

//                            $('.left-section').removeClass('no-scroll');
//                            $('.right-section').addClass('no-scroll');
            }
    );

}


let catId;
let crruntUserId;

function getAllPostData(categorieId, isUser) {

    catId = categorieId;
    crruntUserId = isUser;

    $('#loader').show();
    $('#post-container').hide();


    $.ajax({
        url: "load_posts.jsp",
        data: {
            cid: categorieId,
            isUser: isUser,
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
    $.ajax({
        url: "load_posts.jsp",
        data: {
            cid: catId,
            isUser: crruntUserId,
            searchData: "f_a_l_s_e"
        },
        success: function (data, textStatus, jqXHR) {

            $('#post-container').html(data);

        }
    });
}

//function postLinkCopy() {
//    
////    const textArea = "http://localhost:8080/HelloBlog/show_blog_page.jsp?post_id=34&cmn=0";
//    const textArea = "Alhamdulillah";
//
//    // টেক্সট সিলেক্ট করা
//    textArea.select();
//    textArea.setSelectionRange(0, 99999); // মোবাইল ডিভাইসের জন্য
//
//    // কপি করার কমান্ড
//    navigator.clipboard.writeText(textArea.value)
//            .then(() => {
//                alert("Text copied to clipboard!");
//            })
//            .catch((err) => {
//                alert("Failed to copy text: " + err);
//            });
//
//
//}

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
