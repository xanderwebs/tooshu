class RequestsController < ApplicationController

	def create
	
		@request = Request.new(params[:request])	
		@request.status = "Awaiting Response"


		
		if(@request.save)
			puts "Request Successfully Saved"
			flash[:notice] = "Your request has been submitted!"


			request_comment = RequestComment.new(params[:request_comment])

			if(!request_comment.comment.empty?)

				request_comment.request_id = @request.id

				if(request_comment.save)
					puts "Request comment successfully saved"
				else
					puts "Failed to save request comment"
					@request.errors.each do |e|
						puts e
					end
				end

			end
			render :partial => "request_saved" 
		else

			puts "Request Failed to Save"
			@request.errors.each do |e|
				puts e
			end
			flash[:error] = "There was a problem with your request..."			



			render :partial => "request_modal" , :locals => {:requester_user_id => params[:request][:requester_user_id], :owner_user_id => params[:request][:owner_user_id] , :book_id => params[:request][:book_id]}     
		end
		
		
		#redirect_to :controller=>:users, :action=>:index
		
	end

	def update

		if(params[:type].eql?("accepted"))

			#check the location
			if params[:location].nil? || params[:location].empty?
				@request = Request.find(params[:id])
				render :partial => "bookshelf/accepted_request"
				return
			end

			#Loop through all the exchange proposals
			count = 1

			#eventually should check if all eps are valid before doing a mass save
			ep_array = Array.new
			while !params["date" + count.to_s].nil?

				ep = ExchangeProposal.new
				ep.exchange_start = ExchangeProposal.get_datetime(params["date" + count.to_s], params["hour" + count.to_s].to_i,params["minute" + count.to_s].slice(1, params["minute" + count.to_s].length).to_i, params["ampm" + count.to_s])
				ep.exchange_end = ep.exchange_start
				ep.location = params[:location]
				ep.request_id = params[:id]
				ep.status = "Open"

				


				ep_save = false
				if(ep.save)
					puts "Exchange Successfuly Saved!"

					ep_save = true
					

				else
					puts "Exchange Failed to Save"
					ep.errors.each do |e|
						puts e
					end


				end
				count = count + 1
			end

			if(ep_save)
				r = Request.find(params[:id])
				r.return_date = params[:return_date]
				r.status = "Accepted"

				if(r.save)
					puts "Request Successfuly Updated!"	

				else
					puts "Request Failed to Save"
					r.errors.each do |e|
						puts e
					end
				end
			end
			
			
		elsif(params[:type].eql?("deny"))

			r = Request.find(params[:id])
			r.status = "Rejected"
			if(r.save)
				puts "Request Denial Successfully Updated!"	
			else
				puts "Request Denial Failed to Save"
				r.errors.each do |e|
					puts e
				end
			end

			c = RequestComment.new
			c.user_id = r.owner
			c.request_id = r.id
			c.comment = params[:comment]
			r.status = "Rejected"
			if(c.save)
				puts "Request Denial Reason Successfully Updated!"	
			else
				puts "Request Denial Reason Failed to Save"
				r.errors.each do |e|
					puts e
				end
			end

		elsif(params[:type].eql?("rejected"))
			r = Request.find(params[:id])
			r.status = "Rejected Closed"
			if(r.save)
				puts "Request Closing Successfully Updated!"	
			else
				puts "Request Closing Failed to Save"
				r.errors.each do |e|
					puts e
				end
			end

		elsif(params[:type].eql?("accepted_response_schedule"))
			r = Request.find(params[:id])
			ep = ExchangeProposal.find(params[:exchange])
			ep.status = "Accepted"
			r.status = "Scheduled"

			if(r.save)
				puts "Request Scheduling Successfully Updated!"	
				if(ep.save)
					puts "Exchange Proposal Successfully Updated!"	
				else
					puts "Exchange Proposal Failed to Save"
					r.errors.each do |e|
						puts e
					end
				end
			else
				puts "Request Scheduling Failed to Save"
				r.errors.each do |e|
					puts e
				end
			end

			puts "Exchange Proposal ID: #{ep.id.to_s}"

		end
		#TODO: Need to render a json object that indicates success or failure
		render :text => r.to_s
	end

	def edit
		@r = Request.find(params[:id])

		render :partial => "awaiting_response"
	end

	def index
		requestType = params[:requestType]
		user = User.find(params[:userId])

		if(requestType.eql?("submitted"))
			requests = user.submitted_requests
		else
			requests = user.received_requests
		end

		a = Array.new
		requests.each do |r|
			h = Hash.new
			h[:request_id] = r.id
			h[:title] = r.book.title
			h[:book_id] = r.book_id
			h[:owner] = r.owner.first_name + " " + r.owner.last_name
			h[:requester] = r.requester.first_name + " " + r.requester.last_name
			h[:requester_user_id] = r.requester_user_id
			h[:return_date] = r.return_date	
			h[:requested_days] = r.requested_days
			h[:status] = r.status	
			a.push(h)
		end

		render :json => a.to_json

	end

	def get_modal
		
		render :partial => "request_modal" , :locals => {:requester_user_id => params[:requesterUserId], :owner_user_id => params[:ownerUserId] , :book_id => params[:bookId]}     
	end
	
end
