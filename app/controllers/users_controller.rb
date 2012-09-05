class UsersController < ApplicationController
  
  before_filter :require_login, :only=>[:index]
  
  def new       
    if @user.nil?
      @user = User.new()      
    end
  end
  
  def home
    current_user
    
    if(@current_user.nil?)
      redirect_to :controller=>:users, :action=>:new
    else
      redirect_to :controller=>:users, :action=>:index
    end
  end
  
  def create      
   @user = User.new(params[:user])
        
   if @user.save
     puts "successfully saved"
     flash[:notice] = "Account Created! Please Login!"
     redirect_to :controller => :login, :action => :login 
     
   else     
      render :controller => :users, :action => :new
   end
  end
  
  def index
    @user = current_user
  end
  

	before_filter :require_login, :only=>[:index]

	def new       
		if @user.nil?
			@user = User.new()      
		end
	end

	def home
		current_user

		if(@current_user.nil?)
			redirect_to :controller=>:users, :action=>:new
		else
			redirect_to :controller=>:users, :action=>:index
		end
	end

	def create      
		@user = User.new(params[:user])

		if(params[:sign_up_code].eql?("tooshualpha"))

			if @user.save
				puts "successfully saved"
				flash[:notice] = "Account Created! Please Login!"
				redirect_to :controller => :login, :action => :login 

			else     
				flash[:error] = "There were some errors in the registration fields"
				render :controller => :users, :action => :new
			end

		else
			flash[:error] = "Sorry, Tooshu is currently in alpha testing and requires a sign-up code to join. The sign up code you entered is not valid..."
			render :controller => :users, :action => :new
		end
	end

	def index
		@user = current_user
	end


	def show

		if params[:id].to_i.eql?(@current_user.id) 
			redirect_to :controller => :users, :action => :home
		else
			@user = User.find(params[:id])
		end
	end

	def edit

		#first need to ceheck that user being edited is the one that is logged in
		if params[:id].to_i.eql?(@current_user.id) 

			#set whatever tab should be active
			@active_tab = params[:active_tab]

			#the location controller redirects here if there is an error, so need to check for location parameters to pre-populate the fields		
			@location = Location.new(params[:location])				
			@location.valid? #creates the error messages to be displayed

			#This is necessary because the new method won't set the id
			if(!params[:location].nil?)
				@location.id = params[:location][:id]
			end
			
			#If this wasn't the result of a redirect, need to get the location from the database

			@user = @current_user
			if(params[:location].nil?)
				@location = @current_user.locations[0]
			end
		else
			flash[:error] = "Trying to edit a another user's information..."
			redirect_to user_path(@current_user.id)
		end
	end

	def update

		@user = User.find(params[:id])
		puts "User:" + @user.to_s



		#only the logged in user should be able to make these changes
		if(@current_user.id.eql?(@user.id))

			if(params[:user][:password].nil?)
				@user.updating_password = false #required to bypass validation

				if @user.update_attributes(params[:user])
					# success
					flash[:notice] = "Profile updated!"
					redirect_to edit_user_path(@current_user, :active_tab=>"basic")
				else

					puts "Failed to update user information..."
					@user.errors.full_messages.each do |e|
					puts e
				end

				# error handling
				flash[:error] = "Failed to update user information..."
				render :action => 'edit'
			end

			else
				@user.updating_password = true
				@active_tab = "security"
				if @user.isValid(params[:user][:old_password])

					params[:user].delete :old_password
					if @user.update_attributes(params[:user])
						# success
						flash[:notice] = "Password updated!"
						redirect_to edit_user_path(@current_user, :active_tab=>"security")
					else

						puts "Failed to update password..."
						@user.errors.full_messages.each do |e|
							puts e
						end

						# error handling
						flash[:error] = "Failed to update password..."
						render :action => 'edit', :active_tab=>"security"
						return
					end
				else
					flash[:error] = "Incorrect current password..."
					render :action => 'edit', :active_tab=>"security"
				end        
			end



		end
	end

	# Needs to be re-done w/ RESTful routing
	def books
		if params[:id].nil? || params[:id].to_i.eql?(@current_user.id) 
			@user = current_user
		else
			@user = User.find(params[:id])
		end
		@books = @user.books
	end
end
