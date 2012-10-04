class LibraryRecord < ActiveRecord::Base
	belongs_to :user
	belongs_to :book
	belongs_to :request

	validates :user_id, :book_id, :presence => :true
end
