$(document).ready(function () {

    //------------------------------
    $('#profile-delails').show();
    $('#profile-edit').hide();
    //------------------------------

    let  editStatus = false;

    $('#edit-profile').click(function () {

        if (!editStatus) {
            //------------------------------
            $('#profile-delails').hide();
            $('#profile-edit').show();
            editStatus = !editStatus;
            //------------------------------

            //------------------------------
            $(this).hide();
            //------------------------------

        } else {
            //------------------------------
            $('#profile-delails').show();
            $('#profile-edit').hide();
            editStatus = !editStatus;
            //------------------------------

            //------------------------------
            $(this).show();
//            $(this).text("Edit");
            //------------------------------
        }


    });

});