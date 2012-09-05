class RequestComment < ActiveRecord::Base

	belongs_to :request

	belongs_to :user

	validates :comment, :request_id, :user_id, :presence => :true
end