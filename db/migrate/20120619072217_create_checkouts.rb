class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.integer :user_id
      t.integer :book_id
      t.date :checkout_date
      t.date :due_date
      t.boolean :returned
      t.float :deposit
      t.timestamps
    end
  end
end
