class CreateBillsMessages < ActiveRecord::Migration[5.0]
    create_table :bmessages do |t|
      t.belongs_to :bill
      t.belongs_to :message
  end
end
