class AddImgToRep < ActiveRecord::Migration[5.0]
  def change
    add_column :representatives, :image, :string, null: false
  end
end
