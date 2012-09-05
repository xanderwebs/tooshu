/**
 * @author Dennis Li
 */
/*function BookshelfManager(awaitingResponseModal, acceptedRequestModal, acceptedResponseModal, rejectedResponseModal){
	this.awaitingResponseModal = awaitingResponseModal;
	this.acceptedRequestModal = acceptedRequestModal;
	this.acceptedResponseModal = acceptedResponseModal;
	this.rejectedResponseModal = rejectedResponseModal;

	
	
}*/

function BookshelfManager(ul){
	this.ul = document.getElementById(ul);
	//this.modal = document.getElementById(modal);

	this.modal = $('<div></div>');
	this.modal.attr("id", "bookshelf_modal");
	this.modal.addClass("modal hide fade in");
	this.modal.css("display", "none");
	this.modal.appendTo("body");

	this.getBooks();
	
	

}

BookshelfManager.prototype.getBooks = function(){

	//get all the li's
	var obj = this;
	$.get('/bookshelf', function(data) {

		//display all the li's
		obj.ul.innerHTML = data;

		//iterate through each li and set the onclick to trigger the right modal to pop up
		$.each($('li[class~="awaiting"]'), function(index,value){			
			var li = $('#' + value.id);
			li.attr("data-toggle", "modal");
			li.attr("href", "#bookshelf_modal");
			li.click(function(){obj.getModal(value.id.substring(11,value.id.length), "awaiting_response");});
			
		});
		

		$.each($('li[class~="accepted"]'), function(index,value){			
			var li = $('#' + value.id);
			li.attr("data-toggle", "modal");
			li.attr("href", "#bookshelf_modal");
			li.click(function(){obj.getModal(value.id.substring(11,value.id.length), "accepted_response");});
			
		});

		$.each($('li[class~="rejected"]'), function(index,value){			
			var li = $('#' + value.id);
			li.attr("data-toggle", "modal");
			li.attr("href", "#bookshelf_modal");
			li.click(function(){obj.getModal(value.id.substring(11,value.id.length), "rejected_response");});
			
		});

		$.each($('li[class~="scheduled"]'), function(index,value){			
			var li = $('#' + value.id);
			li.attr("data-toggle", "modal");
			li.attr("href", "#bookshelf_modal");
			li.click(function(){obj.getModal(value.id.substring(11,value.id.length), "scheduled");});
			
		});


	});	
}

BookshelfManager.prototype.getModal = function(id, type){
	var obj = this;
	$.get('/bookshelf/modal?id=' + id + "&type=" + type, function(data) {
		
		//set the modal content
		obj.modal.html(data);

		//set the actions of the buttons for each type of modal
		if(type == "awaiting_response"){
			
			$('#awaiting_response_accept_button').click(
				function(){obj.getModal(id, "accepted_request");}
			);	

			$('#awaiting_response_deny_button').click(
				function(){obj.getModal(id, "rejected_request");}
			);		
		}		
		else if(type == "accepted_request"){
			
			$('#accepted_request_arrange_button').click(
				function(){
					$.post("/requests/" + id, $("#accepted_request_form").serialize());
					obj.getBooks();
				}
			);
			
			//Remember to refresh the bookshelf

		}
		else if(type == "rejected_request"){

			$('#rejected_request_deny_button').click(
				function(){
					$.post("/requests/" + id, $("#rejected_request_form").serialize());
					obj.getBooks();
				}
			);

		}
		else if(type == "rejected_response"){

			$('#rejected_response_nevermind_button').click(
				function(){
					$.post("/requests/" + id, $("#rejected_response_form").serialize());
					obj.getBooks();
				}
			);

		}
		else if(type == "accepted_response"){
			$('#accepted_response_schedule_button').click(
				function(){
					$.post("/requests/" + id, $("#accepted_response_form").serialize());
					obj.getBooks();
				}
			);
		}

	});

}

function ExpandingExchangeChooser(inputTable){
	this.table = $('#' + inputTable);
	this.rowCount = 0;
	this.addButton = $('<a class="btn btn-success request_button">+</a>');
	this.removeButton = $('<a class="btn btn-danger request_button">-</a>');
	this.addRow();

	var obj = this;
	this.addButton.click(function(){obj.addRow();})
	this.removeButton.click(function(){obj.removeRow();})
	
	
	

}

ExpandingExchangeChooser.prototype.addRow = function(){

	//create the new row
	var newRow = $('<tr></tr>');
	newRow.addClass('eecRow');
	var col1 = $('<td><input type"text" id="date' + (this.rowCount+1) + '" name="date' + (this.rowCount+1) + '" class="input" placeholder="7/18/12" readonly/></td>');
	var col2 = $('<td><select class="hour span1" name="hour' + (this.rowCount+1) + '"><option>12</option><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option><option>10</option><option>11</option></select></td>');
	var col3 = $('<td><select class="minute span1" name="minute' + (this.rowCount+1) + '"><option>:00</option><option>:15</option><option>:30</option><option>:45</option></select></td>');
	var col4 = $('<td><select class="minute span1" name="ampm' + (this.rowCount+1) + '"><option>am</option><option>pm</option></select></td>');
	var col5 = $('<td></td>');
	var col6 = $('<td></td>');	

	

	//Change where the add/remove buttons show up
	this.addButton.appendTo(col5);
	if(this.rowCount >= 1){
		this.removeButton.appendTo(col6);
		this.removeButton.css("display", "inline");
	}

	//append the new row to the document
	newRow.appendTo(this.table);
	col1.appendTo(newRow);
	col2.appendTo(newRow);
	col3.appendTo(newRow);
	col4.appendTo(newRow);
	col5.appendTo(newRow);	
	col6.appendTo(newRow);

	//add the datepicker controller to the date field
	$("#date" + (this.rowCount + 1)).datepicker({minDate: new Date()});

	this.rowCount = this.rowCount + 1;

}

ExpandingExchangeChooser.prototype.removeRow = function(){
	var rows = $('.eecRow');
	var a = rows[rows.length-2];
	this.addButton.appendTo(a.children[4]);
	this.removeButton.appendTo(a.children[5]);
	console.log(this.rowCount);
	if(this.rowCount == 2){
		this.removeButton.css("display", "none");
	}
	$(rows[rows.length-1]).remove();
	this.rowCount = this.rowCount - 1;
}
