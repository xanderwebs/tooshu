/**
 * @author Dennis Li
 */

 function RequestMessenger(){
	
	this.modal = $('<div></div>');
	this.modal.attr("id", "request_messenger_modal");
	this.modal.addClass("modal hide fade in");
	this.modal.css("display", "none");
	this.modal.appendTo("body");	

}

RequestMessenger.prototype.getRequestModal = function(requesterUserId, ownerUserId, libraryRecordId){
	var obj = this;

	$.get('/requests/modal?requesterUserId=' + requesterUserId+ "&ownerUserId=" + ownerUserId + "&libraryRecordId=" + libraryRecordId, function(data) {
			
		obj.setModalContentAndAction(data);
		
	})
}

RequestMessenger.prototype.getAcceptRejectModal = function(requestId){
	var obj = this;

	$.get('/requests/acceptRejectModal?requestId=' + requestId , function(data) {
			
		obj.setModalContentAndAction(data);
		
	})
}

RequestMessenger.prototype.getMessengerModal = function(requestId, senderId, showPreviousMessages){
	var obj = this;

	$.get('/requests/messengerModal?requestId=' + requestId + '&senderId=' + senderId + '&showPreviousMessages=' + showPreviousMessages, function(data) {
			
		obj.setModalContentAndAction(data);
		
	})
}


RequestMessenger.prototype.setModalContentAndAction = function(data){

	this.modal.html(data);

	var obj = this;

	if($('#request_button').size() > 0 ){
		$('#request_button').click(
			function(){
				$.post("/requests", $("#request_form").serialize(), function(data){
					obj.setModalContentAndAction(data);
				});				
				//window.location.reload();
			}
		);	
	}

	if($('#yes').size() > 0 ){
		$('#yes').click(
			function(){
				$.post("/requests/accept", $("#request_form").serialize(), function(data){
					obj.setModalContentAndAction(data);
				});				
			}
		);	
	}

	if($('#no').size() > 0 ){
		$('#no').click(
			function(){
				$.post("/requests/reject", $("#request_form").serialize(), function(data){
					obj.setModalContentAndAction(data);
				});				
			}
		);	
	}

	if($('#send').size() > 0 ){
		$('#send').click(
			function(){
				$.post("/requests/send", $("#request_form").serialize(), function(data){
					obj.setModalContentAndAction(data);					
				});
				window.location.reload();				
			}
		);	
	}

}