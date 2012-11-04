/**
 * ButtonEnabler shows the remove books button in the My Library section.
 * @author Alex Cheng
 */

 function ButtonAdder(){
 	var $clickable = $('#editButton');
 	$clickable.click(function(){
 		if ($(this).html() === "Edit" ) {
 			$(this).html('Cancel');
 			$('.title-offset').removeClass('ti-long').addClass('ti-short');
 			$('.button-listing').removeClass('button-hide').fadeIn('slow').addClass('button-show');
 		} else {
 			$(this).html('Edit');
 			$('.button-listing').fadeOut('slow', function() {
 				$(this).removeClass('button-show').addClass('button-hide');
 				$('.title-offset').addClass('ti-long').removeClass('ti-short');
 			});
 		}
 	});
 }