/**
 * @author Dennis Li
 */

 function RequestMaker(){
	
	this.modal = $('<div></div>');
	this.modal.attr("id", "request_maker_modal");
	this.modal.addClass("modal hide fade in");
	this.modal.css("display", "none");
	this.modal.appendTo("body");	

}

RequestMaker.prototype.getModal = function(requesterUserId, ownerUserId, bookId){
	var obj = this;

	$.get('/requests/modal?requesterUserId=' + requesterUserId+ "&ownerUserId=" + ownerUserId + "&bookId=" + bookId, function(data) {
			
		obj.setModalContentAndAction(data);
		/*
		//set the modal content
		obj.modal.html(data);

		//set the actions of the buttons for each type of modal		
		
		$('#request_button').click(
			function(){
				$.post("/requests", $("#request_form").serialize(), function(data){
					obj.modal.html(data);					
				});				
			}
		);	
		*/
		
	})
}

RequestMaker.prototype.setModalContentAndAction = function(data){

	this.modal.html(data);

	var obj = this;

	if($('#request_button').size() > 0 ){
		$('#request_button').click(
			function(){
				$.post("/requests", $("#request_form").serialize(), function(data){
					obj.setModalContentAndAction(data);
				});				
			}
		);	
	}

}