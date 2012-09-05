class BookPictures < ActiveRecord::Migration
  def up
  	add_column :books, :thumbnail_link, :string

	books = Book.find(:all)  	
	books.each do |b|
			bl = AmazonCatalog.asinLookup(b.asin)
			puts bl.title
			b.thumbnail_link = bl.thumbnail_link
			puts b.title
			if(b.save(:validate => false))
				"puts successfully saved"
			else
				b.errors.each do |e|
					puts "error:" + e.to_s
				end
			end
		
	end

  end

  def down
  	remove_column :books, :thumbnail_link

  end

end
