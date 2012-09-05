class CreateFavoriteships < ActiveRecord::Migration
  def up
    create_table :favoriteships do |t|
      t.integer :user_id
      t.integer :favorite_id

      t.timestamps
    end
  end

  def down
  	drop_table :favoriteships
  end
end
