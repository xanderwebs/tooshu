class AmazonCatalog
	require 'amazon/aws/search'
	require 'cgi'
	
	include Amazon::AWS
	include Amazon::AWS::Search

	def self.getRequest
		req = Request.new('1K9YKADGHF7XP77XNGG2', 'tooshu-20')
		req.config['encoding'] = 'iso-8859-15'
		req.config['secret_key_id'] = 'kvuQYnnMWTYBUFzyK0OvF/nQpeuVYUCEy1ZbfLNQ'
		req.config['key_id'] = '1K9YKADGHF7XP77XNGG2'
		req.config['associate'] = 'tooshu-20'
		req.config['locale'] = 'us'
		req.config['cache'] = false

		req.encoding = 'iso-8859-15'
		req.locale = 'us'
		req.cache = false

		return req
	end
	
	def self.searchBooks(title, author, page=1)
	
		search_hash = Hash.new         
		search_hash['Author'] = author      
		search_hash['Title'] = title 
		search_hash['ItemPage'] = page         
		
		
		is = ItemSearch.new( 'Books', search_hash )
		is.response_group = ResponseGroup.new( 'Medium' )
		
		req = self.getRequest
		
		begin
			resp = req.search( is )
			items = resp.item_search_response.items.item
		rescue
			items = nil
		end
		
		
		books_array = Array.new
			
		if(!items.nil?)
		
			items.each do|i|        
				book = Book.new
				book = loadBookInfo(book, i)
				books_array.push(book)			
			end
		end     
		return books_array
	end
	
	def self.lookupBook(isbn_unmodified)
	
		isbn = isbn_unmodified.to_s.gsub(/-/,'')
		
		puts "ISBN: " + isbn
		
		if(isbn.length == 13)    
			il = ItemLookup.new( 'ISBN', { 'ItemId' => isbn, 'MerchantId' => 'Amazon', 'SearchIndex' => "Books" } )
		elsif(isbn.length == 10)
			il = ItemLookup.new( 'ISBN', { 'ItemId' => isbn, 'MerchantId' => 'Amazon', 'SearchIndex' => "Books" } )
			#il = ItemLookup.new( 'ASIN', { 'ItemId' => isbn} )
		else
			return nil
		end
		
		il.response_group = ResponseGroup.new( 'Medium' )
		
		req = self.getRequest
		
		
		resp = req.search( il )
		items = resp.item_lookup_response.items.item
		books_array = Array.new
		
		if(!items.nil?)					
			items.each do|i|  
				book = Book.new
				book = loadBookInfo(book, i)
				books_array.push(book)
			end
		end     
		return books_array   
	end
	
	def self.asinLookup(asin)
	
		puts "Performing Asin Lookup"
		puts asin
	
		il = ItemLookup.new( 'ASIN', { 'ItemId' => asin} )
		il.response_group = ResponseGroup.new( 'Medium' )
		
		req = self.getRequest
		
		resp = req.search( il )
		i = resp.item_lookup_response.items.item
		
		book = Book.new
		book = loadBookInfo(book, i)
		return book
		
	end

	def self.loadBookInfo(book, i)
		if(!i.item_attributes.title.nil?)
			book.title = i.item_attributes.title[0].to_s
		end
		if(!i.item_attributes.author.nil?)
			book.author = i.item_attributes.author[0].to_s
		end
		if(!i.asin.nil?)
			book.asin = i.asin[0].to_s
		end  
		if(!i.item_attributes.isbn.nil?)
			book.isbn = i.item_attributes.isbn[0].to_s
		end
		if(!i.item_attributes.ean.nil?)
			book.ean = i.item_attributes.ean[0].to_s
		end
		if(!i.editorial_reviews.nil?)
			if(!i.editorial_reviews.editorial_review[0].content.nil?)
				book.synopsis = CGI.unescapeHTML(i.editorial_reviews.editorial_review[0].content[0].to_s)
			end
		end
		if(!i.large_image.nil?)
			book.cover_url = i.large_image.url[0].to_s
		end
		if(!i.detail_page_url[0].nil?)
			book.link_to_amzn = i.detail_page_url[0].to_s
		end
		if(!i.medium_image.nil?)
			if(!i.medium_image.url.nil?)
				book.thumbnail_link = i.medium_image.url[0].to_s
			end
		end
		book
	end
end
