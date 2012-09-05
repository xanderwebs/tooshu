class FixHtmlSafeSynopsis < ActiveRecord::Migration
	require 'cgi'
  def up
  	books = Book.find(:all)

  	books.each do |b|
      if (!b.synopsis.nil?)
    		b.synopsis = CGI.unescapeHTML(b.synopsis)
    		if(b.save(:validate => false))
  			"puts successfully saved"
      end
		else
			b.errors.each do |e|
			 puts "error:" + e.to_s
		  end
		end

  	end

  end

  def down
  end
end
