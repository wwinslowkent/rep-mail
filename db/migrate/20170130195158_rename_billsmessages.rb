class RenameBillsmessages < ActiveRecord::Migration[5.0]
  def self.up
   rename_table :billsmessages, :bills_messages
 end

 def self.down
   rename_table :bills_messages, :billsmessages
 end
end
