class BookshelfController < ApplicationController
  
  before_filter :require_login, :only=>[:index]
  
  def get_requests
    
    render :partial => "bookshelf_books"
    
  end

  def get_modal

    puts "Getting Modal: #{params[:type]}"
    puts "Request Id: #{params["id"]}"
    puts "test #{params[:nothing].nil?}" 

    @request = Request.find(params[:id])

    if(params[:type].eql?("awaiting_response"))

      render :partial => "awaiting_response"

    elsif (params[:type].eql?("accepted_request"))

      render :partial => "accepted_request"      

    elsif (params[:type].eql?("rejected_request"))

      render :partial => "rejected_request"      

    elsif (params[:type].eql?("rejected_response"))

      render :partial => "rejected_response"      
    
    elsif (params[:type].eql?("accepted_response"))

      render :partial => "accepted_response"      

    elsif (params[:type].eql?("scheduled"))

      render :partial => "scheduled"    
        
    end



  end
  
end
