/**
 * ButtonEnabler shows the remove books button in the My Library section.
 * @author Alex Cheng
 */

 function ButtonAdder(){
 	var $clickable = $('#manageButton');
 	$clickable.click(function(){
 		if ($(this).html() === "Manage Library" ) {
 			$(this).html('Cancel');
 			$('.title-offset').removeClass('ti-long').addClass('ti-short');
 			$('.button-listing').removeClass('button-hide').fadeIn('slow').addClass('button-show');
 		} else {
 			$(this).html('Manage Library');
 			$('.button-listing').fadeOut('slow', function() {
 				$(this).removeClass('button-show').addClass('button-hide');
 				$('.title-offset').addClass('ti-long').removeClass('ti-short');
 			});
 		}
 	});
 }