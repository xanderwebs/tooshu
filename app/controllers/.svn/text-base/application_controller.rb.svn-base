class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :current_user  
  def require_login
    
    #check if the user is logged in.  If s/he isn't, redirect to login page
    if(@current_user.nil?)
      redirect_to :controller => :login, :action => :login
    end
  end
  
  def current_user
      puts "user id: #{session[:user_id]}"
      if(session[:user_id])
        @current_user ||= User.find_by_id(session[:user_id])
      else
        @current_user = nil
      end
  end
  
end
