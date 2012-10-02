class Book < ActiveRecord::Base
# attr_accessible :title, :body
	has_many :checkouts
	has_many :libraries
	has_many :users, :through => :libraries

	validates :title, :asin, :presence => :true  
	validate :book_must_be_unique
	validate :match_amazon


	def book_must_be_unique

		book = Book.find_by_asin(self.asin)
		if(!book.nil?)           
			errors.add(:title, "book already exists in database")      
		end
	end

	def match_amazon

		#puts "Amazon Validation"

		book = AmazonCatalog.asinLookup(self.asin)

		#puts "Existing Book:" + self.to_s
		#puts "Amazon Book:" + book.to_s

		if(!self.title.to_s.eql?(book.title.to_s))
			errors.add(:title, "Title doesn't match Amazon db")
		end
		if(!self.author.to_s.eql?(book.author.to_s))
			errors.add(:author, "Author doesn't match Amazon db")
		end
		if(!self.isbn.to_s.eql?(book.isbn.to_s))
			errors.add(:isbn, "ISBN doesn't match Amazon db")
		end
		if(!self.ean.to_s.eql?(book.ean.to_s))
			errors.add(:ean, "EAN doesn't match Amazon db")
		end

	end

	def eql?(book)
		return self.title.eql?(book.title) &&
			self.author.eql?(book.author) &&
			self.synopsis.eql?(book.synopsis) &&
			self.isbn.eql?(book.isbn) &&
			self.ean.eql?(book.ean) &&
			self.asin.eql?(book.asin) &&
			self.thumbnail_link.eql?(book.thumbnail_link) &&
			self.cover_url.eql?(book.cover_url) &&
			self.link_to_amzn.eql?(book.link_to_amzn) 
	end

	def update_from_amazon(book)
		self.title = book.title
		self.author = book.author
		self.synopsis = book.synopsis
		self.isbn = book.isbn
		self.ean = book.ean
		self.asin = book.asin
		self.thumbnail_link = book.thumbnail_link
		self.cover_url = book.cover_url 
		self.link_to_amzn = book.link_to_amzn
		self.save(:validate=>false)
	end


	def to_s
		return "{Title: #{self.title}, Author: #{self.author}, 
			Asin: #{self.asin}, ISBN: #{self.isbn}, 
			Thumbnail Link: #{self.thumbnail_link}, link_to_amzn: #{self.link}}"
	end

end	
