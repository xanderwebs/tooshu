/**
 * @author Dennis Li
 */
function RequestManager(viewDiv, receivedLink, submittedLink, userId){
	
	this.viewDiv = document.getElementById(viewDiv);
	this.receivedLink = document.getElementById(receivedLink);
	this.submittedLink = document.getElementById(submittedLink);
	//this.submittedLink = $('#submittedLink');
	this.userId = userId;
	this.url = "/requests";
	this.queryParameter = "requestType";
	
	var obj = this;

	/*
	this.submittedLink.click(function(){
		obj.getRequests("submitted");		
	})
	*/
	
	this.submittedLink.onclick = function(){
		obj.getRequests("submitted");		
	}

	this.receivedLink.onclick = function(){
		obj.getRequests("received");		
	}	
	
}

RequestManager.prototype.getRequests = function(requestType){

	var obj = this;
	if(requestType == "submitted"){
		obj.receivedLink.parentNode.className="";
		obj.submittedLink.parentNode.className="active";
	}
	else{
		obj.receivedLink.parentNode.className="active";
		obj.submittedLink.parentNode.className="";
	}

	var xhr = new XMLHttpRequest();
 	
	xhr.onreadystatechange = function (){
		if (xhr.readyState==4 && xhr.status==200){
			obj.requests_array = eval( "(" + xhr.responseText + ")" );

			if(obj.requests_array.length == 0){

				if(obj.viewDiv.hasChildNodes){
					while(obj.viewDiv.childNodes.length >= 1 ){
					obj.viewDiv.removeChild(obj.viewDiv.firstChild);
					}	
				}

				var table = document.createElement('table');
				table.className = "table table-bordered";

				var tr1 = document.createElement('tr');
				table.appendChild(tr1);

				var th1 = document.createElement('td');
				if(requestType == "received")
					th1.innerHTML = "No Requests Received";
				else
					th1.innerHTML = "No Requests Submitted";
				tr1.appendChild(th1);

				obj.viewDiv.appendChild(table);	

			}
			else{

				var table = document.createElement('table');
				table.className = "table table-bordered";

				var tr1 = document.createElement('tr');
				table.appendChild(tr1);

				var th1 = document.createElement('th');
				if(requestType == "received")
					th1.innerHTML = "Requesting User";
				else
					th1.innerHTML = "Owner";
				tr1.appendChild(th1);

				var th2 = document.createElement('th');
				th2.innerHTML = "Title";
				tr1.appendChild(th2);

				var th3 = document.createElement('th');
				th3.innerHTML = "Requested Checkout Duration";
				tr1.appendChild(th3);

				var th4 = document.createElement('th');
				if(requestType == "received")
					th4.innerHTML = "Action";
				else
					th4.innerHTML = "Status";
				tr1.appendChild(th4);

				
				for(var i = 0; i < obj.requests_array.length; i++){
					tr1 = document.createElement('tr');
					table.appendChild(tr1);

					th1 = document.createElement('td');			
					if(requestType == "received")
						th1.innerHTML = obj.requests_array[i].requester;
					else
						th1.innerHTML = obj.requests_array[i].owner;

					
					tr1.appendChild(th1);

					th2 = document.createElement('td');			
					th2.innerHTML = obj.requests_array[i].title;				
					tr1.appendChild(th2);

					th3 = document.createElement('td');
					th3.innerHTML = obj.requests_array[i].requested_days + " days";				
					tr1.appendChild(th3);

					th4 = document.createElement('td');

					if(requestType == "received"){
						var a1 = document.createElement('a');
						a1.href = "#accept_dialog";
						a1.className = "btn btn-success request_button";
						a1.setAttribute("data-toggle","modal");
						a1.innerHTML = "Accept"
						th4.appendChild(a1);

						var a2 = document.createElement('a');
						a2.href = "request_dialog";
						a2.className = "btn btn-danger request_button";
						a2.setAttribute("data-toggle","modal");
						a2.innerHTML = "Deny"
						th4.appendChild(a2);	
					}
					else{
						th4.innerHTML = obj.requests_array[i].status;
					}
					
					tr1.appendChild(th4);
					
				}

				if(obj.viewDiv.hasChildNodes){
					while(obj.viewDiv.childNodes.length >= 1 ){
					obj.viewDiv.removeChild(obj.viewDiv.firstChild);
					}	
				}
				

				obj.viewDiv.appendChild(table);	
			}

			
		}
	}
	
	var url = this.url + "?" + this.queryParameter + "=" + requestType;
	url += "&userId=" + this.userId
	xhr.open("GET", url, true);
	xhr.send();
	
	return false;
}