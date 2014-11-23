jQuery(document).ready(function() {


/* Message Boxes */
/* -------------------------------------------------------------------- */

jQuery('.box-close-btn').on('click', function() {
    jQuery(this).parent().fadeOut(300);
    return false;

});


/* Tabs */
/* -------------------------------------------------------------------- */

jQuery(".rohitink-tabs").tabs();




jQuery(".rohitink-toggle-title").click(function () {
	if(jQuery(this).hasClass('active-toggle')) {
		jQuery(this).removeClass('active-toggle');
    	jQuery(this).siblings('.rohitink-toggle-pane').slideUp(200);
	} else {
		jQuery(this).addClass('active-toggle');
    jQuery(this).siblings('.rohitink-toggle-pane').slideDown(200);
	}

});

});