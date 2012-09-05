class CreateApplicationFeedbacks < ActiveRecord::Migration
  def change
    create_table :application_feedbacks do |t|
      t.integer :user_id
      t.string :page
      t.text :comment
      t.timestamps
    end
  end
end
