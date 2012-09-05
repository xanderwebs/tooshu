class CreateExchangeProposals < ActiveRecord::Migration
  def change
    create_table :exchange_proposals do |t|
			t.integer :request_id
			t.date :exchange_start
			t.date :exchange_end
			t.string :location
			t.string :status
      t.timestamps
    end    
  end
end
