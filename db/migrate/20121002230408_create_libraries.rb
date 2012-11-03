class CreateLibraries < ActiveRecord::Migration
  def self.up
  	rename_table :books_users, :library_records
  	remove_column :library_records, :id
  	add_column :library_records, :id, :primary_key
  end

  def self.down
  	remove_column :library_records, :id
    rename_table :library_records, :books_users
  end
end
