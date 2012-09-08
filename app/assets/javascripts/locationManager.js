/**
 * @author Dennis Li
 */

 function LocationManager(){
	
	this.modal = $('<div></div>');
	this.modal.attr("id", "location_modal");
	this.modal.addClass("modal hide fade in");
	this.modal.css("display", "none");
	this.modal.appendTo("body");	
}

LocationManager.prototype.getModal = function(userId, locationId){
	var obj = this;

	console.log("and this");

	$.get('/locations/modal?userId=' + userId, function(data) {
			
		obj.setModalContentAndAction(data);		
		
		console.log("this?");
	})
}

LocationManager.prototype.setModalContentAndAction = function(data){

	this.modal.html(data);

	var obj = this;

	if($('#save_button').size() > 0 ){
		$('#save_button').click(
			function(){
				$.post("/locations", $("#location_form").serialize(), function(data){
					obj.setModalContentAndAction(data);
				});				
			}
		);	
	}

	if($('#close_button').size() > 0){
		$('#close_button').click(
			function(){
				window.location.reload();	
				console.log("should this?");	
			}
		);	
	}

}