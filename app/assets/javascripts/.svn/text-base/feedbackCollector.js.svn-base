/**
 * @author Dennis Li
 */

 function FeedbackCollector(modal_button, page){
	
	this.modal = $('<div></div>');
	this.modal.attr("id", "feedback_collector_modal");
	this.modal.addClass("modal hide fade in");
	this.modal.css("display", "none");
	this.modal.appendTo("body");	

	this.modalButton = $('#' + modal_button);

	this.page = page;

	var obj = this;
	this.modalButton.click(function(){obj.getModal();})

}

FeedbackCollector.prototype.getModal = function(requesterUserId, ownerUserId, bookId){
	var obj = this;

	$.get('/application_feedback/new?page=' + encodeURI(this.page),function(data) {
			
		obj.setModalContentAndAction(data);
		
	})
}

FeedbackCollector.prototype.setModalContentAndAction = function(data){

	this.modal.html(data);
	this.modal.modal();

	var obj = this;

	if($('#submit_button').size() > 0 ){
		$('#submit_button').click(
			function(){
				$.post("/application_feedback", $("#application_feedback_form").serialize(), function(data){
					obj.setModalContentAndAction(data);
				});				
			}
		);	
	}

}