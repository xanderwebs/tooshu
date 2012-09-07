/**
 * @author Dennis Li
 */
function BookSearch(title, author, asin, isbn, ean, results, button, form){
	
	this.title = document.getElementById(title);
	this.author = document.getElementById(author);
	this.asin = document.getElementById(asin);
	this.isbn = document.getElementById(isbn);
	this.ean = document.getElementById(ean);
	  
	this.results = document.getElementById(results);
	this.button = document.getElementById(button);
	this.form = document.getElementById(form);
	this.searchURL = "/books/newBooksSearch";
	this.queryParameter = "title";
	
	var obj = this;
	this.title.onkeyup = function(event){
		obj.checkEnter(event);
	}
	this.author.onkeyup = function(event){
		obj.checkEnter(event);
	}
	this.button.onclick = function(event){
		obj.search(event);
	}
}

BookSearch.prototype.checkEnter = function(event){
	if(event.keyCode == 13){
		this.button.click();	
	}
}

BookSearch.prototype.search = function(event){
	
	var xhr = new XMLHttpRequest();
 	var obj = this;
 	obj.results.innerHTML = "<div class='span12'><p class='loading-text'>loading... <img src='/assets/loading.gif' /></p></div>"

	xhr.onreadystatechange = function (){
		if (xhr.readyState==4 && xhr.status==200){

			obj.results.innerHTML = xhr.responseText;

			$.each($('a[class~="add_book_button"]'), function(index,value){			
				var a = $('#' + value.id);				
				a.click(function(){
					obj.save(value.id);
				});
				
			});

		}

	}
	
	var url = this.searchURL + "?" + this.queryParameter + "=" + encodeURIComponent(this.title.value);
	url += "&author=" + encodeURIComponent(this.author.value);
	url += "&isbn=" + encodeURIComponent(this.isbn.value);
	url += "&ean=" + encodeURIComponent(this.ean.value);
	url += "&asin=" + encodeURIComponent(this.asin.value);
		
		
		
	console.log(url);
	xhr.open("GET", url, true);
	xhr.send();
	
	return false;
}



BookSearch.prototype.save = function(asin) {
	this.asin.value = asin;
	this.form.submit();	

};
