class RenameLibrariesToLibraryRecords < ActiveRecord::Migration
  def up
  	# rename_table :libraries, :library_records
  	rename_column :requests, :library_id, :library_record_id
  end

  def down
  	# rename_table :library_records, :libraries
  	rename_column :requests, :library_record_id, :library_id
  end
end
