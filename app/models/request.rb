class Request < ActiveRecord::Base
	
	has_many :exchange_proposals
	has_many :request_comments 
	belongs_to :requester, :foreign_key=>"requester_user_id", :class_name=>"User"
	belongs_to :owner, :foreign_key=>"owner_user_id", :class_name=>"User"
	belongs_to :book
	belongs_to :library_record
	
	validates :requester_user_id, 
		:owner_user_id, 
		:book_id, 
		:status, 
		:requested_days, 
		:library_record_id, 
		:presence => :true  
	validate :owner_existence
	validate :book_existence
	validate :requester_existence


	def return_date=(date)
		puts "Valid Date: " + (!date.scan(/\d\d\/\d\d\/\d\d\d\d/).empty?).to_s
		if(!date.scan(/\d\d\/\d\d\/\d\d\d\d/).empty?)
			date_array = date.scan(/\d\d/)
			(puts date_array[2] + date_array[3]).to_i
			puts date_array[1].to_i
			puts date_array[0].to_i
			super(date_array[1].to_s + "/"  + date_array[0].to_s + "/" + (date_array[2] + date_array[3]).to_s)			
		end
	end

	
	def owner_existence
		begin
			User.find(self.owner_user_id)
		rescue
			errors.add(:owner_user_id, "Owner doesn't exist")
		end		
	end
	
	def requester_existence
		begin
			User.find(self.requester_user_id)
		rescue
			errors.add(:requester_user_id, "Requester doesn't exist")
		end		
	end
	
	def book_existence
		begin
			User.find(self.owner_user_id).books.each do |b|
				if(b.id.eql?(self.book_id))
					return
				end
			end
			errors.add(:book_id, "User doesn't own that book")
		rescue
			errors.add(:book_id, "User doesn't own that book")
		end		
	end

	def to_s
		return "{requester_user_id: #{requester_user_id}, owner_user_id: #{owner_user_id}, book_id: #{book_id}, return_date: #{return_date}}"
	end

	#TODO: validate date is in the future
	
end
