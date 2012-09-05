class Location < ActiveRecord::Base
	belongs_to :user

	validates :address1, :city, :state, :zipcode, :user_id, :is_default, :short_name, :presence => :true


	def to_s
		return "Location ID: #{self.id}\n\tAddress 1: #{self.address1}\n\tAddress 2: #{self.address2}\n\tCity: #{self.city}\n\tState: #{self.state}\n\tZip Code: #{self.zipcode}"
	end
end
