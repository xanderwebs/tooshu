class AddBookStatusToLibraries < ActiveRecord::Migration
  def self.up
    add_column :libraries, :status, :string
    Library.find(:all).each do |l|
    	l.status = "Available"
    end
  end

  def self.down
  	remove_column :libraries, :status
  end
end
