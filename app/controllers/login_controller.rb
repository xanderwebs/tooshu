class LoginController < ApplicationController
  
  def login    
    
  end
  
  def login_post
    @user = User.find_by_email(params[:user][:email])
    #puts "User Nil?: " + @user.nil?.to_s
    #puts !@user.isValid(params[:user][:password])
    if(@user.nil? || !@user.isValid(params[:user][:password]))
      flash[:error] = "Invalid Credentials"
      render :controller=>:login, :action=>:login
    else
      session[:user_id] = @user.id
      redirect_to :controller=>:users, :action=>:index
    end
  end
  
  def logout
    reset_session
    current_user
    flash[:notice] = "You have been successfully logged out."
    render :login
  end
  
end