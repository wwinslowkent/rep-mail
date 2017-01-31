class CreateMessage < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :procon
      t.timestamps

    end
  end
end
