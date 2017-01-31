class CreateBillsMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :billsmessages do |t|
      t.belongs_to :bills, null: false
      t.belongs_to :messages, null: false
    end
  end
end
