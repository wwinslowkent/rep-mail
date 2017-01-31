class CreateBill < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :location, null: false
      t.timestamps
    end
  end
end
