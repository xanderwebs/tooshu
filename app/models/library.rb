class Library < ActiveRecord::Base
	belongs_to :user
	belongs_to :book, :include => { :libraries => :status }
end
