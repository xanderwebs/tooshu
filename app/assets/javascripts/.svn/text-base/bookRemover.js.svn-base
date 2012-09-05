/**
 * @author Dennis Li
 */
function BookRemover(user_id){
	
	this.modal = $('<div></div>');
	this.modal.attr("id", "remove_book_modal");
	this.modal.addClass("modal hide fade in");
	this.modal.css("display", "none");
	this.modal.appendTo("body");	

	this.userId = user_id;

}

BookRemover.prototype.getModal = function(bookId){
	var obj = this;

	$.get('/books/removeModal?userId=' + this.userId + "&bookId=" + bookId, function(data) {
			
		obj.setModalContentAndAction(data);
		
	})
}

BookRemover.prototype.setModalContentAndAction = function(data){

	this.modal.html(data);
	if (this.modal.css("display") == "none"){
		this.modal.toggle();
	}
	
	var obj = this;

	if($('#remove_book_remove_button').size() > 0 ){
		$('#remove_book_remove_button').click(
			function(){
				$.post("/books/remove", $("#remove_form").serialize(), function(data){
					obj.setModalContentAndAction(data);
				});				
			}
		);	
	}

	if($('#remove_saved_close').size() > 0 ){
		$('#remove_saved_close').click(
			function(){
				window.location.reload();
			}
		);	
	}

}