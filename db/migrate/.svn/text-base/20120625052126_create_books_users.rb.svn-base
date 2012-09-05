class CreateBooksUsers < ActiveRecord::Migration
  def up
    create_table :books_users do |t|

      t.integer :book_id
      t.integer :user_id      
    end    
  end

  def down
    drop_table :books_users
  end
end
