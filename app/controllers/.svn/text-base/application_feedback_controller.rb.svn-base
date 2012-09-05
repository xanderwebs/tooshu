class ApplicationFeedbackController < ApplicationController

	def new
		@page = params[:page];

		render :partial=>"new"
	end

	def create
		@application_feedback = ApplicationFeedback.new(params[:application_feedback])
		puts @application_feedback
		@application_feedback.save
		render :partial=>"create"
	end
end
