class Favorite < ActiveRecord::Base
	belongs_to :user
	belongs_to :favorite_user, :foreign_key=>"favorite_user_id", :class_name => "User"

	def self.contains_favorite?(curr, fav)
		@is_there = self.where('user_id = ?', curr).where('favorite_user_id = ?', fav).find(:all)
		!@is_there.empty?
	end

	def self.first_entry(curr, fav)
		self.where('user_id = ?', curr).where('favorite_user_id = ?', fav).find(:first)
	end
end
