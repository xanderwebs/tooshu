class ThumbnailPlaceholderUpdate < ActiveRecord::Migration
  def up
  	books = Book.find(:all)
  	books.each do |b|  		
  		if (b.thumbnail_link.nil? || b.thumbnail_link.empty?)
  			puts "Empty placeholder found for #{b.title}"
  			b.thumbnail_link = "http://placehold.it/110x160"
  			if(b.save(:validate => false))
  				"puts successfully saved"
  			else
  				b.errors.each do |e|
					puts "error:" + e.to_s
				end
  			end
  		end
  	end
  end

  def down
  end
end
