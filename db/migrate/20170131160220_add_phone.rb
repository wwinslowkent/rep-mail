class AddPhone < ActiveRecord::Migration[5.0]
  def change
    add_column :representatives, :phone, :string
  end
end
