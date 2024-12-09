function doLike(pid, uid, post) {
    console.log(pid + " " + uid);

    const d = {
        uid: uid,
        pid: pid,
        operation: 'like'
    };

    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if (data.trim() === 'true') {

                let c = $(post).find('.like-counter').text();
                console.log(c);


                if ($(post).find('.like-icon').hasClass("fa-thumbs-o-up")) {
                    $(post).find('.like-icon').removeClass("fa-thumbs-o-up");
                    $(post).find('.like-icon').addClass("fa-thumbs-up");
                    c++;
                } else {
                    $(post).find('.like-icon').removeClass("fa-thumbs-up");
                    $(post).find('.like-icon').addClass("fa-thumbs-o-up");
                    c--;
                }


                console.log(c);
                $(post).find('.like-counter').html(c);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR);
        }
    });

}

