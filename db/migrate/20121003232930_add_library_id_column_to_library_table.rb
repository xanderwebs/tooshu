class AddLibraryIdColumnToLibraryTable < ActiveRecord::Migration
  def up
  	add_column :requests, :library_id, :integer

  	requests = Request.find(:all)
  	requests.each do |r|
  		l = Library.where(:user_id => r.owner_user_id, :book_id => r.book_id)  		
  		r.library_id = l[0].id
  		r.save
  	end

  end

  def down
  	remove_column :requests, :library_id
  end
end
