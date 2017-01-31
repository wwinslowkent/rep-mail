class CreateRepresentative < ActiveRecord::Migration[5.0]
  def change
    create_table :representatives do |t|
      t.string :name, null: false
      t.string :state, null: false
      t.string :party, null: false
      t.string :czip, null: false
      t.string :address, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
