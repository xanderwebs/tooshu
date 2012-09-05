class CreateLocation < ActiveRecord::Migration
	def change
		create_table :locations do |t|
			t.integer :user_id
			t.string :address1
			t.string :address2
			t.string :address3
			t.string :city
			t.string :state
			t.string :zipcode
			t.string :short_name
			t.boolean :is_default
			t.timestamps
		end
	end
end
