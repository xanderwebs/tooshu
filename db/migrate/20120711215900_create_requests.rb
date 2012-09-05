class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
			t.integer :requester_user_id
			t.integer :owner_user_id
      t.integer :book_id
			t.string :status
      t.integer :requested_days
			t.date :return_date
      t.timestamps
    end
    
    create_table :request_comments do |t|
			t.integer :request_id
			t.integer :user_id
			t.string :comment
      t.timestamps
    end
    
  end
end
