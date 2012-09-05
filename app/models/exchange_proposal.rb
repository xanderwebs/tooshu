class ExchangeProposal < ActiveRecord::Base

	belongs_to :request

	validates :request_id, :exchange_start, :exchange_end, :location, :status, :presence => :true  

	validate :request_existence

	def request_existence
		begin
			Request.find(self.request_id)
		rescue
			errors.add(:request_id, "Request doesn't exist")
		end		
	end

	def one_acceptance		
		if  self.status.eql?("Accepted")
			eps = ExchangeProposal.find(:request_id => self.request_id)
			eps.each do |e|
				if(e.status.eql?("Accepted") && e.id != self.id)
					errors.add(:status, "Cannot accept more than exchange proposals")
				end
			end
		end
	end

	def self.one_acceptance(ep_array)
		count = 0
		ep_array.each do |ep|
			if(ep.status.eql?("Accepted"))
				count = count + 1
			end
		end

		return count <= 1

	end

	def exchange_times
		if(self.exhange_start <= exchange.end)
			errors.add(:exchange_end, "Exchange end time cannot be before exchange start time")
		end
	end

	def self.get_datetime(date, hour, min, ampm)		
		if(!date.scan(/\d\d\/\d\d\/\d\d\d\d/).empty?)
			date_array = date.scan(/\d\d/)			
			day = date_array[1].to_i
			month =  date_array[0].to_i
			year = (date_array[2] + date_array[3]).to_i
			if(ampm.eql?("pm"))
				hour = hour + 12
			end

			puts hour.to_i
			puts min.to_i
			puts day.to_i
			puts month.to_i
			puts year.to_i


			return DateTime.civil(year, month, day, hour, min, 0, 0)
		else
			return null
		end
	end

	def to_s
		return "{Request Id: #{self.request_id}, Start: #{self.exchange_start}, 
			End: #{self.exchange_end}, Location: #{self.location}, 
			Book: #{self.request.book.title}}"
	end

end
