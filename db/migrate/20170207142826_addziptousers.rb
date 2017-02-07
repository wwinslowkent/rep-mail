class Addziptousers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :zip, :string
  end
end
