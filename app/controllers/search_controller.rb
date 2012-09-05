class SearchController < ApplicationController
	def searchBarSearch
	    searchType = params[:searchType]

	    
	    a = Array.new

	    if searchType.eql?("user")
	    	@users = User.find(:all, :conditions=> ["lower(first_name) like :st or lower(last_name) like :st", {:st => "%" + params[:searchText].downcase + "%"}])	    	
	    elsif searchType.eql?("title")
	    	@books = Book.find(:all, :conditions=> ["lower(title) like :st", {:st => "%" + params[:searchText].downcase + "%"}])	    	
	    elsif searchType.eql?("author")
			@authors = Book.find(:all, :conditions=> ["lower(author) like :st", {:st => "%" + params[:searchText].downcase + "%"}])			
	    elsif searchType.eql?("all")
	    	@users = User.find(:all, :conditions=> ["lower(first_name) like :st or lower(last_name) like :st", {:st => "%" + params[:searchText].downcase + "%"}])	
	    	@books = Book.find(:all, :conditions=> ["lower(title) like :st", {:st => "%" + params[:searchText].downcase + "%"}])	
			@authors = Book.find(:all, :conditions=> ["lower(author) like :st", {:st => "%" + params[:searchText].downcase + "%"}])			
	    end

	    render :partial => "searchBarResults"
	    

	end

end