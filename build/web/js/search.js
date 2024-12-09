function searchData() {


    $('#loader').show();
    $('#post-container').hide();


    $.ajax({
        url: "load_posts.jsp",
        data: {
            cid: 0,
            isUser: 0,
            searchData: $('#searchText').val().trim()
        },
        success: function (data, textStatus, jqXHR) {

            $('#loader').hide();
            $('#post-container').show();

            $('#post-container').html(data);

        }
    });


}