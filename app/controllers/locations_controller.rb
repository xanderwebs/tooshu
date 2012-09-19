class LocationsController < ApplicationController

	def create
		@location = Location.new(params[:location])

		if(@location.save)

			puts "Location Successfully Saved"
			flash[:notice] = "Your location has been saved!"
			
			if(params[:from_modal])
				render :partial => "location_saved" 
			else
				redirect_to :controller=>:users, :action=>:edit, :id=>@current_user.id
			end
		else

			puts "Location Failed to Save"
			@location.errors.each do |e|
				puts "error: " + e.to_s
			end
			flash[:error] = "There was a problem saving your location..."			

			if(params[:from_modal])				
				render :partial => "location_modal" , :locals => {:user_id => @current_user.id, :location => @location}

			else
				#redirect_to :controller=>:users, :action=>:edit, :id=>@current_user.id, :active_tab => "location", :location=>@location
				redirect_to edit_user_path(@current_user, :location => params[:location], :active_tab=>"location")

			end
		end
	end

	def update

		if params[:location][:id]
			@location = Location.find(params[:location][:id])
			if(@location.update_attributes(params[:location]))
				flash[:notice] = "Your location has been saved!"
				redirect_to edit_user_path(@current_user, :location => params[:location], :active_tab=>"location")
			else
				flash[:error] = "There was a problem saving your location..."			
				redirect_to edit_user_path(@current_user, :location => params[:location], :active_tab=>"location")
			end

		else 
			flash[:error] = "There was a problem with your request..."	
			redirect_to user_path(@current_user)
		end

	end

	def get_modal
		
		if(!params[:locationId].nil?)
			location = Location.find(params[:locationId])
		end
		
		render :partial => "location_modal" , :locals => {:user_id => params[:userId], :location => location}     

	end
	

end
