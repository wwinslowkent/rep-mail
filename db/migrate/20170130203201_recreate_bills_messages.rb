class RecreateBillsMessages < ActiveRecord::Migration[5.0]
  create_table :bills_messages do |t|
    t.belongs_to :bill
    t.belongs_to :message
  end
end
