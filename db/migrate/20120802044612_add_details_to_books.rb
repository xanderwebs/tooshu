class AddDetailsToBooks < ActiveRecord::Migration
  def up
    add_column :books, :synopsis, :text
    add_column :books, :cover_url, :string
    add_column :books, :link_to_amzn, :string

    books = Book.find(:all)
    books.each do |b|
    	book = AmazonCatalog.asinLookup(b.asin)
      puts book.synopsis
    	b.synopsis = book.synopsis
    	b.cover_url = book.cover_url
    	b.link_to_amzn = book.link_to_amzn
    	if b.save(:validate => false)
        puts "book saved!"
      else 
        b.errors.each do |e|
          puts "error:" + e.to_s
        end
      end
    end
  end

  def down
  	remove_column :books, :synopsis
  	remove_column :books, :cover_url
  	remove_column :books, :link_to_amzn
  end

end
