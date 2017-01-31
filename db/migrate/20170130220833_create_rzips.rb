class CreateRzips < ActiveRecord::Migration[5.0]
  def change
    create_table :rzips do |t|
      t.belongs_to :representative, null: false
      t.belongs_to :zipcode, null: false
    end
  end
end
