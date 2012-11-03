class AddBookStatusToLibraries < ActiveRecord::Migration
  def self.up
    add_column :library_records, :status, :string
    LibraryRecord.find(:all).each do |l|
    	l.status = "Available"
    end
  end

  def self.down
  	remove_column :library_records, :status
  end
end
