class AddBookStatusToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :status, :string

  end
end
