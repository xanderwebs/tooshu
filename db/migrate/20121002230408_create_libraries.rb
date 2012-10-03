class CreateLibraries < ActiveRecord::Migration
  def self.up
  	rename_table :books_users, :libraries
  	remove_column :libraries, :id
  	add_column :libraries, :id, :primary_key
  end

  def self.down
  	remove_column :libraries, :id
    rename_table :libraries, :books_users
  end
end
