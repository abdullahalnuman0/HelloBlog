/* global swal */

$(document).ready(function () {

    $('#add-post-form').on('submit', function (event) {
        // This code gets called when form is submitted
        event.preventDefault();
        console.log("Submited");

        let form = new FormData(this);

        //now requestion to server
        $.ajax({
            url: "AddPostServlet",
            type: 'POST',
            data: form,
            success: function (data, textStatus, jqXHR) {

                console.log(data);

                if (data.trim() === 'done') {
                    swal("Good job!",
                            "Post successfully!",
                            "success").then((value) => {
                        //Reset form value
                        $('#add-post-form')[0].reset();
                        // Close the modal
                        $('#add-post-modal').modal('hide');
                    });

                } else {
                    swal("Error!!",
                            "Something went wrong, try again...|",
                            "error");
                }

            },
            error: function (jqXHR, textStatus, errorThrown) {
                swal("Error!!",
                        "Something went wrong, try again...",
                        "error");
            },
            processData: false,
            contentType: false
        });

    });
});