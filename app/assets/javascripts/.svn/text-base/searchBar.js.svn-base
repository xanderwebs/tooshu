/**
 * @author Dennis Li
 */
function SearchBar(searchTypeIcon, searchTypeInput, searchFieldInput, searchTypeSelectorList, resultsDiv, form){
	
	this.searchTypeIcon = document.getElementById(searchTypeIcon);
	this.searchTypeInput = document.getElementById(searchTypeInput);
	this.searchFieldInput = document.getElementById(searchFieldInput);
	this.searchTypeSelectorList = document.getElementById(searchTypeSelectorList);
	this.resultsDiv = document.getElementById(resultsDiv);
	this.form = document.getElementById(form);
	this.searchURL = "/search/searchBarSearch";
	this.queryParameter = "searchType";	
	

	var obj = this;

	if(this.searchFieldInput != null){

		this.searchFieldInput.onkeyup = function(event){
			obj.checkEnter(event);
		}

		this.searchFieldInput.onfocus = function(event){
			obj.checkEnter(event);
		}

	}

	if(this.searchTypeSelectorList != null){
	
		//Iterate through the selector list and define the on click behavior  	
		if(this.searchTypeSelectorList.hasChildNodes){
			var i = 0;
			while(i < this.searchTypeSelectorList.children.length ){

				var li = this.searchTypeSelectorList.children.item(i);
				var a = li.children.item(0);
				var icon = a.children.item(0);

				li.onclick = (function(selectType){
					return function(){
						obj.selectType(selectType);
						if(obj.searchFieldInput.value.length > 2){
							obj.search();
						}
					}
				})(icon.className)

				
				i = i+1;
			}	
		}
		
	}
}

SearchBar.prototype.checkEnter = function(event){
	//if(event.keyCode == 13){
	if(event.keyCode == 27){
		this.resultsDiv.innerHTML = "";
	}else if(this.searchFieldInput.value.length > 2){
		this.search();
	}else{
		this.resultsDiv.innerHTML = "";
	}


}

SearchBar.prototype.selectType = function(selectType){
	this.searchTypeIcon.className = selectType;
	if(selectType == "icon-user")
		this.searchTypeInput.value = "user";
	else if(selectType == "icon-book")
		this.searchTypeInput.value = "title";
	else if(selectType == "icon-search")
		this.searchTypeInput.value = "all";
	else
		this.searchTypeInput.value = "author";
}

SearchBar.prototype.search = function(){

	var xhr = new XMLHttpRequest();
 	var obj = this;

 	$('#' + this.searchFieldInput.id).offset;

 	$('#' + this.resultsDiv.id)


 	xhr.onreadystatechange = function (){
 		obj.resultsDiv.style.position = "absolute";
 		obj.resultsDiv.style.top = ($('#' + s.searchFieldInput.id).offset().top + obj.searchFieldInput.offsetHeight) + "px";
 		obj.resultsDiv.style.left = $('#' + s.searchFieldInput.id).offset().left + "px"; 		
 		if(obj.searchTypeInput.value == "user")
 			obj.resultsDiv.style.width = obj.searchFieldInput.offsetWidth + "px"; 		
 		else
 			obj.resultsDiv.style.width = (2 * obj.searchFieldInput.offsetWidth) + "px"; 		
 		obj.resultsDiv.innerHTML = xhr.responseText; 
 		

  	}

 	var url = this.searchURL + "?" + this.queryParameter + "=" + encodeURIComponent(this.searchTypeInput.value);
	url += "&searchText=" + encodeURIComponent(this.searchFieldInput.value);
	
		
		
	console.log(url);
	xhr.open("GET", url, true);
	xhr.send();
}
