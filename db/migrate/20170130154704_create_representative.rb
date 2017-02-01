class CreateRepresentative < ActiveRecord::Migration[5.0]
  def change
    create_table :representatives do |t|
      t.string :name, null: false
      t.string :state, null: false
      t.string :party, null: false
      t.string :address, null: false
      t.string :phone, null: false
      t.string :website, null: false
      t.string :image, null: false
      t.timestamps
    end
  end
end
