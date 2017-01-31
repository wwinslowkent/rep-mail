class CreateZipCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :zipcodes do |t|
      t.string :zip, null: false
    end
  end
end
