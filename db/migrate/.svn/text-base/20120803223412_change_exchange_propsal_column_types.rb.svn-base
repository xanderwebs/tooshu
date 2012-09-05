class ChangeExchangePropsalColumnTypes < ActiveRecord::Migration
  def up
  	change_table :exchange_proposals do |t|
      t.change :exchange_start, :datetime
      t.change :exchange_end, :datetime
    end
  end

  def down
  	change_table :exchange_proposals do |t|
      t.change :exchange_start, :date
      t.change :exchange_end, :date
    end
  end
end
