class RenameTableBillsMessages < ActiveRecord::Migration[5.0]
  def self.up
   rename_table :bills_messages, :bmessages
 end

 def self.down
   rename_table :bmessages, :bills_messages
 end

end
