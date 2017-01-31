class FixBillsMessages < ActiveRecord::Migration[5.0]
  def change
    drop_table :bills_messages
    
  end
end
