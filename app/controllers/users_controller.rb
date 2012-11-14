class UsersController < ApplicationController
  
  before_filter :require_login, :only=>[:index]
  
  def new       
    if @user.nil?
      @user = User.new()      
    end
  end
  

  def index
    @user = current_user
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
					flash[:error] = "Failed to update user information..."
					render :action => 'edit'
				end

				# error handling
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

  def requests
  	# I'm going to violate the fat model, skinny controller rule here. Need to refactor later.
  	# Also, what the heck, @books wasn't being used here at all... why is it here???
  	@user = current_user || User.find(params[:id]) # I'm not even sure if the second part is needed here.
  	
  	# So active and inactive right now just means that is whatever requests that you've made vs others.
  	# But what I think would make more sense is to have an addition of a column in the back-end so that it records
  	# WHO made the last contact, and then active would simply be requests that need response from CURRENT USER
  	# and inactive would be requests that involve current user that need the other use to respond.
  	@active_requests = Request.where('owner_user_id == ? AND status = ?', @user.id, "Awaiting Response")
  	@inactive_requests = Request.where('requester_user_id = ? AND status = ?', @user.id, "Awaiting Response")
  	@loaned = Request.where('(requester_user_id = ? OR owner_user_id = ?) AND status = ?', @user.id, @user.id, "Accepted")
  	@completed = Request.where('(requester_user_id = ? OR owner_user_id = ?) AND (status != ? AND status != ?)', @user.id, @user.id, "Awaiting Response", "Accepted")
  end
end