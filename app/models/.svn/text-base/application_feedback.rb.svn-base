class ApplicationFeedback < ActiveRecord::Base
	validates :comment, :presence=>:true

	def to_s
		return "User Id: #{self.user_id}, Comment: #{self.comment}, Page: #{self.page}"
	end
end
