class RenameFavoriteships < ActiveRecord::Migration
  def up
  	rename_table :favoriteships, :favorites
  	rename_column :favorites, :favorite_id, :favorite_user_id
  end

  def down
  	rename_column :favorites, :favorite_user_id, :favorite_id
  	rename_table :favorites, :favoriteships

  end
end
